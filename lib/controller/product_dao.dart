import 'dart:convert' as JSON;
import 'package:businessfinder/controller/server_connection.dart';
import 'package:businessfinder/model/product.dart';

class ProductsDAO {
  static final List<Product> listadoProductos = [];
  static Future<void> addProductsFromServer() async {
    var svrConn = ServerConnection();
    await svrConn.select('Products').then((products_data) {
      //el nombre de la tabla
      var json = JSON.jsonDecode(products_data);
      //decodifica el Json
      List records = json["data"];
      records.forEach((element) {
        listadoProductos.add(Product.fromJson(element));
        //lo envia al constructor del store.dart
      });
    });
  }
}