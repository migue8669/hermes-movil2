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
  List<String> lista = [];
  List<Map<String, int>> productoycantidad = [
    {"": 0}
  ];
  List<int> tralingObject = [];
  var inicial = 0;
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
                if (tralingObject.isEmpty) {
                  tralingObject.insert(i, 0);
                }
                if (lista.isEmpty) {
                  lista.insert(i, "");
                }
                if (productoycantidad.isEmpty) {
                  productoycantidad.insert(i, {"": 0});
                }
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
                                        print("traling");
                                        print(tralingObject);
                                        print("i");
                                        print(i);
                                        inicial++;
                                        if (i > 0 && inicial == 1) {
                                          tralingObject.insert(0, 0);
                                          tralingObject.forEach((element) {
                                            print("for");
                                            print(i);
                                          });
                                          print("object1");
                                          print(tralingObject);
                                        }
                                        if (tralingObject[i] != null ||
                                            tralingObject[i] != 0) {
                                          contadorSuma = tralingObject[i];
                                          contadorSuma++;
//productos[i].cantidad = contadorSuma;tra
                                          if (tralingObject.length <= 1) {
                                            tralingObject.insert(
                                                i, contadorSuma);
                                            print("tralingObject11");
                                            print(tralingObject);
                                            lista.insert(
                                                i, productos[i].nombre);
                                            print("lista");
                                            print(lista);
                                          } else {
                                            if (productoycantidad.length >= 1) {
                                              //     productoycantidad.removeAt(i);

                                              tralingObject.removeAt(i);
                                              //         lista.removeAt(i);
                                              lista.insert(
                                                  i, productos[i].nombre);
                                              print("lista");
                                              print(lista);

                                              tralingObject.insert(
                                                  i, contadorSuma);
                                              print("tralingObject22");
                                              print(tralingObject);
                                            }
                                            isSelected = false;
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
                                                .actualizarProducto(
                                                    productos[i]);
                                            print(
                                                "if cantidad diferente de null");
                                          }
                                        } else {
                                          // tralingObject.forEach((i) {
                                          //   print(i);
                                          // });
                                          tralingObject.insert(i, 0);
                                          if (contadorSuma == null) {
                                            print("if contadorSuma null");

                                            contadorSuma = 0;
                                          }
                                          contadorSuma++;
                                          productos[i].cantidad = contadorSuma;
                                          tralingObject.insert(i, contadorSuma);
                                          print("tralingObject");
                                          print(tralingObject);
                                          lista.insert(i, productos[i].nombre);
                                          print("lista");
                                          print(lista);
                                          productosProvider
                                              .guardarProducto(productos[i]);
                                          print("else de cantidad = null");
                                          print("i");
                                          print(i);
                                          print("contadorSuma");
                                          print(contadorSuma);
                                          isSelected = false;

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

                                        //contadorSuma = 0;
                                        setState(() {
                                          if (isSelected == false) {
                                            contadorResta = tralingObject[i];
                                            print(productoycantidad);
                                            productoycantidad.insert(i,
                                                {lista[i]: tralingObject[i]});
                                            // lista.add(producto);
                                            print("productoycantidadSS");

                                            print(productoycantidad);
                                            // mycolor = Colors.blue;
                                            isSelected = true;

                                            // return lista;
                                          } else {
                                            //  lista.remove(producto);
                                            mycolor = Colors.grey[300];
                                            isSelected = false;
                                          }
                                        });
                                        // tralingObject.clear();
                                      }),
                                  IconButton(
                                      icon: Icon(Icons.remove),
                                      onPressed: () {
                                        isSelected = false;

                                        // tralingObject.clear();
                                        if (tralingObject[i] == null) {
                                          tralingObject[i] = 0;
                                        }
                                        contadorSuma = tralingObject[i];
                                        print(contadorSuma);
                                        contadorSuma--;
                                        productoycantidad.removeAt(i);
                                        tralingObject.removeAt(i);
                                        lista.removeAt(i);
                                        lista.insert(i, productos[i].nombre);
                                        tralingObject.insert(i, contadorSuma);
                                        contadorResta = tralingObject[i];
                                        //.removeAt(i);
                                        print("productoycantidad114");
                                        print(lista);
                                        print(tralingObject);
                                        print(productoycantidad);

                                        productos[i].cantidad = contadorSuma;
                                        productosProvider
                                            .actualizarProducto(productos[i]);
                                      })
                                ])
                              : null,
                        ),
                        Text((contadorResta == null
                            ? ""
                            : contadorResta.toString()))
                      ],
                    )));
              });
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  // void toggleSelection(producto) {
  //   // ignore: missing_return
  //   setState(() {
  //     if (isSelected == false) {
  //       contadorResta = tralingObject[i];
  //       // lista.add(producto);
  //       // print(lista);
  //       // mycolor = Colors.blue;
  //       // isSelected = true;

  //       // return lista;
  //     } else {
  //       //  lista.remove(producto);
  //       mycolor = Colors.grey[300];
  //       isSelected = false;
  //     }
  //   });
  // }

  _crearBoton(BuildContext context) {
    // productoycantidad.removeLast();
    return FloatingActionButton(
        heroTag: "btn1",
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          print(productoycantidad);
          print("a otra pantalla");
          //productoycantidad.removeLast();
          Navigator.pushNamed(context, 'despacho',
              arguments: productoycantidad.toString());
        });
  }
}
