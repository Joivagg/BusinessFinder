import 'package:businessfinder/controller/server_connection.dart';
import 'package:businessfinder/view/costumers_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Login extends StatefulWidget {

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState  extends State<Login>{
  @override
  Widget build(BuildContext context) {
    final appTitle="Datos del envió";
    // TODO: implement build
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: SingleChildScrollView(child: MyCustomForm()),
      ),
    );
  }
}
class MyCustomForm extends StatefulWidget{
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}
class MyCustomFormState extends State<MyCustomForm> {
  final idCtrl= TextEditingController();
  final nameCtrl= TextEditingController();
  final addressCtrl=TextEditingController();
  final emailCtrl=TextEditingController();
  final cellphoneCtrl=TextEditingController();
  final passwordCtrl=TextEditingController();
  final repeatPassCtrl=TextEditingController();

  late String _cedula;
  late String _nombre;
  late String _direccion;
  late String _correo;
  late String _telefono;
  late String _password;
  String _tipo="usuario";
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Limpia el controlador cuando el widget se elimine del árbol de widgets
    // Esto también elimina el listener _printLatestValue
    idCtrl.dispose();
    nameCtrl.dispose();
    addressCtrl.dispose();
    emailCtrl.dispose();
    cellphoneCtrl.dispose();
    passwordCtrl.dispose();
    repeatPassCtrl.dispose();
    super.dispose();
  }

  String? validateId(value){
    String pattern = r'(^(?:[+0]9)?[0-9]{5,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "El documento es necesario" ;
    } else if (!regExp.hasMatch(value)) {
      return "Documento inválido" ;
    }
    return null;
  }

  String? validateName(value){
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value == 0) {
      return "El nombre es necesario" ;
    } else if (!regExp.hasMatch(value)) {
      return "El nombre debe de ser a-z y A-Z" ;
    }
    return null;
  }

  String? validateAddress(value){
    String pattern =  r'(^(?:[+0]9)?[0-9]{10,12}^[a-zA-Z ]$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "La dirección es necesaria" ;
    } else if (!regExp.hasMatch(value)) {
      return "Dirección inválida" ;
    }
    return null;
  }

  String? validateEmail(value){
    String pattern =  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "El correo es necesario" ;
    } else if (!regExp.hasMatch(value)) {
      return "Dirección de correo inválida" ;
    }
    return null;
  }
  String? validateNum(value){
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "El número de teléfono es necesario" ;
    } else if (!regExp.hasMatch(value)) {
      return "Teléfono inválido, longitud mínima 10" ;
    }
    return null;
  }
  String? validatePass(value){

    if (value.length == 0) {
      return "Es necesario diligenciar el password" ;
    } else if (repeatPassCtrl.text!=value) {
      return "Contraseñas diferentes" ;
    }
    return null;
  }
  String? validatePass2(value){

    if (value.length == 0) {
      return "Es necesario diligenciar el password" ;
    } else if (passwordCtrl.text!=value) {
      return "Contraseñas diferentes" ;
    }
    return null;
  }

  _printLatestValue() {
    print("Nombre: ${nameCtrl.text}");
    print("Dirección: ${addressCtrl.text}");
    print("Local phone: ${emailCtrl.text}");
    print("Cellphone: ${cellphoneCtrl.text}");

  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          formItemsDesign(Icons.person,
              TextFormField(
                controller: idCtrl,
                decoration: decorations('Document'),
                validator: (value) {
                  var salida=validateId(value);
                  if (value==null ||value.isEmpty) {
                    return salida;
                  }
                  else{
                    setState(() {this._cedula =value;
                    });
                    return salida;
                  }
                },
              )),

          formItemsDesign(Icons.person,
          TextFormField(
            controller: nameCtrl,
            decoration: decorations('Names'),
            validator: (value) {
              var salida=validateName(value);
              if (value==null ||value.isEmpty) {
                return salida;
              }
              else{
                setState(() {this._nombre =value;
                });
                return salida;
              }
            },
          )),
          formItemsDesign(Icons.location_city,
          TextFormField(
            controller: addressCtrl,
            decoration: decorations('Address'),
            validator: (value) {
              //var salida=validateAddress(value);
              if (value==null ||value.isEmpty) {
                return "Dirección necesaria";
              }
              else{
                setState(() {this._direccion =value;
                });
                return null;
              }


            },
          )),

          formItemsDesign(Icons.alternate_email,
              TextFormField(
                controller: emailCtrl,
                decoration: decorations('Email'),
                validator: (value) {
                  var salida=validateEmail(value);
                  if (value==null ||value.isEmpty) {
                    return salida;
                  }
                  else{
                    setState(() {this._correo =value;
                    });
                    return salida;
                  }

                },
              )),

          formItemsDesign(Icons.phone_android,
              TextFormField(
                controller: cellphoneCtrl,
                decoration: decorations('Cellphone'),
                maxLength: 10,
                  validator: (value) {
                    var salida=validateNum(value);
                    if (value==null ||value.isEmpty) {
                      return salida;
                    }
                    else{
                      setState(() {this._telefono =value;
                      });
                      return salida;
                    }
                  }
                //validator: ,
              )),

          formItemsDesign(Icons.lock,
              TextFormField(
                controller: passwordCtrl,
                decoration: decorations('password'),
                  validator: (value) {
                    var salida=validatePass(value);
                    if (value==null ||value.isEmpty) {
                      return salida;
                    }
                    else{
                      setState(() {this._password =value;
                      });
                      return salida;
                    }
                  }
                //validator: ,
              )),

          formItemsDesign(Icons.lock,
              TextFormField(
                controller: repeatPassCtrl,
                decoration: decorations('repeat password'),
                  validator: (value) {
                    var salida=validatePass(value);
                    if (value==null ||value.isEmpty) {
                      return salida;
                    }
                    else{
                      return salida;
                    }
                  }
                //validator: ,
              )),

      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ElevatedButton(
          onPressed: () {
            // Validate returns true if the form is valid, or false otherwise.
            if (_formKey.currentState!.validate()) {
              var serverCon = ServerConnection();
              serverCon.insert('Clientes', this._cedula+';'+this._nombre+';'+this._direccion+';'+this._correo+';'+this._telefono+';'+this._password+';'+this._tipo);
              // If the form is valid, display a snackbar. In the real world,
              // you'd often call a server or save the information in a database.
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Usuario Agregado')),
              );
            }
          },
          child: const Text('Submit'),
      )),
        ],
      ),
    );
  }
  decorations(String e){
    return InputDecoration(

        labelText: e,
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontStyle: FontStyle.normal,
        )
    );
  }
  formItemsDesign(icon, item) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Card(child: ListTile(leading: Icon(icon), title: item)),
    );
  }
}
