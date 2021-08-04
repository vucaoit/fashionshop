import 'package:fashionshop/business_logic/models/product.dart';
import 'package:fashionshop/business_logic/services/firebase/firebaseDatabase.dart';

class CategoryBloc{
  Future<List<Product>> getListProduct()async {
    List<Product> liststr =[];
    await FirebaseDBServices().getAllProduct().then((value){
      value.forEach((element) {liststr.add(element);});
    });
    return liststr;
  }
}