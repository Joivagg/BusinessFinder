import 'package:businessfinder/model/stores_data.dart';
import 'package:businessfinder/model/users_data.dart';
import 'package:businessfinder/view/register.dart';
import 'package:businessfinder/view/search.dart';
import 'package:businessfinder/view/search_products.dart';
import 'package:businessfinder/view/usuario.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Users _usu=new Users(0, 'Invitado ', 'address', 'email', 'cellphone', 'password', UserType.invitado);
    //final wordPair = WordPair.random();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      //title: 'Generador de Nombres',
        home: HomeScreen(usu:_usu));
  }
}
class HomeView2 extends StatelessWidget{
  final Users usu;
  const HomeView2({Key? key, required this.usu}) : super(key: key);
  @override
    Widget build(BuildContext context) {
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
    'https://drive.google.com/uc?export=view&id=1KAv_eOF9m_8h8G9QkeR93-CbYzwORPA_',
    'https://drive.google.com/uc?export=view&id=1_0NTq-6ePTn3bJwpIL2oEK_7-tw9kjzT',
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('BussinessFinder',style: GoogleFonts.dancingScript(fontWeight: FontWeight.bold,fontSize: 30, shadows: <Shadow>[const Shadow(color: Colors.black26, blurRadius: 5, offset: Offset(5,5))]),),
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
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child:GestureDetector(
                onTap: (){
                  _navigateTo(context, 0);
                },
                child: Image.network(
                  images[0],
                  fit: BoxFit.cover,
                  height: 240,
                ),
              ),
            ),
            Card(
              child:GestureDetector(
                onTap: (){
                  _navigateTo(context, 1);
                },
                child: Image.network(
                  images[1],
                  fit: BoxFit.cover,
                  height: 240,
                ),
              ),
            )
          ],
        ),
      )/*Container(
        padding: EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: images.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, // numero de elementos en la fila
              mainAxisSpacing: 4.0),
          itemBuilder: (BuildContext context, int index){
            return buildCell(context, index);
          },
        ),
      ),*/
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
      Navigator.push(context, MaterialPageRoute(builder: (context) => Search(StoreType.todos)));
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

