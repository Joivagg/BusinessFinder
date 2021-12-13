import 'package:businessfinder/model/users_data.dart';
import 'package:businessfinder/view/register.dart';
import 'package:businessfinder/view/search.dart';
import 'package:businessfinder/view/search_products.dart';
import 'package:businessfinder/view/usuario.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Users _usu=new Users(0, 'Invitado ', 'address', 'email', 'cellphone', 'password', UserType.invitado);
    //final wordPair = WordPair.random();
    return MaterialApp(
      //title: 'Generador de Nombres',
        home: HomeScreen(usu:_usu));
  }
}
class HomeView2 extends StatelessWidget{
  final Users usu;
  const HomeView2({Key? key, required this.usu}) : super(key: key);
  @override
    Widget build(BuildContext context) {
    print(usu.name);
      //final wordPair = WordPair.random();
      return MaterialApp(
        //title: 'Generador de Nombres',
          home: HomeScreen(
             usu: usu,
          ),

      );
    }
  }

class HomeScreen extends StatelessWidget{
  final Users usu;
  const HomeScreen({Key? key, required this.usu}) : super(key: key);


  static final List<String> images = [
    'https://logowik.com/content/uploads/images/flutter5786.jpg',
    'https://logowik.com/content/uploads/images/flutter5786.jpg',
    'https://logowik.com/content/uploads/images/flutter5786.jpg',
    'https://logowik.com/content/uploads/images/flutter5786.jpg',
  ];





  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Menú Principal'),
        actions: <Widget>[
          PopupMenuButton<int>(
            onSelected: (item)=> onSelectet(context,item),
            itemBuilder: (context)=>[
              PopupMenuItem<int>(
                  value: 4,
                  child:Text(usu.name.substring(0,usu.name.indexOf(' ')))),
              PopupMenuItem<int>(
                value: 0,
                  child:Text('Log in')),
              PopupMenuItem<int>(
                  value: 1,
                  child: Text('Registrarse')),
              PopupMenuItem<int>(
                value: 2,
                child: Text('Salir'),
              )
            ],
          ),

        ],
        backgroundColor: Colors.red,

      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: images.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // numero de elementos en la fila
              crossAxisSpacing: 4.0),
          itemBuilder: (BuildContext context, int index){
            return buildCell(context, index);
          },
        ),
      ),
    );

  }



  Widget buildCell(BuildContext context, int index){
    return GestureDetector(
      onTap: (){
        _navigateTo(context, index);
      },
      child: Image.network(
        images[index],
        fit: BoxFit.cover,
        width: 110,
        height: 110,
      ),
    );
  }

  _navigateTo(BuildContext context, int index){
    if(index==0){
      Navigator.push(context, MaterialPageRoute(builder: (context) => Search()));
    }else if(index==1){
      Navigator.push(context, MaterialPageRoute(builder: (context) => SearchProducts()));
    }return;
  }

  onSelectet(BuildContext context, int item) {
    switch(item){
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
        break;
        case 1:
          Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
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
        //Navigator.push(context, MaterialPageRoute(builder: (context) => Usuario(/*usu:usu*/)));
      print(usu.email);
        Navigator.push(context, MaterialPageRoute(builder: (context) => Usuario(userid: usu.email)));
        break;
      }

  }
}

