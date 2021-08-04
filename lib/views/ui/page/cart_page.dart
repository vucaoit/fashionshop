import 'package:fashionshop/views/ui/page/widget/bottomNavigationBar.dart';
import 'package:flutter/material.dart';
class CartPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CartPage();
  }
}
class _CartPage extends State<CartPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      bottomNavigationBar: BottomNavigationBarWidget().bottomNavBar(context,"cart"),
      body: SafeArea(
        child: Center(
          child: Container(
            child: Column(
              children: [
                Text("Cart page")
              ],
            ),
          ),
        ),
      ),
    );
  }

}