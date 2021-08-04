import 'dart:async';

import 'package:fashionshop/business_logic/services/firebase/authentication_service.dart';
import 'package:fashionshop/business_logic/services/firebase/firebaseDatabase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class ProfileBloc{
  StreamController _logoutStreamController = new BehaviorSubject();
  StreamController _addressController = new BehaviorSubject();
  StreamController _phoneController = new BehaviorSubject();

  Stream get logout => _logoutStreamController.stream;
  Stream get addressStream => _addressController.stream;
  Stream get phoneStream => _phoneController.stream;
  void getUser(String uid)async{
    Map<String,dynamic> user=new Map<String,dynamic>();
    await FirebaseDBServices().getUserDB(uid).then((value) {
      user=value.data() as Map<String,dynamic>;
      _addressController.sink.add(user['address']);
      _phoneController.sink.add(user['phone']);
    });
  }
  void Logout(BuildContext context){
    firebaseAuth().signOut(context);
  }

  dispose(){
    _logoutStreamController.close();
    _addressController.close();
    _phoneController.close();
  }
}