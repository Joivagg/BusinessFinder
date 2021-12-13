import 'dart:convert' as JSON;
import 'package:businessfinder/controller/order_dao.dart';
import 'package:businessfinder/controller/product_dao.dart';
import 'package:businessfinder/controller/server_connection.dart';
import 'package:businessfinder/model/stores_data.dart';

import 'client_dao.dart';

class StoresDAO {
  static final List<Stores> listadoTiendas = [];

  static Future<void> addStoresFromServer() async {
    await ProductsDAO.addProductsFromServer().then((value) async {
      await ClientDAO.addClientsFromServer().then((value) async {
        await OrdersDAO.addOrdersFromServer().then((value) async{
          var svrConn = ServerConnection();
          await svrConn.select('Stores').then((stores_data) {
            //el nombre de la tabla
            var json = JSON.jsonDecode(stores_data);
            //decodifica el Json
            List records = json["data"];
            records.forEach((element) {
              listadoTiendas.add(Stores.formJson(element));
              //lo envia al constructor del store.dart
            });
          });
        });
      });
    });
  }
}