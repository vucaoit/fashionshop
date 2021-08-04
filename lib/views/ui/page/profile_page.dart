import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashionshop/business_logic/blocs/edit_profile_bloc.dart';
import 'package:fashionshop/business_logic/blocs/profile_bloc.dart';
import 'package:fashionshop/business_logic/services/firebase/authentication_service.dart';
import 'package:fashionshop/business_logic/services/firebase/firebaseDatabase.dart';
import 'package:fashionshop/views/ui/page/routes.dart';
import 'package:fashionshop/views/ui/page/widget/bottomNavigationBar.dart';
import 'package:fashionshop/views/ui/page/widget/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProfilePage();
  }
}

class _ProfilePage extends State<ProfilePage> {
  bool isloggedin = false;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  EditProfileBloc _editProfileBloc = EditProfileBloc();
  ProfileBloc _profileBloc = ProfileBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      firebaseAuth().isLogged(context);
    });
  }
  void test() async {
    _profileBloc.getUser(FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _firebaseAuth.currentUser!.reload();
    _editProfileBloc.getPathImage(FirebaseAuth.instance.currentUser!.uid);
    test();
    return Scaffold(
      bottomNavigationBar:
          BottomNavigationBarWidget().bottomNavBar(context, "profile"),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: 4,
                  child: Container(
                    padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 90,
                          width: 90,
                          child: CircleAvatar(
                            child: StreamBuilder(
                              stream: _editProfileBloc.urlImageStream,
                              builder: (context, snapshot) {
                                return CachedNetworkImage(
                                  imageUrl: (snapshot.data == null)
                                      ? "http://via.placeholder.com/200x150"
                                      : snapshot.data.toString(),
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
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
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: CustomWidget().customText(
                              _firebaseAuth.currentUser!.displayName.toString(),
                              FontWeight.bold,
                              18,
                              Colors.black),
                        ),
                      ],
                    ),
                  )),
              Expanded(
                  flex: 9,
                  child: Container(
                    padding: EdgeInsets.only(
                        top: 20, left: 20, right: 20, bottom: 20),
                    width: double.infinity,
                    child: Container(
                      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.red)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _customItem(Icons.email, "Email",
                              _firebaseAuth.currentUser!.email.toString()),
                          StreamBuilder(
                            stream: _profileBloc.phoneStream,
                            builder: (context, snapshot) {
                              return _customItem(
                                  Icons.phone_android,
                                  "Phone Number",
                                  (snapshot.data == null)
                                      ? "update phone number"
                                      : snapshot.data.toString().trim());
                            },
                          ),
                          StreamBuilder(
                            stream: _profileBloc.addressStream,
                            builder: (context, snapshot) {
                              return _customItem(
                                  Icons.location_on,
                                  "Address",
                                  (snapshot.data == null)
                                      ? "Update your location"
                                      : snapshot.data.toString().trim());
                            },
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, edit_profile_route);
                            },
                            child: _customItem(Icons.settings, "Setting",
                                "Tap to edit profile"),
                          ),
                        ],
                      ),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Container(
                    width: 100,
                    child: OutlineButton(
                      onPressed: () {
                        firebaseAuth().signOut(context);
                      },
                      borderSide: BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: CustomWidget().customText(
                          "Log out", FontWeight.bold, 17, Colors.black),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _customItem(IconData icon, String title, String info) {
    return Container(
      height: 85,
      padding: EdgeInsets.only(top: 20, bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Icon(
                icon,
                size: 30,
              ),
            ),
          ),
          Expanded(
            flex: 9,
              child: Tooltip(
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: CustomWidget()
                          .customText(title, FontWeight.bold, 18, Colors.black),),
                      Expanded(child:  CustomWidget()
                          .customText(info, FontWeight.normal, 18, Colors.black),)
                    ],
                  ),
                ),
                message: info,
              ))
        ],
      ),
    );
  }
}
