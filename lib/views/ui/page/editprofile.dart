import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashionshop/business_logic/blocs/edit_profile_bloc.dart';
import 'package:fashionshop/business_logic/blocs/profile_bloc.dart';
import 'package:fashionshop/business_logic/dialog/loadingDialog.dart';
import 'package:fashionshop/business_logic/dialog/msgDialog.dart';
import 'package:fashionshop/business_logic/services/firebase/firebaseDatabase.dart';
import 'package:fashionshop/views/ui/page/routes.dart';
import 'package:fashionshop/views/ui/page/widget/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _editProfile();
  }

  BuildContext getContext() {
    return _editProfile().context;
  }
}

class _editProfile extends State<EditProfile> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseDBServices _dbServices = FirebaseDBServices();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  EditProfileBloc _editProfileBloc = new EditProfileBloc();
  String phone = "";
  String address = "";
  String path = "";
  bool check = false;
  bool checksdt = false;
  bool checkaddress = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    String uid = _firebaseAuth.currentUser!.uid.toString();
    _editProfileBloc.getPathImage(uid);
    _editProfileBloc.getUserinfo(uid);
    if (!check) {
      _nameController.text = _firebaseAuth.currentUser!.displayName.toString();
      _emailController.text = _firebaseAuth.currentUser!.email.toString();
      check = true;
    }
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: StreamBuilder(
                    stream: _editProfileBloc.pathStream,
                    builder: (context, snapshot) {
                      return InkWell(
                        onTap: () {
                          _editProfileBloc
                              .chooseImage()
                              .then((value) => path = value);
                          print(snapshot.data);
                        },
                        child: Container(
                          height: 90,
                          width: 90,
                          child: (snapshot.data != null)
                              ? Container(
                                  width: 90.0,
                                  height: 90.0,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: FileImage(
                                              File(snapshot.data.toString())))))
                              : StreamBuilder(
                                  stream: _editProfileBloc.urlImageStream,
                                  builder: (context, snapshot) {
                                    return CachedNetworkImage(
                                      imageUrl: (snapshot.data == null)
                                          ? "http://via.placeholder.com/200x150"
                                          : snapshot.data.toString(),
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    );
                                  },
                                ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
                  child: Column(
                    children: [
                      StreamBuilder(
                        stream: _editProfileBloc.nameStream,
                        builder: (context, snapshot) {
                          return CustomWidget().customTextFormField(
                              "Change your name",
                              _nameController,
                              snapshot,
                              Icons.person,
                              false);
                        },
                      ),
                      StreamBuilder(
                        stream: _editProfileBloc.phoneValueStream,
                        builder: (context, snapshot) {
                          if (_phoneController.text == null ||
                              _phoneController.text.isEmpty) checksdt = false;
                          if (!checksdt) {
                            _phoneController.text = snapshot.data.toString();
                            if (snapshot.data != null) checksdt = true;
                          }
                          ;
                          return StreamBuilder(
                            stream: _editProfileBloc.phoneStream,
                            builder: (context, snapshot2) {
                              return CustomWidget().customTextFormField(
                                  "Change your phone number",
                                  _phoneController,
                                  snapshot2,
                                  Icons.phone_android,
                                  false);
                            },
                          );
                        },
                      ),
                      StreamBuilder(
                        stream: _editProfileBloc.emailStream,
                        builder: (context, snapshot) {
                          return CustomWidget().customTextFormField(
                              "Change your email",
                              _emailController,
                              snapshot,
                              Icons.email,
                              false);
                        },
                      ),
                      StreamBuilder(
                        stream: _editProfileBloc.addressValueStream,
                        builder: (context, snapshot) {
                          if (_addressController.text == null ||
                              _addressController.text.isEmpty)
                            checkaddress = false;
                          if (!checkaddress) {
                            _addressController.text = snapshot.data.toString();
                            if (snapshot.data != null) checkaddress = true;
                          }
                          ;
                          return StreamBuilder(
                            builder: (context, snapshot2) {
                              return CustomWidget().customTextFormField(
                                  "Change your address",
                                  _addressController,
                                  snapshot2,
                                  Icons.location_on,
                                  false);
                            },
                            stream: _editProfileBloc.addressStream,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                    height: 50,
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Colors.black12,
                        onPressed: () {
                          _clickChangePassword();
                        },
                        child: Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.lock,
                                color: Colors.grey,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "Change password",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.normal),
                                ),
                              )
                            ],
                          ),
                        ))),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                            height: 50,
                            padding: EdgeInsets.only(left: 20, right: 20),
                            margin: EdgeInsets.only(top: 10),
                            child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                color: Colors.red,
                                onPressed: () {
                                  Navigator.pushNamed(context, profile_route);
                                },
                                child: Container(
                                  child: Text(
                                    "Cancel",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )))),
                    Expanded(
                        child: Container(
                            height: 50,
                            padding: EdgeInsets.only(left: 20, right: 20),
                            margin: EdgeInsets.only(top: 10),
                            child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                color: Colors.red,
                                onPressed: () {
                                  _clickSave(
                                      context,
                                      _editProfileBloc,
                                      _nameController,
                                      _phoneController,
                                      _emailController,
                                      _addressController);
                                },
                                child: Container(
                                  child: Text(
                                    "Save",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ))))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _clickChangePassword() {
    Navigator.pushNamed(context, change_password_route);
  }
  _clickSave(
      BuildContext context,
      EditProfileBloc editProfileBloc,
      TextEditingController nameController,
      TextEditingController phoneController,
      TextEditingController emailController,
      TextEditingController addressController) {
    if (editProfileBloc.isvalidinfo(nameController.text, phoneController.text,
        emailController.text, addressController.text)) {
      LoadingDialog.showLoadingDialog(context, 'Saving...');
      editProfileBloc.UpdateProfile(
          path,
          nameController.text,
          phoneController.text,
          emailController.text,
          addressController.text, () {
        LoadingDialog.hideLoadingDialog(context);
        Navigator.pushNamed(context, profile_route);
      }, (msg) {
        LoadingDialog.hideLoadingDialog(context);
        MsgDialog.showMsgDialog(context, "Save fail", msg);
        // show msg dialog
      });
    }
  }
}
