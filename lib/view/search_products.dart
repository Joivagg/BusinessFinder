import 'package:businessfinder/model/product.dart';
import 'package:businessfinder/view/store_info.dart';
import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../controller/store_dao.dart';
import '../model/stores_data.dart';
import 'order_view.dart';

void main() {
  StoresDAO.addStoresFromServer().then((value) {
    runApp(SearchProducts());
  });
}//runApp(MyApp());

class SearchProducts extends StatelessWidget {

  void handleTap(int option, BuildContext context){
    switch(option){
      case 0:{
        break;
      }
      case 1:{
        Navigator.push(context, MaterialPageRoute(builder: (context) => Carrito()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Quiero comprar'),
          actions: <Widget>[ //lista de  widgets
            PopupMenuButton<int>( //menu contextual
              onSelected: (item){
                handleTap(item, context);
              },
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                    value: 0,
                    child: Column(children:[
                      Text('Ver en Google Maps'),
                      Divider()
                    ]
                    )
                ),
                PopupMenuItem<int>(
                    value: 1,
                    child: Column(children:[
                      Text('Carrito de compras'),
                      Divider(),
                    ]
                    )
                ),
              ],
            ),
          ],
        ),
        body: Center(
            child: ListSearch()
        )
    );
  }
}

class ListSearch extends StatefulWidget {
  ListSearchState createState() => ListSearchState();
}

class ListSearchState extends State<ListSearch> {
  final _biggerFont = const TextStyle(fontSize: 18.0);
  late List<StoreType> value= [];
  late List<S2Choice<StoreType>> filterOptions = optionMaker(getStoreTypes());
  static List<Stores> _stores = StoresDAO.listadoTiendas;
  late List<Stores> _storesFilter = _stores;
  TextEditingController _textController = TextEditingController();

  // Copy Main List into New List.
  List<Stores> newDataList = List.from(_stores);

  List<S2Choice<StoreType>> optionMaker(List<StoreType> list){
    List<S2Choice<StoreType>> listafinal =[];
    for(StoreType i in list){
      listafinal.add(S2Choice(value: i, title: i.toString().replaceFirst('StoreType.', '')));
    }
    if(!value.contains(StoreType.todos)){

    }else{
      //value.removeWhere((element) => !(element==StoreType.todos));
      listafinal.removeWhere((element) => !(element.value==StoreType.todos));
    }
    return listafinal;
  }

  onItemChanged(String value) {
    setState(() {
      newDataList = _storesFilter
          .where((store) {
        if(store.products.isNotEmpty) {
          bool res = true;
          for (Product i in store.products) {
            if (i.name.toLowerCase().contains(value.toLowerCase())) {
              res = true;
              return res;
            } else {
              res = false;
            }
          }
          return res;
        }else{
          return false;
        }
      }/*store.products.toLowerCase().contains(value.toLowerCase())*/)
          .toList();
    });
  }

  typeFilter(List<StoreType> values) {
    setState(() {
      if(values.isEmpty){
        _storesFilter = _stores;
      }else if(!values.contains(StoreType.todos)) {
        _storesFilter = _stores.where((store) {
          late bool res=false;
          for (StoreType i in values) {
            res = store.type.toString().contains(i.toString());
            if(res){
              return res;
            }
          }
          return res;
        }).toList();
      }else {
        _storesFilter = _stores;
      }
      newDataList = _storesFilter;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildStoreList(),
    );
  }

  List<StoreType> selection(){
    if(value.contains(StoreType.todos)){
      value=getStoreTypes();
    }return value;
  }

  Widget filter(){
    return SmartSelect<StoreType>.multiple(
      title: "Tipo de producto",
      value: value,
      choiceItems: optionMaker(getStoreTypes()),
      onChange: (state){
        setState((){
          if(state.value.contains(StoreType.todos)){
            value=[StoreType.todos];
          }else {
            value = state.value;
          }
          typeFilter(value);
        });
      },
      tileBuilder: (context, state) {
        return S2ChipsTile<StoreType>(
          title: state.titleWidget,
          values: state.valueObject,
          onTap: state.showModal,
          subtitle: const Text('Selecciona alg??n filtro'),
          /*leading: const CircleAvatar(
               backgroundImage: NetworkImage('https://source.unsplash.com/8I-ht65iRww/100x100'),
             ),*/
          trailing: const Icon(Icons.add_circle_outline),
          scrollable: true,
          divider: const Divider(height: 1),
          chipColor: Colors.red,
          chipBrightness: Brightness.dark,
        );
      },
    );
  }

  Widget _buildStoreList() {
    return Column(
        children: <Widget>[
          filter(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Nombre del producto...',
              ),
              onChanged: onItemChanged,
            ),
          ),
          Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: newDataList.length * 2,
                  itemBuilder: /*1*/ (context, i) {
                    if (i.isOdd) return const Divider();
                    /*2*/
                    final index = i ~/ 2; /*3*/
                    return _buildRow(newDataList[index]);
                  }
              )
          )
        ]
    );
  }

  Widget _buildRow(Stores store) {
    return ListTile(
      title: Text(
        store.name,
        style: _biggerFont,
      ),
      subtitle: Text(
        '\n'+store.address+'\n\n'+store.type.toString().replaceFirst('StoreType.', ''),
        style: const TextStyle(
          fontSize: 16,
          color: Colors.lime,
        ),
      ),
      leading: Image(
        image: NetworkImage(store.logo),
      ),
      trailing: Icon(Icons.arrow_forward_ios_outlined),
      onTap:(){
        Navigator.push(context, MaterialPageRoute(builder: (context) => DisplayInfo(store: store)));
      },
      onLongPress: (){
        print(store.phone);
      },
    );
  }
}