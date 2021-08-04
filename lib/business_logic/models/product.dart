class Product{
  String name="";
  String link="";
  num price=0;
  Product({required this.name,required this.link,required this.price});
@override
  String toString() {
    // TODO: implement toString
    return this.name+" "+this.price.toString()+" "+this.link;
  }
}

