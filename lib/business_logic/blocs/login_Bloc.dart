import 'dart:async';
import 'package:fashionshop/business_logic/services/firebase/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

import '../validation/form_valid.dart';
class LoginBloc{
  var _firAuth = firebaseAuth();

  StreamController _emailStreamController = new BehaviorSubject();
  StreamController _passwordStreamController = new BehaviorSubject();

  Stream get emailStream => _emailStreamController.stream;
  Stream get passwordStream => _passwordStreamController.stream;

  bool isValidInfo(String email,String password){
    if(!FormValid().isEmail(email)){
      _emailStreamController.sink.addError("Email không hợp lê");
      return false;
    }
    _emailStreamController.add("Email oke");
    if(!FormValid().isPassword(password)){
      _passwordStreamController.sink.addError("Password phải trên 6 kí tự");
      return false;
    }
    _passwordStreamController.add("passoword oke");
    return true;
  }
  void Login(String email, String pass, Function onSuccess,
      Function(String) onSignInError) {
    _firAuth.signIn(email, pass, onSuccess, onSignInError);
  }
  void dispose(){
    _emailStreamController.close();
    _passwordStreamController.close();
  }
}