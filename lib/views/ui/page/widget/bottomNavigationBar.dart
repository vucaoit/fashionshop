import 'package:flutter/material.dart';

import '../routes.dart';
class BottomNavigationBarWidget{
  Widget bottomNavBar(BuildContext context,String location){
    return Container(
      child: Row(
        children: [
          Expanded(
              child: IconButton(
                onPressed: () {Navigator.pushNamed(context, home_route);},
                icon: (location=="home")?Icon(Icons.home,color: Colors.red,):Icon(Icons.home,color: Colors.black,),
              )),
          Expanded(
              child: IconButton(
                onPressed: () {Navigator.pushNamed(context, category_route);},
                icon: (location=="listproduct")?Icon(Icons.grid_view,color: Colors.red,):Icon(Icons.grid_view,color: Colors.black,),
              )),
          Expanded(
              child: IconButton(
                onPressed: () {Navigator.pushNamed(context, favorite_route);},
                icon: (location=="favorite")?Icon(Icons.volunteer_activism,color: Colors.red,):Icon(Icons.volunteer_activism,color: Colors.black,),
              )),
          Expanded(
              child: IconButton(
                onPressed: () {Navigator.pushNamed(context, cart_route);},
                icon: (location=="cart")?Icon(Icons.shopping_cart_sharp,color: Colors.red,):Icon(Icons.shopping_cart_sharp,color: Colors.black,),
              )),
          Expanded(
              child: IconButton(
                onPressed: () {Navigator.pushNamed(context, profile_route);},
                icon: (location=="profile")?Icon(Icons.person,color: Colors.red,):Icon(Icons.person,color: Colors.black,),
              )),
        ],
      ),
    );
  }
}