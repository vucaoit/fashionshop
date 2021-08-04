import 'dart:math';

import 'package:fashionshop/business_logic/models/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDBServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<DocumentSnapshot> getUserDB(String uid) async {
    final val = await users.doc(uid).get().then((value) => value);
    return val;
  }
  Future<List<Product>> getAllProduct() async {
    CollectionReference showslide =
    FirebaseFirestore.instance.collection("product");
    List<Product> listimg = [];
    await showslide.limit(10).where('status',isEqualTo: true).get().then((value){
      value.docs.forEach((element ) {
        //print(element['price']);
        listimg.add(new Product(
            name: element['name'],
            link: element['link'],
            price: element['price']));
      });
    }).catchError((err) {
      print("Error :" + err);
    });
    return listimg;
  }
  Future<List<String>> getAllList(String collection, String condition) async {
    CollectionReference showslide =
        FirebaseFirestore.instance.collection("showslide");
    List<String> listimg = [];
    await showslide.where("status", isEqualTo: true).get().then((value) {
      value.docs.forEach((element) {
        listimg.add(element['link']);
      });
    }).catchError((err) {
      print("Error :" + err);
    });
    return listimg;
  }

  Future<List<Product>> getListProduct(String condition) async {
    CollectionReference showslide =
        FirebaseFirestore.instance.collection("product");
    List<Product> listimg = [];
    await showslide.limit(10).where('status',isEqualTo: true).where(condition,isEqualTo: true).get().then((value){
      value.docs.forEach((element ) {
        //print(element['price']);
        listimg.add(new Product(
            name: element['name'],
            link: element['link'],
            price: element['price']));
      });
    }).catchError((err) {
      print("Error :" + err);
    });
    return listimg;
  }

  Future<void> updateUserDB(String uid, String name, String email,
      String address, String phone) async {
    await firestore.collection("users").doc(uid).update({
      "address": address,
      "phone": phone,
      'name': name,
      'email': email
    }).then((_) {
      print("success!");
    });
  }

  Future<void> updatePassWord(String uid, String password) async {
    await firestore
        .collection("users")
        .doc(uid)
        .update({"password": password}).then((_) {
      print("success!");
    });
  }
}
