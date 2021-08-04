import 'package:fashionshop/business_logic/blocs/Category_Bloc.dart';
import 'package:fashionshop/business_logic/models/product.dart';
import 'package:fashionshop/views/ui/page/widget/bottomNavigationBar.dart';
import 'package:fashionshop/views/ui/page/widget/widget.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CategoryPage();
  }
}

class _CategoryPage extends State<CategoryPage> {
  final _searchController = TextEditingController();
  final _category_bloc = CategoryBloc();
  int _value =1;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      bottomNavigationBar:
          BottomNavigationBarWidget().bottomNavBar(context, "listproduct"),
      body: SafeArea(
        child: Container(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: "search product",
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey,
                              )),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: DropdownButton(
                    hint:Text("Select item"),
                    value: _value,
                    items: [
                      DropdownMenuItem(
                        child: Text("Giảm dần"),
                        value: 0,
                      ),
                      DropdownMenuItem(
                        child: Text("Tăng dần"),
                        value: 1,
                      ),
                    ],
                    onChanged: (value){
                      setState(() {
                        _value=int.tryParse(value.toString())!;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                        height: 477,
                        width: MediaQuery.of(context).size.width,
                        child: FutureBuilder(
                          future: _category_bloc.getListProduct(),
                          builder: (context, snapshot) {
                            final lv = snapshot.data as List<Product>;
                            List<Product> temp = [];
                            if(_value==0){
                              if (_searchController.text.isEmpty) {
                                temp = lv;
                                temp.sort((a,b)=>b.price.compareTo(a.price));
                              } else
                                {
                                  temp = lv
                                      .where((element) =>
                                  element.name.toLowerCase().indexOf(
                                      _searchController.text
                                          .toLowerCase()) >
                                      0)
                                      .toList();
                                  temp.sort((a,b)=>b.price.compareTo(a.price));
                                }
                            }
                            else{
                              if (_searchController.text.isEmpty)
                                {
                                  temp = lv;
                                  temp.sort((a,b)=>a.price.compareTo(b.price));
                                }
                              else
                                {
                                  temp = lv
                                      .where((element) =>
                                  element.name.toLowerCase().indexOf(
                                      _searchController.text
                                          .toLowerCase()) >
                                      0)
                                      .toList();
                                  temp.sort((a,b)=>a.price.compareTo(b.price));
                                }
                            }
                            return CustomWidget()
                                .CustomListAllProduct(temp, context);
                          },
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
