import 'dart:convert' as JSON;
import 'package:businessfinder/controller/server_connection.dart';
import 'package:businessfinder/model/users_data.dart';

class ClientDAO {
  static final List<Users> listadoClientes = [];
  static List<Users> listadoClientes2 = [];
  static Users clienteActual= Users(0, 'Invitado ', 'address', 'email', 'cellphone', 'password', UserType.invitado);

  static Future<void> addClientsFromServer() async {
    var svrConn = ServerConnection();
    await svrConn.select('Clientes').then((users_data) {
      //el nombre de la tabla
      var json = JSON.jsonDecode(users_data);
      //decodifica el Json
      List records = json["data"];
      records.forEach((element) {
        listadoClientes.add(Users.formJson(element));
        //lo envia al constructor del store.dart
      });
    });
  }
  static Future<String> searchClient(String email, String pass) async{

    listadoClientes.clear();
    var svrConn = ServerConnection();
    await svrConn.select('Clientes').then((users_data) {
      //el nombre de la tabla
      var json = JSON.jsonDecode(users_data);
      //decodifica el Json
      List records = json["data"];
      records.forEach((element) {
        listadoClientes.add(Users.formJson(element));
        //lo envia al constructor del store.dart
      });
    });
    for(int i=0;i<listadoClientes.length;i++){
      if(listadoClientes[i].email==email){
        if(listadoClientes[i].password==pass){
          return 'Bienvenido';
        }
        else{
          return 'Contraseña incorrecta';
        }

      }
    }
    return 'datos no encontrados';

  }
  static Users user(String email) {
    for(Users i in ClientDAO.listadoClientes){
      if(i.email==email){
        print(i.name);
        return i;
      }
    }
    Users invitado= Users(0,'Invitado ','Dirección','Correo','Celular','Password',UserType.invitado);
    return  invitado;
  }
  static Future<void> userupdate() async {
    listadoClientes.clear();
    var svrConn = ServerConnection();
    await svrConn.select('Clientes').then((users_data) {
      //el nombre de la tabla
      var json = JSON.jsonDecode(users_data);
      //decodifica el Json
      List records = json["data"];
      records.forEach((element) {
        listadoClientes.add(Users.formJson(element));
        //lo envia al constructor del store.dart
      });
    });
    print(listadoClientes.length);
    }

  static Future<bool> existe(int id) async{
    final cliente=ClientDAO.listadoClientes;
    bool salida=false;
    for(Users i in cliente){
      if(i.id==id){
        salida=true;
        return salida;
      }
    }
    return false;
  }
}