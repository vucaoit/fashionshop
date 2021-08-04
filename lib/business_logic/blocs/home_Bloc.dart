import 'dart:async';

import 'package:fashionshop/business_logic/models/product.dart';
import 'package:fashionshop/business_logic/services/firebase/firebaseDatabase.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc{
  StreamController _showslideController = new BehaviorSubject();

  Stream get showslide => _showslideController.stream;

  Future<List<String>> getList()async {
    List<String> liststr =[];
    await FirebaseDBServices().getAllList("showslide", "status").then((value){
      value.forEach((element) {liststr.add(element);});
    });
    return liststr;
  }
  Future<List<Product>> getListProduct(String condition)async {
    List<Product> liststr =[];
    await FirebaseDBServices().getListProduct(condition).then((value){
      value.forEach((element) {liststr.add(element);});
    });
    return liststr;
  }
}