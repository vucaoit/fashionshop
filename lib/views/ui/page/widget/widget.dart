import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fashionshop/business_logic/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomWidget {
  Widget customTextFormField(
      String text,
      TextEditingController textEditingController,
      AsyncSnapshot snapshot,
      IconData icon,
      bool textPassword) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: TextFormField(
        obscureText: textPassword,
        controller: textEditingController,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            filled: true,
            fillColor: Colors.black12,
            prefixIcon: Icon(
              icon,
              color: Colors.grey,
            ),
            hintText: text,
            errorText:
                (snapshot.hasError) ? (snapshot.error.toString()) : null),
      ),
    );
  }

  Widget customText(
      String text, FontWeight fontWeight, double size, Color color) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontWeight: fontWeight, fontSize: size, color: color),
    );
  }

  Widget CustomSlide(List<String> list) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        viewportFraction: 0.8,
        autoPlayAnimationDuration: const Duration(milliseconds: 1000),
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: list.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: CachedNetworkImage(
                  imageUrl:
                      (i == null) ? "http://via.placeholder.com/200x150" : i,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Image.network(
                      "https://upload.wikimedia.org/wikipedia/commons/b/b9/Youtube_loading_symbol_1_(wobbly).gif"),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                )
                // Image.network(i,width: 90,height: 90,fit: BoxFit.cover,)
                );
          },
        );
      }).toList(),
    );
  }

  Widget CustomSlideItemProduct(List<Product> list, BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: list.length,
      itemBuilder: (context, index) {
        // print(list[index]);
        return Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all()),
              child: Column(
                children: [
                  Container(
                    height: 150,
                    width: 120,
                    child: CachedNetworkImage(
                      imageUrl: (list[index].link == null)
                          ? "http://via.placeholder.com/200x150"
                          : list[index].link,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Image.network(
                          "https://upload.wikimedia.org/wikipedia/commons/b/b9/Youtube_loading_symbol_1_(wobbly).gif"),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text(formatPrice(list[index].price)+"₫",style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    width: 100,
                    child:Text(list[index].name,textAlign: TextAlign.center,maxLines:2,overflow: TextOverflow.ellipsis,),
                  )
                ],
              ),
            )
            );
      },
    );
  }
  Widget CustomListAllProduct(List<Product> list, BuildContext context) {
    return
      GridView.count(
        crossAxisCount: 2 ,
          childAspectRatio:0.7,
        children: List.generate(list.length,(index){
          return productItem(list[index]);
        }),
      );
  }
  String formatPrice(num price){
    var f = NumberFormat('#,###,###,###', 'vi-VN');
    return f.format(price);
  }
  Widget productItem(Product product){
    return Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all()),
          child: Column(
            children: [
              Container(
                height: 150,
                width: 120,
                child: CachedNetworkImage(
                  imageUrl: (product.link == null)
                      ? "http://via.placeholder.com/200x150"
                      : product.link,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Image.network(
                      "https://upload.wikimedia.org/wikipedia/commons/b/b9/Youtube_loading_symbol_1_(wobbly).gif"),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Text(formatPrice(product.price)+"₫",style: TextStyle(fontWeight: FontWeight.bold),),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                width: 100,
                child:Text(product.name,textAlign: TextAlign.center,maxLines:2,overflow: TextOverflow.ellipsis,),
              ),
              Container(
                child: FlatButton(
                  onPressed: (){},
                  child: Text("ADD TO CART"),
                ),
              )
            ],
          ),
        )
    );
  }
}
