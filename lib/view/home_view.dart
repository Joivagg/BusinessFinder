import 'package:businessfinder/view/search.dart';
import 'package:businessfinder/view/search_products.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  static final List<String> images = [
    'https://logowik.com/content/uploads/images/flutter5786.jpg',
    'https://logowik.com/content/uploads/images/flutter5786.jpg',
    'https://logowik.com/content/uploads/images/flutter5786.jpg',
    'https://logowik.com/content/uploads/images/flutter5786.jpg',
  ];
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final wordPair = WordPair.random();
    return MaterialApp(
      //title: 'Generador de Nombres',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Menú Principal'),
          backgroundColor: Colors.blue,
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

}