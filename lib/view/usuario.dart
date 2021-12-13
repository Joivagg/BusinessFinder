import 'package:businessfinder/controller/client_dao.dart';
import 'package:businessfinder/controller/server_connection.dart';
import 'package:businessfinder/model/users_data.dart';
import 'package:businessfinder/view/home_view.dart';
import 'package:businessfinder/view/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class Usuario extends StatefulWidget {
  final userid;

  const Usuario( {Key? key, this.userid}) : super(key: key);



  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<Usuario>{


  //late String _cedula='1032398180';
  late String _cedula;
  late String _nombre;
  late String _direccion;
  late String _correo;
  late String _telefono;
  late String _password;
  String _tipo = "usuario";
  final _formkey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    late Users usu=new Users(0, 'invitado ', ' ', ' ', ' ', ' ', UserType.invitado);
    if(widget.userid!='email'){
      usu=buscar(widget.userid);
      this._cedula=usu.id.toString();
    }
    else{

    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Bienvenido '+usu.name),
        actions: <Widget>[
          PopupMenuButton<int>(
            onSelected: (item)=> onSelectet(context,item),
            itemBuilder: (context)=>[
              PopupMenuItem<int>(
                  value: 4,
                  child:Text('Darese de baja')),
              PopupMenuItem<int>(
                  value: 0,
                  child:Text('Log in')),
              PopupMenuItem<int>(
                value: 2,
                child: Text('Salir'),
              )
            ],
          ),

        ],
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
          child: Form (
            key: _formkey,
              child:Column(
                children: <Widget>[
                  formItemsDesign(
                      Icons.person_pin_sharp,
                      TextFormField(
                          decoration: decorations(usu.id.toString()),
                          readOnly: true
                   )),
                  formItemsDesign(
                      Icons.person,
                      TextFormField(
                          decoration: decorations(usu.name),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "* Required";
                            } else {
                              setState(() {
                                this._nombre = value+' ';
                              });
                              return null;
                            }
                          }
                        //validator: ,
                      )),
                  formItemsDesign(
                      Icons.location_city_rounded,
                      TextFormField(
                          decoration: decorations(usu.address),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "* Required";
                            } else {
                              setState(() {
                                this._direccion = value;
                              });
                              return null;
                            }
                          }
                        //validator: ,
                      )),
                  formItemsDesign(
                      Icons.alternate_email,
                      TextFormField(
                          decoration: decorations(usu.email),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "* Required";
                            } else {
                              setState(() {
                                this._correo = value;
                              });
                              return null;
                            }
                          }
                        //validator: ,
                      )),
                  formItemsDesign(
                      Icons.contact_phone_rounded,
                      TextFormField(
                          decoration: decorations(usu.cellphone),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "* Required";
                            } else {
                              setState(() {
                                this._telefono = value;
                              });
                              return null;
                            }
                          }
                        //validator: ,
                      )),
                  formItemsDesign(
                      Icons.lock,
                      TextFormField(
                          decoration: decorations(usu.password),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "* Required";
                            } else {
                              setState(() {
                                this._password = value;
                              });
                              return null;
                            }
                          }
                        //validator: ,
                      )),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 7),
                      child: ElevatedButton(
                        onPressed: ()  async {
                          if (_formkey.currentState!.validate()) {
                            this._cedula=usu.id.toString();
                            var serverCon = ServerConnection();
                            serverCon.updateClient(
                                'Clientes',
                                this._cedula +
                                    ';' +
                                    this._nombre +
                                    ';' +
                                    this._direccion +
                                    ';' +
                                    this._correo +
                                    ';' +
                                    this._telefono +
                                    ';' +
                                    this._password +
                                    ';' +
                                    this._tipo);
                            ClientDAO.userupdate();
                            Users usuario=ClientDAO.user(_correo);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('actualizado')),
                            );
                            Future.delayed(const Duration(seconds: 2), ()
                            {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        HomeView2(usu: usuario),

                                  )
                              );
                            });
                          }
                        }, child: const Text("Actualizar"),
                      ),
                  )
                ],
              ) 
             
          ), 
      ),
    );
  }
  formItemsDesign(icon, item) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Card(child: ListTile(leading: Icon(icon), title: item)),
    );
  }

  Users buscar(userid) {
    Users usu= ClientDAO.user(widget.userid.toString());
    return usu;
  }
  onSelectet(BuildContext context, int item) {
    switch(item){
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
        break;
      case 2:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hasta pronto!!')),
        );
        Future.delayed(const Duration(seconds: 2), ()
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeView2(usu: new Users(0, 'Invitado ', 'address', 'email', 'cellphone', 'password', UserType.invitado)),
              ));
        });
        break;
      case 4:
        showDialog(context: context,
            barrierDismissible: false,
            builder: (context){
          return AlertDialog(
            title: Text('Notificaciones'),
            content:
            Text("¿Desea darse de baja?"),
            actions: <Widget>[
              FlatButton(
                  child: Text("Aceptar"),
                  color: Colors.redAccent,
                  onPressed: () {
                    Navigator.of(context).pop('OK');
                    var serverCon = ServerConnection();
                    serverCon.dropClient('Clientes', this._cedula);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeView2(usu: new Users(0, 'Invitado ', 'address', 'email', 'cellphone', 'password', UserType.invitado)),
                        ));

                  }),
              FlatButton(
                  child: Text("Cancelar"),
                  color: Colors.green,
                  onPressed: () {
                    Navigator.of(context).pop('Cancelar');
                  }),
            ],
          );
            });
        break;
    }

  }
}
decorations(String e) {
  return InputDecoration(

      hintText: 'Please enter your '+e,
      labelText: e,
      border: OutlineInputBorder(),
      labelStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontStyle: FontStyle.normal,
      ));

}