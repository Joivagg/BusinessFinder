import 'package:businessfinder/view/store_info.dart';
import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../controller/store_dao.dart';
import '../model/stores_data.dart';

void main() {
  StoresDAO.addStoresFromServer().then((value) {
    runApp(const Search(StoreType.tienda));
  });
}//runApp(MyApp());

class Search extends StatefulWidget {
  final StoreType start;
  const Search(this.start);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Nuestras tiendas')
        ),
        body: Center(
            child: ListSearch(widget.start)
        )
    );
  }
}

class ListSearch extends StatefulWidget {
  final StoreType start;
  const ListSearch(this.start);
  ListSearchState createState() => ListSearchState(start);
}

class ListSearchState extends State<ListSearch> {
  final StoreType start;
  ListSearchState(this.start);
  final _biggerFont = const TextStyle(fontSize: 18.0);
  late List<StoreType> value= [start];
  late List<S2Choice<StoreType>> filterOptions = optionMaker(getStoreTypes());
  static List<Stores> _stores = StoresDAO.listadoTiendas;
  late List<Stores> newDataList = initialAsign();
  late List<Stores> _storesFilter = newDataList;
  TextEditingController _textController = TextEditingController();

  List<Stores> initialAsign (){
    List<Stores> filtrados=[];
    if(value.isEmpty || value.contains(StoreType.todos)){
      filtrados = _stores;
    }else if(!value.contains(StoreType.todos)) {
      filtrados = _stores.where((store) {
        late bool res=false;
        for (StoreType i in value) {
          res = store.type.toString().contains(i.toString());
          if(res){
            return res;
          }
        }
        return res;
      }).toList();
    }
    return filtrados;
  }

  List<S2Choice<StoreType>> optionMaker(List<StoreType> list){
    List<S2Choice<StoreType>> listafinal =[];
    for(StoreType i in list){
      listafinal.add(S2Choice(value: i, title: i.toString().replaceFirst('StoreType.', '')));
    }
    if(!value.contains(StoreType.todos)){

    }else{
      listafinal.removeWhere((element) => !(element.value==StoreType.todos));
    }
    return listafinal;
  }

  onItemChanged(String value) {
    setState(() {
      newDataList = _storesFilter
          .where((store) => store.name.toLowerCase().contains(value.toLowerCase()))
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
    return SingleChildScrollView(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              filter(),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText: 'Nombre del negocio...',
                  ),
                  onChanged: onItemChanged,
                ),
              ),
              Flexible(
                  fit: FlexFit.loose,
                  child: SizedBox(
                    height: 450,
                    child: ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: newDataList.length * 2,
                        itemBuilder: /*1*/ (context, i) {
                          if (i.isOdd) return const Divider();
                          /*2*/
                          final index = i ~/ 2; /*3*/
                          return _buildRow(newDataList[index]);
                        }
                    ),
                  )
              )
            ]
        )
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