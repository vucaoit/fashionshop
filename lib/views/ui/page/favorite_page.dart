import 'package:fashionshop/views/ui/page/widget/bottomNavigationBar.dart';
import 'package:flutter/material.dart';
class FavoritePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FavoritePage();
  }
}
class _FavoritePage extends State<FavoritePage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      bottomNavigationBar: BottomNavigationBarWidget().bottomNavBar(context,"favorite"),
      body: SafeArea(
        child: Center(
          child: Container(
            child: Column(
              children: [
                Text("Favorite page")
              ],
            ),
          ),
        ),
      ),
    );
  }

}