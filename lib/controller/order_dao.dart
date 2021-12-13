import 'dart:convert' as JSON;
import 'package:businessfinder/controller/server_connection.dart';
import 'package:businessfinder/model/orders.dart';

class OrdersDAO {
  static final List<Order> listadoPedidos = [];
  static Future<void> addOrdersFromServer() async {
    var svrConn = ServerConnection();
    await svrConn.select('Order').then((products_data) {
      //el nombre de la tabla
      var json = JSON.jsonDecode(products_data);
      //decodifica el Json
      List records = json["data"];
      records.forEach((element) {
        listadoPedidos.add(Order.fromJson(element));
        //lo envia al constructor del store.dart
      });
    });
  }

  static int lastId(){
    if(listadoPedidos.toString().replaceAll('[]', '').isNotEmpty){
      return listadoPedidos.last.id;
    }else{
      return 0;
    }
  }
}



class ShopProductsDAO {
  static final List<ShopProd> listadoShopProd = [];
  static List<ShopProd> carrito = [];
  static Future<void> addShopProductsFromServer() async {
    var svrConn = ServerConnection();
    await svrConn.select('ShopProd').then((shoproducts_data) {
      //el nombre de la tabla
      var json = JSON.jsonDecode(shoproducts_data);
      //decodifica el Json
      List records = json["data"];
      records.forEach((element) {
        listadoShopProd.add(ShopProd.fromJson(element));
        //lo envia al constructor del store.dart
      });
    });
  }
}