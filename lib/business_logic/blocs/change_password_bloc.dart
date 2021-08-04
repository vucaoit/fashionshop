import 'dart:async';

import 'package:fashionshop/business_logic/services/firebase/authentication_service.dart';
import 'package:fashionshop/business_logic/services/firebase/firebaseDatabase.dart';
import 'package:fashionshop/business_logic/validation/form_valid.dart';
import 'package:fashionshop/views/ui/page/change_password_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ChangePasswordBloc {
  StreamController _oldPasswordController = new BehaviorSubject();
  StreamController _newPasswordController = new BehaviorSubject();
  StreamController _confirmNewPasswordController = new BehaviorSubject();

  Stream get oldPasswordStream => _oldPasswordController.stream;
  Stream get newPasswordStream => _newPasswordController.stream;
  Stream get confirmNewPasswordStream => _confirmNewPasswordController.stream;

  bool isvalidform(String oldpwd,String newpwd,String confirmNewpwd){
    if(!FormValid().isPassword(oldpwd)){
      _oldPasswordController.sink.addError("Password khong hop le");
      return false;
    }
    _oldPasswordController.sink.add("old password oke");
    if(!FormValid().isPassword(newpwd)){
      _newPasswordController.sink.addError("Password khong hop le");
      return false;
    }
    _newPasswordController.sink.add("new password oke");
    if(newpwd!=confirmNewpwd){
      _confirmNewPasswordController.sink.addError("Password no match");
      return false;
    }
    _confirmNewPasswordController.sink.add("password match");
    return true;
  }
  changepassword(BuildContext context,String oldpass,String newpass,String cofirmpass,Function onSuccess,Function(String) onError){
    FirebaseDBServices().getUserDB(FirebaseAuth.instance.currentUser!.uid).then((value){
      Map<String,dynamic> data = value.data() as Map<String,dynamic>;
      if(oldpass==data['password']){
        firebaseAuth().changePassword(context,newpass,onSuccess,onError);
      }
      else{
        onError("mat khau cu khong dung");
      }
    });
  }
}