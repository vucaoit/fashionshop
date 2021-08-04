import 'dart:async';

import 'package:fashionshop/business_logic/services/firebase/authentication_service.dart';
import 'package:fashionshop/business_logic/validation/form_valid.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class ResetPasswordBloc{
  StreamController _emailController = new BehaviorSubject();

  Stream get emailStream => _emailController.stream;
  bool isvalidemail(String email){
    if(!FormValid().isEmail(email)){
      _emailController.sink.addError("Email khong hop le");
      return false;
    }
    _emailController.sink.add("email oke");
    return true;
  }
  void sendEmail(String email,Function onSuccess,Function(String) onError)async{
   await firebaseAuth().resetPasword(email,onSuccess,onError);
  }
}