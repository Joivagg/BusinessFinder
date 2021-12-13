import 'package:businessfinder/controller/store_dao.dart';
import 'package:flutter/material.dart';
import 'package:businessfinder/model/stores_data.dart';

class StoresListView extends StatefulWidget{
  const StoresListView({Key? key}) : super(key: key);

  @override
  _StoresListViewState createState() => _StoresListViewState();
}

class _StoresListViewState extends State {
  final _stores = StoresDAO.listadoTiendas;
  final _biggerFont = const TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de Tiendas'),
      ),
      body: _buildStoreList(),
    );
  }

  Widget _buildStoreList() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _stores.length * 2,
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return const Divider();
          /*2*/
          final index = i ~/ 2; /*3*/
          return _buildRow(_stores[index]);
        });
  }

  Widget _buildRow(Stores store) {
    return ListTile(
      title: Text(
        store.name,
        style: _biggerFont,
      ),
      subtitle: Text(
        store.address+'\n',
        style: const TextStyle(
          fontSize: 16,
          color: Colors.lime,
        ),
      ),
      trailing: Icon(
        Icons.access_alarm,
        size: 50,
        color: Colors.orange
      ),
      onTap:(){
        print(store.cellphone);
      },
      onLongPress: (){
        print(store.phone);
      },
    );
  }
}