import 'package:fashionshop/business_logic/dialog/loadingDialog.dart';
import 'package:fashionshop/business_logic/services/firebase/firebaseDatabase.dart';
import 'package:fashionshop/business_logic/validation/form_valid.dart';
import 'package:fashionshop/views/ui/page/change_password_page.dart';
import 'package:fashionshop/views/ui/page/editprofile.dart';
import 'package:fashionshop/views/ui/page/routes.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'firebaseStorage_services.dart';

class firebaseAuth {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void register(String name, String phone, String email, String password,
      Function onSuccess, Function(String) onRegisterError) {
    _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((user) {
      _firebaseAuth.currentUser!.updateDisplayName(name);
      _createUser(user.user!.uid,email,password, name, phone, onSuccess, onRegisterError);
    }).catchError((err) {
      print("err: " + err.toString());
      print(email);
      _onSignUpErr(err.code, onRegisterError);
    });
  }

  void signIn(String email, String pass, Function onSuccess,
      Function(String) onSignInError) {
    _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((user) {
      onSuccess();
    }).catchError((err) {
      print("err: " + err.toString());
      onSignInError("Sign-In fail, please try again");
    });
  }

  void changePassword(BuildContext context,String newpass,Function onSuccess,Function(String) onError) async {
    await _firebaseAuth.currentUser!.updatePassword(newpass).then((value) {
      FirebaseDBServices().updatePassWord(_firebaseAuth.currentUser!.uid, newpass);
      onSuccess();
    }).catchError((err) {
      onError("Yeu cau dang nhap lai de thuc hien doi mat khau");
      signOut(context);
    });
  }
 Future<void> resetPasword(String email,Function onSuccess,Function(String) onError)async{
    await _firebaseAuth.sendPasswordResetEmail(email: email).then((value){
      onSuccess();
    }).catchError((err){onError(err);});
 }
  void updateProfile(String photoURL, String name, String phone, String email,
      String address, Function onSuccess, Function(String) onError) async {
    if (photoURL.isNotEmpty && photoURL != null) {
        await FirebaseStorageService().uploadFile("/profileimage/",
          FirebaseAuth.instance.currentUser!.uid.toString(),
          photoURL,
          () {},
          (val) {});
      await FirebaseStorageService()
          .downloadURLExample("/profileimage/",FirebaseAuth.instance.currentUser!.uid.toString())
          .then((value) async {
        await _firebaseAuth.currentUser!
            .updatePhotoURL(value)
            .then((value1) => print("change url success"))
            .catchError((err) {
          print("error :" + err);
        });
      });
    }
    await _firebaseAuth.currentUser!
        .updateDisplayName(name)
        .then((value) => print("change name success"))
        .catchError((err) {
      print("error :" + err);
    });
    await _firebaseAuth.currentUser!
        .updateEmail(email)
        .then((value) => print("change email success"))
        .catchError((err) {
      print("error :" + err.toString());
      signOut(EditProfile().getContext());
    });
    await FirebaseDBServices()
        .updateUserDB(FirebaseAuth.instance.currentUser!.uid,name,email, address, phone)
        .then((value) => print("update sdt va address success"))
        .catchError((err) => print(err.toString()));
    onSuccess();
    await FirebaseAuth.instance.currentUser!.reload();
  }

  _createUser(String userId,String email,String password, String name, String phone, Function onSuccess,
      Function(String) onRegisterError) {
    var user = Map<String, String>();
    user['email']=email;
    user['password']=password;
    user['name']=name;
    user["phone"] = phone;
    user["address"] = 'No has address, pls update';
    var ref = FirebaseFirestore.instance;
    ref.collection("users").doc(userId).set(user).then((vl) {
      print("on value: SUCCESSED");
      onSuccess();
    }).catchError((err) {
      print("err: " + err.toString());
      onRegisterError("SignUp fail, please try again");
    }).whenComplete(() {
      print("completed");
    });
  }

  ///
  void _onSignUpErr(String code, Function(String) onRegisterError) {
    print(code);
    switch (code) {
      case "ERROR_INVALID_EMAIL":
      case "ERROR_INVALID_CREDENTIAL":
        onRegisterError("Invalid email");
        break;
      case "ERROR_EMAIL_ALREADY_IN_USE":
        onRegisterError("Email has existed");
        break;
      case "ERROR_WEAK_PASSWORD":
        onRegisterError("The password is not strong enough");
        break;
      default:
        onRegisterError("SignUp fail, please try again");
        break;
    }
  }

  Future<void> signOut(BuildContext context) async {
    print("signOut");
    Navigator.pushNamed(context, login_route);
    return _firebaseAuth.signOut();
  }

  void isLogged(BuildContext context) async {
    await _firebaseAuth.authStateChanges().listen((User? user) {
      if (user == null) {
        print("user is logout");
        Navigator.pushNamed(context, login_route);
      } else {
        print('User is signed in!');
      }
    });
  }
}
