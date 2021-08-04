import 'package:fashionshop/views/ui/page/cart_page.dart';
import 'package:fashionshop/views/ui/page/change_password_page.dart';
import 'package:fashionshop/views/ui/page/editprofile.dart';
import 'package:fashionshop/views/ui/page/favorite_page.dart';
import 'package:fashionshop/views/ui/page/forgot_password.dart';
import 'package:fashionshop/views/ui/page/profile_page.dart';
import 'package:fashionshop/views/ui/page/category_page.dart';
import 'package:flutter/material.dart';
import 'package:fashionshop/views/ui/page/home_page.dart';
import 'package:fashionshop/views/ui/page/login_page.dart';
import 'package:fashionshop/views/ui/page/register_page.dart';
import 'package:fashionshop/views/ui/page/routes.dart';
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: <String,WidgetBuilder>{
        home_route: (context) => MyHomePage(title: "Flutter App"),
        login_route: (context) => LoginPage(),
        register_route : (context) => RegisterPage(),
        profile_route : (context) => ProfilePage(),
        category_route : (context) => CategoryPage(),
        favorite_route : (context)=> FavoritePage(),
        cart_route : (context) => CartPage(),
        edit_profile_route:(context)=>EditProfile(),
        change_password_route:(context)=>ChangePasswordPage(),
        forgot_password_route:(context)=>ForgetPasswordPage()
      },
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: "Flutter App"),
    );
  }
}