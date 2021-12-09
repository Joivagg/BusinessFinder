class Product{
  int id;
  int id_store;
  String name;
  String description;
  double price;
  List<String> images;

  Product(this.id, this.id_store, this.name,this.description, this.price, this.images);

  Product.fromJson(Map<String, dynamic> json)
      : id = int.parse(json['ID'].toString()),
        id_store = int.parse(json['id_store'].toString()),
        name = json['name'].toString(),
        description = json['description'].toString(),
        price = double.parse(json['price'].toString()),
        images = json['images'].toString().split(';');

}