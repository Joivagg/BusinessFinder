import 'package:businessfinder/controller/server_connection.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Registro de tienda';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  late String _id, _name, _address, _latitude, _longitude, _cellphone, _webpage, _type, _products, _logo, _photo;

  @override
  Widget build(BuildContext context) {
    const estiloTexto = TextStyle(fontSize: 16,color: Colors.blue);
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: ListView(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('\nID:',style: estiloTexto),
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }else{
                setState(() {
                  _id = value;
                });
                return null;
              }
            },
          ),
          const Text('Nombre:',style: estiloTexto),
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }else{
                setState(() {
                  _name = value;
                });
                return null;
              }
            },
          ),
          const Text('Dirección:',style: estiloTexto),
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }else{
                setState(() {
                  _address = value;
                });
                return null;
              }
            },
          ),
          const Text('Latitud:',style: estiloTexto),
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }else{
                setState(() {
                  _latitude = value;
                });
                return null;
              }
            },
          ),
          const Text('Longitud:',style: estiloTexto),
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }else{
                setState(() {
                  _longitude = value;
                });
                return null;
              }
            },
          ),
          const Text('Celular:',style: estiloTexto),
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }else{
                setState(() {
                  _cellphone = value;
                });
                return null;
              }
            },
          ),
          const Text('Página Web:',style: estiloTexto),
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }else{
                setState(() {
                  _webpage = value;
                });
                return null;
              }
            },
          ),
          const Text('Tipo:',style: estiloTexto),
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }else{
                setState(() {
                  _type = value;
                });
                return null;
              }
            },
          ),
          const Text('Productos:',style: estiloTexto),
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }else{
                setState(() {
                  _products = value;
                });
                return null;
              }
            },
          ),
          const Text('Logo:',style: estiloTexto),
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }else{
                setState(() {
                  _logo = value;
                });
                return null;
              }
            },
          ),
          const Text('Foto:',style: estiloTexto),
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }else{
                setState(() {
                  _photo = value;
                });
                return null;
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Enviando datos...')),
                  );
                  var con = ServerConnection();
                  con.insert('Stores', _id+';'+_name+';'+_address+';'+_latitude+';'+_longitude+';'+_cellphone+';'+_webpage+';'+_type+';'+_products+';'+_logo+';'+_photo);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Datos añadidos!')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}