import 'package:businessfinder/controller/client_dao.dart';
import 'package:businessfinder/model/users_data.dart';
import 'package:businessfinder/view/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}
class _RegisterPageState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login page',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Login page'),
        ),
        body: SingleChildScrollView(child: MyCustomForm()),
      ),
    );
  }

}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  late String _correo;
  late String _password;
  final _formkey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
            child: Column(children: <Widget>[
              formItemsDesign(
                  Icons.person,
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Enter email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "* Required";
                        }
                      else{
                        setState(() {
                          this._correo = value;
                          });
                        return null;
                        }
                    },
                  )),
              formItemsDesign(
                  Icons.alternate_email,
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter secure password'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "* Required";
                        }
                      else {
                        setState(() {
                          this._password = value;
                          });
                        return null;
                      }
                    },
                  )),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 7),
                  child: ElevatedButton(
                    onPressed: ()  async {
                      if (_formkey.currentState!.validate()) {
                        String a= await ClientDAO.searchClient(_correo, _password);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(a)),
                        );
                        if (a=='Bienvenido'){
                          Users usuario= await ClientDAO.user(_correo);
                          Future.delayed(const Duration(seconds: 2), ()
                          {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeView2(usu: usuario),
                                
                                )
                            );
                          }
                          );
                        }

                      }
                    }, child: const Text("Log In"),
                  )
              )

            ]),
          );
  }
  formItemsDesign(icon, item) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Card(child: ListTile(leading: Icon(icon), title: item)),
    );
  }


}


