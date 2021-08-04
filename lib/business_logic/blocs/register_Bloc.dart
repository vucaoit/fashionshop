import 'dart:async';

import 'package:fashionshop/business_logic/services/firebase/authentication_service.dart';
import 'package:fashionshop/business_logic/validation/form_valid.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc{
  var _firAuth = firebaseAuth();

  StreamController _nameStreamController = new BehaviorSubject();
  StreamController _phoneStreamController =  new BehaviorSubject();
  StreamController _emailStreamController = new BehaviorSubject();
  StreamController _passwordStreamController = new BehaviorSubject();

  Stream get nameStream =>_nameStreamController.stream;
  Stream get phoneStream => _phoneStreamController.stream;
  Stream get emailStream => _emailStreamController.stream;
  Stream get passwordStream => _passwordStreamController.stream;

  bool isValidInfo(String name,String phone,String email,String password){
    if(!FormValid().isName(name)){
      _nameStreamController.sink.addError("Tên không hợp lệ");
      return false;
    }
    _nameStreamController.sink.add("Name Oke");
    if(!FormValid().isPhoneNumber(phone)){
      _phoneStreamController.sink.addError("Số điện thoại không hợp lệ");
      return false;
    }
    _phoneStreamController.sink.add("Phone number oke");
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
  void Register(String name, String phone, String email, String password,
      Function onSuccess, Function(String) onError) {
    _firAuth.register(name, phone, email, password, onSuccess, onError);
  }
  void dispose(){
    _nameStreamController.close();
    _phoneStreamController.close();
    _emailStreamController.close();
    _passwordStreamController.close();
  }
}