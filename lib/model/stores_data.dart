
import 'package:businessfinder/controller/product_dao.dart';
import 'package:businessfinder/model/product.dart';

enum StoreType {
  todos,
  tienda,
  drogueria,
  ferreteria,
  lavanderia,
  zapateria,
  restaurante,
  panaderia,
  carniceria,
  discoteca
}

List<StoreType> getStoreTypes(){
  return StoreType.values;
}


class Stores {
  int id;
  String name;
  String address;
  double latitude;
  double longitude;
  String phone;
  String cellphone;
  String webpage;
  StoreType type;
  List<Product> products;
  String logo;
  List<String> photo;

  Stores(this.id, this.name, this.address, this.latitude,this.longitude, this.phone, this.cellphone,
      this.webpage, this.type, this.products, this.logo, this.photo);

  Stores.formJson(Map<String, dynamic> json)
      :
        id = int.parse(json['ID'].toString()),
        name = json['name'].toString(),
        address = json['address'].toString(),
        latitude = double.parse(json['latitude'].toString()),
        longitude = double.parse(json['longitude'].toString()),
        cellphone = json['cellphone'].toString(),
        phone = json['phone'].toString(),
        webpage = json['webpage'].toString(),
        type = StoreType.values.firstWhere((element) =>
        element.toString() == 'StoreType.' + json['type'].toString()),
        products = ProductsDAO.listadoProductos.where((element) => element.id_store == int.parse(json['ID'].toString())).toList(),
        logo = json['logo'].toString(),
        photo = json['photo'].toString().split(';');
}