import 'package:flutter/material.dart';
import 'package:businessfinder/view/stores_view.dart';

class ScrollInfinito extends StatelessWidget {
  const ScrollInfinito({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final wordPair = WordPair.random();
    return const MaterialApp(
      title: 'Generador de Nombres',
      home: StoresListView(),
    );
  }
}