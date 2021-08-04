import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionshop/business_logic/blocs/home_Bloc.dart';
import 'package:fashionshop/business_logic/models/product.dart';
import 'package:fashionshop/business_logic/services/firebase/authentication_service.dart';
import 'package:fashionshop/business_logic/services/firebase/firebaseDatabase.dart';
import 'package:fashionshop/views/ui/page/widget/bottomNavigationBar.dart';
import 'package:fashionshop/views/ui/page/widget/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fashionshop/views/ui/page/routes.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
final homeBloc=new HomeBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar:
            BottomNavigationBarWidget().bottomNavBar(context, "home"),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(padding: EdgeInsets.only(top: 10),),
                FutureBuilder(
                  future: homeBloc.getList(),
                  builder: (context,snapshot){
                    //print("this is snapshot : "+snapshot.data.toString());
                    return CustomWidget().CustomSlide(snapshot.data as List<String>);
                  },
                ),
                Container(
                  padding: EdgeInsets.only(left: 20,right: 20,top: 20),
                  child: Column(
                    children: [
                      CustomWidget().customText("Hot product", FontWeight.bold, 20, Colors.black)
                    ],
                  ),
                ),
                SizedBox(
                  height: 250,
                  child: FutureBuilder(
                    future: homeBloc.getListProduct('hot'),
                    builder: (context,snapshot){
                      return CustomWidget().CustomSlideItemProduct(snapshot.data as List<Product>,context);
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20,right: 20,top: 20),
                  child: Column(
                    children: [
                      CustomWidget().customText("New product", FontWeight.bold, 20, Colors.black)
                    ],
                  ),
                ),
                SizedBox(
                  height: 250,
                  child: FutureBuilder(
                    future: homeBloc.getListProduct('new'),
                    builder: (context,snapshot){
                      return CustomWidget().CustomSlideItemProduct(snapshot.data as List<Product>,context);
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20,right: 20,top: 20),
                  child: Column(
                    children: [
                      CustomWidget().customText("Popular product", FontWeight.bold, 20, Colors.black)
                    ],
                  ),
                ),
                SizedBox(
                  height: 250,
                  child: FutureBuilder(
                    future: homeBloc.getListProduct('popular'),
                    builder: (context,snapshot){
                      return CustomWidget().CustomSlideItemProduct(snapshot.data as List<Product>,context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
