import 'dart:math';

import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/models/despachos_model.dart';
import 'package:formvalidation/src/models/pedido.model.dart';
import 'package:formvalidation/src/models/producto_model.dart';
import 'package:formvalidation/src/models/seleccionado.model.dart';
import 'package:formvalidation/src/pages/despacho_page.dart';
import 'dart:developer';

import 'package:formvalidation/src/providers/productos_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var isSelected = false;
  var mycolor = Colors.white;
//  List<Map<String, dynamic>> lista = [];
  List<SeleccionadoModel> productoIndex = List<SeleccionadoModel>();
  List<SeleccionadoModel> cantidadPedido = List<SeleccionadoModel>();
  var z = 0;
  List<int> lista = [];
  List<Map<String, int>> productoycantidad = [
    {"": 0}
  ];
  List<int> tralingObject = [];

  var contadorSuma = 0;
  var contadorResta = 0;
  final productosProvider = new ProductosProvider();
  final pedido = new PedidoModel();

  final myController = TextEditingController();
  @override
  void initState() {
    super.initState();

    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  _printLatestValue() {
    print("Second text field: ${myController.text}");
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Scaffold(
        appBar: AppBar(title: Text('Home')),
        body: _crearListado(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _crearBoton(context),
            ],
          ),
        ));
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: productosProvider.cargarProductos(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        // print(snapshot.hasData);

        if (snapshot.hasData) {
          final productos = snapshot.data;

          return ListView.builder(
              itemCount: productos.length,
              itemBuilder: (context, i) {
                return Dismissible(
                    key: UniqueKey(),
                    // Key(productos[i].key),
                    background: Container(
                      color: Colors.red,
                    ),
                    onDismissed: (direccion) {
                      // productosProvider.borrarProducto(productos[i].key);
                    },
                    child: Card(
                        child: Column(
                      children: <Widget>[
                        (productos[i].imageUrl == null)
                            ? Image(image: AssetImage('assets/no-image.png'))
                            : FadeInImage(
                                image: NetworkImage(productos[i].imageUrl),
                                placeholder:
                                    AssetImage('assets/jar-loading.gif'),
                                height: 300.0,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                        ListTile(
                          //   selected: isSelected,

                          title: Text(
                              '${productos[i].nombre} - ${productos[i].precio}'),

                          // subtitle: Text(contadorSuma.toString()),
                          trailing: (productos[i].cantidad == null)
                              ? Wrap(children: <Widget>[
                                  IconButton(
                                      icon: Icon(Icons.add),
                                      onPressed: () {
                                        if (productos[i].cantidad != null) {
                                          contadorSuma = productos[i].cantidad;
                                          contadorSuma++;
                                          productos[i].cantidad = contadorSuma;
                                          tralingObject.insert(i, contadorSuma);
                                          print("tralingObject");
                                          print(tralingObject);
                                          // List.generate(i, (index) {
                                          //   productoIndex.add(SeleccionadoModel(
                                          //       i, contadorSuma));
                                          // });
                                          // List.generate(productos.length,
                                          //     (index) {
                                          //   cantidadPedido.clear();

                                          // cantidadPedido.add(SeleccionadoModel(
                                          //     i, contadorSuma)); // });
                                          // print("cantidadPedido-list");
                                          // for (var i = 0;
                                          //     i < cantidadPedido.length;
                                          //     i++) {
                                          //   print(
                                          //       'index=$i, value=${cantidadPedido[i].cantidad}');
                                          // }
                                          // cantidadPedido
                                          //     .asMap()
                                          //     .forEach((i, value) {
                                          //   print('index=$i, value=$value');
                                          // });
                                          productosProvider
                                              .actualizarProducto(productos[i]);
                                          print(
                                              "if cantidad diferente de null");
                                        } else {
                                          if (contadorSuma == null) {
                                            print("if contadorSuma null");

                                            contadorSuma = 0;
                                          }
                                          contadorSuma++;
                                          productos[i].cantidad = contadorSuma;
                                          tralingObject.insert(i, contadorSuma);
                                          print("tralingObject");
                                          print(tralingObject);

                                          productosProvider
                                              .guardarProducto(productos[i]);
                                          print("else de cantidad = null");
                                          print("i");
                                          print(i);
                                          print("contadorSuma");
                                          print(contadorSuma);

                                          // List.generate(productos.length,
                                          //     (index) {
                                          //        cantidadPedido.clear();
                                          // cantidadPedido.add(SeleccionadoModel(
                                          //     i, contadorSuma));
                                          // // });
                                          // print("cantidadPedido-list");
                                          // for (var i = 0;
                                          //     i < cantidadPedido.length;
                                          //     i++) {
                                          //   print(
                                          //       'index=$i, value=${cantidadPedido[i].cantidad},value=${cantidadPedido[i].key}');
                                          // }
                                          // cantidadPedido
                                          //     .asMap()
                                          //     .forEach((i, value) {
                                          //   print('index=$i, value=$value');
                                          // });
                                        }
                                        contadorSuma = 0;
                                        // tralingObject.clear();
                                      }),
                                  IconButton(
                                      icon: Icon(Icons.remove),
                                      onPressed: () {
                                        // tralingObject.clear();
                                        if (contadorSuma == null) {
                                          contadorSuma = 0;
                                        }
                                        contadorSuma = productos[i].cantidad;
                                        print(contadorSuma);
                                        contadorSuma--;
                                        tralingObject.add(contadorSuma);
                                        print("contadorSuma ");
                                        print(tralingObject);
                                        productos[i].cantidad = contadorSuma;
                                        productosProvider
                                            .actualizarProducto(productos[i]);
                                      })
                                ])
                              : null,
                        ),
                        Text((tralingObject.isEmpty
                            ? ""
                            : tralingObject[i].toString()))
                      ],
                    )));
              });
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  void toggleSelection(producto) {
    // ignore: missing_return
    setState(() {
      if (isSelected == false) {
        lista.add(producto);
        print(lista);
        mycolor = Colors.blue;
        isSelected = true;

        return lista;
      } else {
        //  lista.remove(producto);
        mycolor = Colors.grey[300];
        isSelected = false;
      }
    });
  }

  _crearBoton(BuildContext context) {
    // productoycantidad.removeLast();
    return FloatingActionButton(
        heroTag: "btn1",
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          productoycantidad.removeLast();
          Navigator.pushNamed(context, 'despacho',
              arguments: productoycantidad.toString());
        });
  }
}
