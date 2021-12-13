import 'package:businessfinder/controller/order_dao.dart';
import 'package:businessfinder/controller/product_dao.dart';
import 'package:businessfinder/controller/server_connection.dart';
import 'package:businessfinder/controller/store_dao.dart';
import 'package:businessfinder/model/orders.dart';
import 'package:businessfinder/model/product.dart';
import 'package:businessfinder/view/product_info.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

void main() {
  StoresDAO.addStoresFromServer().then((value) {
    runApp(AddCarrito(product: ProductsDAO.listadoProductos[0]));
  });
}

class AddCarrito extends StatelessWidget {
  final Product product;
  const AddCarrito({Key? key, required this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const appTitle = 'Agregar al carrito';

    return Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: MyCustomForm(product: product),
      );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  final Product product;
  const MyCustomForm({Key? key, required this.product}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  int _count = 1;
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  late String _id, _name, _cellphone, _email;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text('Producto/servicio:'),
          ListTile(
            leading: Image.network(widget.product.images[0]),
            title: Text(widget.product.name),
            subtitle: Text('\$ '+widget.product.price.toString()),
          ),
          Divider(thickness: 3),
          Text('Unidades:'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: (){
                    setState(() {
                     if(_count!=1){ _count--;}
                    });
                  },
                  icon: Icon(Icons.remove)
              ),
              NumberPicker(
                haptics: true,
                itemWidth: 50,
                axis: Axis.horizontal,
                value: _count,
                minValue: 1,
                maxValue: 100,
                onChanged: (value) => setState(() => _count = value),
              ),
              IconButton(onPressed: (){
                setState(() {
                  if(_count!=100){ _count++;}
                });
              },
                  icon: Icon(Icons.add)
              )
            ],
          ),
          const SizedBox(height: 50),
          FloatingActionButton.extended(
            onPressed: (){
              showDialog(context: context, builder: (context) =>
                  AlertDialog(
                    title: Text('Seguro?'),
                    content: Text('Agregar $_count unidades de '+widget.product.name+' al carrito?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text('No'),
                      ),
                      TextButton(
                        onPressed: () {
                          //print(OrdersDAO.lastId().toString());
                          ShopProductsDAO.carrito.add(ShopProd(OrdersDAO.lastId()+1, widget.product, _count));
                          Navigator.of(context).pop(true);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Añadido al carrito!'))
                          );
                        },
                        child: Text('Yes'),
                      ),
                    ],
                  )
              );
            },
            label: Text('Agregar'),
          )
        ],
      )
    );
  }
}