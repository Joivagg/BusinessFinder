import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../controller/store_dao.dart';
import '../model/stores_data.dart';

void main() {
  StoresDAO.addStoresFromServer().then((value) {
    runApp(SearchProducts());
  });
}//runApp(MyApp());

class SearchProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
                title: Text('Quiero comprar')
            ),
            body: Center(
                child: ListSearch()
            )
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
          .where((store) => store.products.toLowerCase().contains(value.toLowerCase()))
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
         title: "Tipo de empresa",
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
             subtitle: const Text('Selecciona algún filtro'),
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
              hintText: 'Search Here...',
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
        '\n'+store.address+'\n\n'+store.type.toString().replaceFirst('StoreType.', '')+'\n\n'+store.products,
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