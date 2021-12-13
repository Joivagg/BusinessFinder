import 'package:businessfinder/controller/order_dao.dart';
import 'package:businessfinder/controller/product_dao.dart';
import 'package:businessfinder/model/orders.dart';
import 'package:businessfinder/model/product.dart';
import 'package:businessfinder/view/addorder_form.dart';
import 'package:businessfinder/view/order_view.dart';
import 'package:businessfinder/view/store_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/store_dao.dart';
import '../model/stores_data.dart';

 main() {
  StoresDAO.addStoresFromServer().then((value) {
    runApp(ProductInfo(product: ProductsDAO.listadoProductos[0]));
  });
}//runApp(MyApp());

class ProductInfo extends StatefulWidget {
  final Product product;
  const ProductInfo({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  void handleTap(int option, BuildContext context){
    switch(option){
      case 1:{
        Navigator.push(context, MaterialPageRoute(builder: (context) => Carrito()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Producto: '+widget.product.name),
          actions: <Widget>[ //lista de  widgets
            PopupMenuButton<int>( //menu contextual
              onSelected: (item){
                handleTap(item, context);
            },
              itemBuilder: (context) => [
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
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            if(!Product.isInCarrito(widget.product)){
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddCarrito(product: widget.product)));
            }else{
              showDialog(context: context, builder: (context) =>
                  AlertDialog(
                    title: Text('Ya lo agregaste al carrito'),
                    content: Text('¿Deseas eliminar el producto del carrito?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text('No'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                          Navigator.pop(context);
                          setState(() {
                            ShopProductsDAO.carrito.removeWhere((element) => element.product == widget.product);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Producto eliminado del carrito'))
                          );
                        },
                        child: Text('Yes'),
                      ),
                    ],
                  )
              );
            }
          },
          backgroundColor: Colors.deepOrange,
          child: const Icon(Icons.add_shopping_cart_outlined),
        ),
        body: Center(
            child: Info(widget.product)
        )
    );
  }
}

class Info extends StatefulWidget {
  final Product product;
  const Info(this.product);
  Display createState() => Display();
}

class Display extends State<Info> {
  final _biggerFont = GoogleFonts.aclonica(fontSize: 30,fontWeight: FontWeight.bold, shadows: <Shadow>[const Shadow(color: Colors.black26, blurRadius: 5, offset: Offset(5,5))]);
  //static List<Stores> _stores = StoresDAO.listadoTiendas;
  
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildInfo(widget.product),
    );
  }

  Widget _buildInfo(Product product) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              Center(child: Text('\n'+product.name+'\n', style: _biggerFont)),
              Images(product),
              Divider()
            ],
          ),
          ListTile(
            title: Column(
              children: [
              const Text('\nNegocio que lo ofrece:\n', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)),
                ElevatedButton(
                  style: ButtonStyle(
                    textStyle: MaterialStateProperty.all(GoogleFonts.aclonica()),
                    backgroundColor: MaterialStateProperty.all(Colors.brown)
                  ),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DisplayInfo(store: product.getStore(product))));
                  },
                  child: Text(
                    product.getStore(product).name.toString(),
                    style: TextStyle(fontSize: 18, shadows: <Shadow>[Shadow(color: Colors.brown.shade900, blurRadius: 3, offset: Offset(2,2))]),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            subtitle: Column(
              children: [
                const Text('\n\nDescripción', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)),
                Text('\n'+product.description+'\n', style: const TextStyle(fontWeight: FontWeight.bold)),
                Divider(),
                const Text('\nPrecio', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)),
                Text('\n\$ '+product.price.toString()+'\n\n', style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ]
      ),
    );
  }

  Widget Images(Product product){
    if(product.images.toString().replaceAll('[]', '').isNotEmpty){
      return SizedBox(
        height: 247,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: product.images.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
                child: Image.network(product.images[index], height: 120, fit: BoxFit.contain)
            );
          },
        ),
      );
    }else {
      return Text('Sin imágenes en el momento.');
    }
  }
}