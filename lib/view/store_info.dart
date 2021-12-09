import 'package:businessfinder/view/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/link.dart';
import '../controller/store_dao.dart';
import '../model/stores_data.dart';

 main() {
  StoresDAO.addStoresFromServer().then((value) {
    runApp(DisplayInfo(store: StoresDAO.listadoTiendas[1]));
  });
}//runApp(MyApp());

class DisplayInfo extends StatelessWidget {
  final Stores store;
  const DisplayInfo({Key? key, required this.store}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Información')
        ),
        body: Center(
            child: Info(store)
        )
    );
  }
}

class Info extends StatefulWidget {
  final Stores store;
  const Info(this.store);
  Display createState() => Display();
}

class Display extends State<Info> {
  final _biggerFont = GoogleFonts.aclonica(fontSize: 30,fontWeight: FontWeight.bold, shadows: <Shadow>[const Shadow(color: Colors.black26, blurRadius: 5, offset: Offset(5,5))]);
  //static List<Stores> _stores = StoresDAO.listadoTiendas;
  
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildInfo(widget.store),
    );
  }

  Widget _buildInfo(Stores store) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              Image(image: NetworkImage(store.logo, scale: 3)),
              Center(child: Text('\n'+store.name+'\n', style: _biggerFont))
            ],
          ),
          ListTile(
            title: FloatingActionButton.extended(
              foregroundColor: Colors.white,
              backgroundColor: Colors.deepOrange,
              splashColor: Colors.white,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Search(store.type)));
              },
              label: Text(
                store.type.toString().replaceAll('StoreType.', ''),
                style: TextStyle(fontSize: 18, shadows: <Shadow>[Shadow(color: Colors.deepOrange.shade900, blurRadius: 3, offset: Offset(2,2))]),
                textAlign: TextAlign.center,
              ),
            ),
            subtitle: Column(
              children: [
                const Text('\nDirección', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)),
                Text(store.address, style: const TextStyle(fontWeight: FontWeight.bold)),
                const Text('\nGeolocalización', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)),
                Text(store.latitude.toString()+', '+store.longitude.toString()+'\n\n', style: const TextStyle(fontWeight: FontWeight.bold)),
                Divider(),
              ],
            ),
          ),
          Column(
            children: [
              Text('\nGalería de Fotos\n\n', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)),
              Photos(store),
              Divider(),
              Column(
                  children: [
                    Text('\n\nLista de Productos\n', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)),
                    ProductsList(store),
                    Divider(),
                  ]
              ),
              Column(
                children: [
                  Text('\n\nInformación de contacto\n', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.indigo)),
                  Text('\nTeléfono', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)),
                  Text(store.phone, style: TextStyle( fontWeight: FontWeight.bold)),
                  Text('\nCelular', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)),
                  Text(store.cellphone, style: TextStyle( fontWeight: FontWeight.bold)),
                  Text('\nPágina Web\n', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)),
                  StoreLink(store)
                ],
              )
            ],
          )
        ]
      ),
    );
  }

  Widget Photos(Stores store){
    if(store.photo.toString().replaceAll('[]', '').isNotEmpty){
      return SizedBox(
        height: 247,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: store.photo.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
                child: Image.network(store.photo[index], height: 120, fit: BoxFit.contain)
            );
          },
        ),
      );
    }else {
      return Text('Este negocio aún no ha posteado fotos.');
    }
  }

  Widget ProductsList(Stores store){
    if(store.products.isNotEmpty){
      return SizedBox(
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: store.products.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                    child: Image.network(store.products[index].images.first, height: 120,)
                ),
                //Text(store.products[index],textAlign: TextAlign.left)
                ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 180),
                    child: ListTile(
                      title: Text(store.products[index].name,textAlign: TextAlign.left),
                      subtitle: Text('Precio:\t\t\u0020'+store.products[index].price.toString()),
                      trailing: IconButton(
                          onPressed: (){
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Datos añadidos!')),
                            );
                          },
                          icon: const Icon(Icons.add_shopping_cart_outlined)
                      ),
                    )
                )
              ],
            );
          },
        ),
      );
    }else{
      return Text('Este negocio aún no ha publicado productos en venta.');
    }
  }

  Widget StoreLink(Stores store){
    if(store.webpage.isNotEmpty){
      return Link(
          target: LinkTarget.blank,
          uri: Uri.parse(store.webpage),
          builder: (context, followLink){
            return ElevatedButton(
                child: Text('Ir'),
                onPressed: followLink
            );
          }
      );
    }else{
      return Text('Este negocio no tiene página por el momento...\n\n');
    }
  }
}