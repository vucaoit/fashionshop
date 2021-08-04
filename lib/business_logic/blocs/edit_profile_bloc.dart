import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionshop/business_logic/services/firebase/authentication_service.dart';
import 'package:fashionshop/business_logic/services/firebase/firebaseDatabase.dart';
import 'package:fashionshop/business_logic/services/firebase/firebaseStorage_services.dart';
import 'package:fashionshop/business_logic/validation/form_valid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';

class EditProfileBloc{
  ImagePicker _imagePicker = new ImagePicker();

  StreamController _nameController = new BehaviorSubject();
  StreamController _emailController = new BehaviorSubject();
  StreamController _phoneController = new BehaviorSubject();
  StreamController _addressController = new BehaviorSubject();
  StreamController _passwordController = new BehaviorSubject();
  StreamController _pathImageController = new BehaviorSubject();
  StreamController _urlImageController = new BehaviorSubject();
  StreamController _addressValueController = new BehaviorSubject();
  StreamController _phoneValueController = new BehaviorSubject();
  final form = FormValid();

  Stream get urlImageStream => _urlImageController.stream;
  Stream get nameStream => _nameController.stream;
  Stream get emailStream => _emailController.stream;
  Stream get phoneStream => _phoneController.stream;
  Stream get addressStream => _addressController.stream;
  Stream get phoneValueStream => _phoneValueController.stream;
  Stream get addressValueStream => _addressValueController.stream;
  Stream get passwordStream => _passwordController.stream;
  Stream get pathStream => _pathImageController.stream;
  bool isvalidinfo(String name,String phone,String email,String address){
    if(!form.isName(name)){
      _nameController.sink.addError("Ten khong hop le");
      return false;
    }
    _nameController.sink.add("name oke");
    if(!form.isPhoneNumber(phone)){
      _phoneController.sink.addError("Sdt khong hop le");
      return false;
    }
    _phoneController.sink.add("phone oke");
    if(!form.isEmail(email)){
      _emailController.sink.addError("email khong hop le");
      return false;
    }
    _emailController.sink.add("emial oke");
    if(!form.isName(address)){
      _addressController.sink.addError("Dia chi khong hop le");
      return false;
    }
    _addressController.sink.add("address oke");
    return true;
  }
  dispose(){
    print("dong luong edit profile bloc");
    _nameController.close();
    _addressController.close();
    _emailController.close();
    _phoneController.close();
    _passwordController.close();
    _pathImageController.close();
    _urlImageController.close();
    _addressValueController.close();
    _phoneValueController.close();
  }
  UpdateProfile(String url,String name,String phone,String email,String address,Function onSuccess,Function(String) onError){
    firebaseAuth().updateProfile(url, name, phone, email, address,onSuccess,onError);
  }
  Future<String> chooseImage() async {
    final XFile? file =
    await _imagePicker.pickImage(source: ImageSource.gallery);
    print(file!.path);
     _pathImageController.sink.add(file.path);
    return file.path.toString();
  }
  void getPathImage(String uid)async{
    String url = "";
    await FirebaseStorageService().downloadURLExample("/profileimage/",uid).then((value) => url=value);
    _urlImageController.sink.add(url);
  }
  Future<void> getUserinfo(String uid)async{
    Map<String,dynamic> temp = Map();
     await FirebaseDBServices().getUserDB(uid).then((value) => temp=value.data() as Map<String,dynamic>);
     print(temp.toString());
     _phoneValueController.sink.add(temp['phone']);
     _addressValueController.sink.add(temp['address']);
  }
}