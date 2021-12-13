
import 'package:businessfinder/controller/client_dao.dart';
import 'package:businessfinder/controller/order_dao.dart';
import 'package:businessfinder/controller/server_connection.dart';
import 'package:businessfinder/controller/store_dao.dart';
import 'package:businessfinder/model/orders.dart';
import 'package:businessfinder/view/product_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  StoresDAO.addStoresFromServer().then((value) {
    runApp(Carrito());
  });
}

class Carrito extends StatelessWidget {
  const Carrito({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Mi carrito de compras';

    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle),
      ),
      body: CarroView(),
    );
  }
}

// Create a Form widget.
class CarroView extends StatefulWidget {
  const CarroView({Key? key}) : super(key: key);

  @override
  CarroViewState createState() {
    return CarroViewState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class CarroViewState extends State<CarroView> {
  bool cargando =false;

  void opcionProd(int option, BuildContext context, ShopProd product){
    switch(option){
      case 0:{
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductInfo(product: product.product)));
        break;
      }
      case 1:{
        setState(() {
          ShopProductsDAO.carrito.remove(product);
        });
        break;
      }
    }
  }

  double calcPrice(){
    double pr=0;
    for(ShopProd i in ShopProductsDAO.carrito){
      pr += (i.units*i.product.price);
    }
    return pr;
  }

  Future<Order> tipoPedido(BuildContext context) async {
    late Order pedido =Order(OrdersDAO.lastId()+1, ShopProductsDAO.carrito, ClientDAO.clienteActual.id ,calcPrice());
    await showDialog(context: context, builder: (context) =>
        AlertDialog(
          title: Text('¿Qué prefieres?'),
          content: Text('¿Deseas recibir el pedido en tu domicilio, o recogerlo en tienda?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                pedido.tipo = OrderType.domicilio;
                Navigator.of(context).pop(true);
              },
              child: Text('Pedir domicilio'),
            ),
            TextButton(
              onPressed: () async {
                pedido.tipo = OrderType.recoger;
                Navigator.of(context).pop(true);
              },
              child: Text('Recoger en tienda'),
            ),
          ],
        )
    );
    return pedido;
  }

  void lol () async {
    Order pedido = await tipoPedido(context);
    DateTime now= DateTime.now();
    OrdersDAO.listadoPedidos.add(pedido);
    var con = ServerConnection();
    var formatter = DateFormat('yyyy-MM-dd');
    pedido.fecha = formatter.format(now);
    setState(() {
      cargando = true;
    });
    await con.insert('Order', pedido.id.toString()+';'
        + pedido.id_client.toString()+';'
        +pedido.price.toString()+';'
        + pedido.tipo.toString().replaceAll('OrderType.', '')+';'
        +pedido.fecha.toString().replaceAll(' 0:00:00', ''));
    for(ShopProd i in ShopProductsDAO.carrito){
      await con.insert('ShopProd', i.id_order.toString()+';'+i.product.id.toString()+';'+i.product.id_store.toString()+';'+i.units.toString());
    }
    setState(() {
      ShopProductsDAO.carrito.clear();
      cargando = false;
    });
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('¡Su pedido se ha enviado con éxito!'))
    );
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    if(!cargando){
      if(ShopProductsDAO.carrito.isNotEmpty){
        return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: ShopProductsDAO.carrito.length * 2,
            itemBuilder: /*1*/ (context, i) {
              if (i.isOdd) return const Divider(thickness: 5);
              /*2*/
              /*3*/
              final index = i ~/ 2;
              if(ShopProductsDAO.carrito[index]==ShopProductsDAO.carrito.last){
                return Column(
                  children: [
                    _buildRow(ShopProductsDAO.carrito[index]),
                    Divider(thickness: 10, color: Colors.indigo,),
                    Divider(thickness: 10, color: Colors.indigo.shade200,),
                    Card(
                      color: Colors.indigo.shade50,
                      child: ListTile(
                        /*leading: IconButton(
                          highlightColor: Colors.red,
                          focusColor: Colors.red,
                            onPressed: (){

                            },
                            icon: Icon(Icons.clear)),*/
                        title: const Text(
                            'Total:\t'
                        ),
                        subtitle: Column(
              children: [
                const SizedBox(height: 10),
              Text('\$'+calcPrice().toString(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo,fontSize: 25)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.red.shade900)
                        ),
                        onPressed: (){
                          showDialog(context: context, builder: (context) =>
                              AlertDialog(
                                title: Text('¿Seguro?'),
                                content: Text('¿Desea descartar el pedido?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(false),
                                    child: Text('No'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.of(context).pop(true);
                                      setState(() {
                                        ShopProductsDAO.carrito.clear();
                                      });
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Pedido descartado'))
                                      );
                                    },
                                    child: Text('Yes'),
                                  ),
                                ],
                              )
                          );
                        },
                        child: Text('Descartar pedido')),
                    const SizedBox(width: 7,),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.green)
                        ),
                        onPressed: (){
                          showDialog(context: context, builder: (context) =>
                              AlertDialog(
                                title: Text('¿Seguro?'),
                                content: Text('¿Desea confirmar el pedido?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(false),
                                    child: Text('No'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.of(context).pop(true);
                                      lol();
                                    },
                                    child: Text('Yes'),
                                  ),
                                ],
                              )
                          );
                        },
                        child: Text('Confirmar pedido')),
                  ],
                )
              ],
              ),
                        /*trailing: FloatingActionButton.extended(
                          onPressed: () {

                          },
                          label: Text('Confirmar pedido',style: TextStyle(fontSize: 10),),

                        ),*/
                      ),
                    )
                  ],
                );
              }
              else {
                return _buildRow(ShopProductsDAO.carrito[index]);
              }
            }
        );
      }else{
        return const Center(
            child: Text(('Aún no has añadido productos a tu carrito'))
        );
      }
    }else{
      return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
          CircularProgressIndicator(),
          SizedBox(height: 25),
          Text('Enviando pedido, espere por favor...')
      ]
          )
    );
    }


  }

  Widget _buildRow(ShopProd product) {
    return ListTile(
      leading: Image.network(product.product.images[0]),
      title: Column(
        children: [
          ListTile(
            title: Text(product.product.name),
            subtitle: Text('Precio:  \$'+product.product.price.toString()),
          )
        ],
      ),
      subtitle: Column(
        children: [
          ListTile(
          title: Text('Unidades:'),
            subtitle: Text(product.units.toString()),
        ),
          ListTile(
            title: Text('Total:'),
            subtitle: Text(
              '\$'+(product.units*product.product.price).toString(),
              style: const TextStyle(
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold
              )
            ),
          )
        ],
      ),
      trailing: PopupMenuButton<int>( //menu contextual
        onSelected: (item){
          opcionProd(item, context, product);
        },
        itemBuilder: (context) => [
          PopupMenuItem<int>(
              value: 0,
              child: Column(children:[
                Text('Ver producto'),
              ]
              )
          ),
          PopupMenuItem<int>(
              value: 1,
              child: Column(children:[
                Text('Eliminar producto'),
              ]
              )
          ),
        ],
      ),
    );
  }
}