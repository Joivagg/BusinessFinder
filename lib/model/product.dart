import 'package:businessfinder/controller/order_dao.dart';
import 'package:businessfinder/controller/store_dao.dart';
import 'package:businessfinder/model/stores_data.dart';

import 'orders.dart';

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

  Stores getStore(Product pr){
    for(Stores i in StoresDAO.listadoTiendas){
      if(i.id == pr.id_store){
        return i;
      }
    }
    throw Exception('El producto no pertenece a ninguna tienda');
  }

  static bool isInCarrito(Product product){
    bool res = false;
    for(ShopProd i in ShopProductsDAO.carrito){
      if (product == i.product){
        res= true;
      }
    }return res;
  }

}