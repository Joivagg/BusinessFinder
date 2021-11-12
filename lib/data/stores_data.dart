enum StoreType {
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

enum ProductsList {
  arroz,
  carne,
  pollo,
  manzanas,
  naranjas
}

class Stores {
  String name;
  String address;
  String geolocation;
  int phone;
  int cellphone;
  String webpage;
  StoreType type;
  ProductsList products;
  String logo;
  String photo;

  Stores(this.name, this.address, this.geolocation, this.phone, this.cellphone,
      this.webpage, this.type, this.products, this.logo, this.photo);
}

class StoresDAO {
  List<Stores> listadoTiendas = [
    Stores('La esquina del sabor1', 'carrera 43 # 11 - 39', '2341441', 7481831, 3295029513, 'www.laesquinadelsabor.com', StoreType.restaurante, ProductsList.carne, 'logo.png', 'photo.png'),
    Stores('La esquina del sabor2', 'carrera 43 # 11 - 39', '2341441', 7481831, 3295029513, 'www.laesquinadelsabor.com', StoreType.restaurante, ProductsList.carne, 'logo.png', 'photo.png'),
    Stores('La esquina del sabor3', 'carrera 43 # 11 - 39', '2341441', 7481831, 3295029513, 'www.laesquinadelsabor.com', StoreType.restaurante, ProductsList.carne, 'logo.png', 'photo.png'),
    Stores('La esquina del sabor4', 'carrera 43 # 11 - 39', '2341441', 7481831, 3295029513, 'www.laesquinadelsabor.com', StoreType.restaurante, ProductsList.carne, 'logo.png', 'photo.png'),
    Stores('La esquina del sabor5', 'carrera 43 # 11 - 39', '2341441', 7481831, 3295029513, 'www.laesquinadelsabor.com', StoreType.restaurante, ProductsList.carne, 'logo.png', 'photo.png'),
    Stores('La esquina del sabor6', 'carrera 43 # 11 - 39', '2341441', 7481831, 3295029513, 'www.laesquinadelsabor.com', StoreType.restaurante, ProductsList.carne, 'logo.png', 'photo.png'),
    Stores('La esquina del sabor7', 'carrera 43 # 11 - 39', '2341441', 7481831, 3295029513, 'www.laesquinadelsabor.com', StoreType.restaurante, ProductsList.carne, 'logo.png', 'photo.png'),
    Stores('La esquina del sabor8', 'carrera 43 # 11 - 39', '2341441', 7481831, 3295029513, 'www.laesquinadelsabor.com', StoreType.restaurante, ProductsList.carne, 'logo.png', 'photo.png'),
    Stores('La esquina del sabor9', 'carrera 43 # 11 - 39', '2341441', 7481831, 3295029513, 'www.laesquinadelsabor.com', StoreType.restaurante, ProductsList.carne, 'logo.png', 'photo.png'),
    Stores('La esquina del sabor10', 'carrera 43 # 11 - 39', '2341441', 7481831, 3295029513, 'www.laesquinadelsabor.com', StoreType.restaurante, ProductsList.carne, 'logo.png', 'photo.png'),
    Stores('La esquina del sabor11', 'carrera 43 # 11 - 39', '2341441', 7481831, 3295029513, 'www.laesquinadelsabor.com', StoreType.restaurante, ProductsList.carne, 'logo.png', 'photo.png'),
    Stores('La esquina del sabor12', 'carrera 43 # 11 - 39', '2341441', 7481831, 3295029513, 'www.laesquinadelsabor.com', StoreType.restaurante, ProductsList.carne, 'logo.png', 'photo.png'),
    Stores('La esquina del sabor13', 'carrera 43 # 11 - 39', '2341441', 7481831, 3295029513, 'www.laesquinadelsabor.com', StoreType.restaurante, ProductsList.carne, 'logo.png', 'photo.png'),
    Stores('La esquina del sabor14', 'carrera 43 # 11 - 39', '2341441', 7481831, 3295029513, 'www.laesquinadelsabor.com', StoreType.restaurante, ProductsList.carne, 'logo.png', 'photo.png'),
    Stores('La esquina del sabor15', 'carrera 43 # 11 - 39', '2341441', 7481831, 3295029513, 'www.laesquinadelsabor.com', StoreType.restaurante, ProductsList.carne, 'logo.png', 'photo.png'),
    Stores('La esquina del sabor16', 'carrera 43 # 11 - 39', '2341441', 7481831, 3295029513, 'www.laesquinadelsabor.com', StoreType.restaurante, ProductsList.carne, 'logo.png', 'photo.png'),
    Stores('La esquina del sabor17', 'carrera 43 # 11 - 39', '2341441', 7481831, 3295029513, 'www.laesquinadelsabor.com', StoreType.restaurante, ProductsList.carne, 'logo.png', 'photo.png'),
    Stores('La esquina del sabor18', 'carrera 43 # 11 - 39', '2341441', 7481831, 3295029513, 'www.laesquinadelsabor.com', StoreType.restaurante, ProductsList.carne, 'logo.png', 'photo.png'),
    Stores('La esquina del sabor19', 'carrera 43 # 11 - 39', '2341441', 7481831, 3295029513, 'www.laesquinadelsabor.com', StoreType.restaurante, ProductsList.carne, 'logo.png', 'photo.png'),
    Stores('La esquina del sabor20', 'carrera 43 # 11 - 39', '2341441', 7481831, 3295029513, 'www.laesquinadelsabor.com', StoreType.restaurante, ProductsList.carne, 'logo.png', 'photo.png'),
    Stores('La esquina del sabor21', 'carrera 43 # 11 - 39', '2341441', 7481831, 3295029513, 'www.laesquinadelsabor.com', StoreType.restaurante, ProductsList.carne, 'logo.png', 'photo.png'),
    Stores('La esquina del sabor22', 'carrera 43 # 11 - 39', '2341441', 7481831, 3295029513, 'www.laesquinadelsabor.com', StoreType.restaurante, ProductsList.carne, 'logo.png', 'photo.png'),
    Stores('La esquina del sabor23', 'carrera 43 # 11 - 39', '2341441', 7481831, 3295029513, 'www.laesquinadelsabor.com', StoreType.restaurante, ProductsList.carne, 'logo.png', 'photo.png'),    Stores('La esquina del sabor23', 'carrera 43 # 11 - 39', '2341441', 7481831, 3295029513, 'www.laesquinadelsabor.com', StoreType.restaurante, ProductsList.carne, 'logo.png', 'photo.png'),
    Stores('La esquina del sabor24', 'carrera 43 # 11 - 39', '2341441', 7481831, 3295029513, 'www.laesquinadelsabor.com', StoreType.restaurante, ProductsList.carne, 'logo.png', 'photo.png'),
    Stores('La esquina del sabor25', 'carrera 43 # 11 - 39', '2341441', 7481831, 3295029513, 'www.laesquinadelsabor.com', StoreType.restaurante, ProductsList.carne, 'logo.png', 'photo.png'),
  ];
}