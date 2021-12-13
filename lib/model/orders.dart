

import 'package:businessfinder/controller/order_dao.dart';
import 'package:businessfinder/controller/product_dao.dart';
import 'package:businessfinder/model/product.dart';

enum OrderType{
  domicilio,
  recoger
}

class Order {
  int id;
  late double price;
  late OrderType tipo;
  int id_client;
  List<ShopProd> addedProducts=[];
  late String fecha;

  Order(this.id, this.addedProducts, this.id_client, this.price);

  setPrice(){
    for(ShopProd i in addedProducts){
      price+=(i.product.price)*i.units;
    }
  }

  Order.fromJson(Map<String, dynamic> json)
      :
        id = int.parse(json['id'].toString()),
        id_client = int.parse(json['id_client'].toString()),
        price = double.parse(json['price'].toString()),
        addedProducts = ShopProductsDAO.listadoShopProd.where((element) => element.id_order == int.parse(json['id'].toString())).toList(),
        tipo = OrderType.values.firstWhere((element) =>
                element.toString() == 'OrderType.' + json['type'].toString()),
        fecha = json['date'].toString();
}

class ShopProd{
  int id_order;
  Product product;
  int units;

  ShopProd(this.id_order, this.product, this.units);

  ShopProd.fromJson(Map<String, dynamic> json)
      :
        id_order = int.parse(json['id'].toString()),
        product = ProductsDAO.listadoProductos.firstWhere(
                (element) => ((element.id==int.parse(json['id_product'])) && element.id_store==int.parse(json['id_store']))
        ),
        units = int.parse(json['units'].toString());

}