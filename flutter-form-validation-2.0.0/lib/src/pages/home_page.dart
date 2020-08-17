import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/models/despachos_model.dart';
import 'package:formvalidation/src/models/producto_model.dart';
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
  var productoL = List();
  var cantidadL = List();

  List<Map<List, String>> lista = [];
  List<Map<String, int>> productoycantidad = [];
  var contadorSuma = 0;
  var contadorResta = 0;
  final productosProvider = new ProductosProvider();
  final myController = TextEditingController();
  @override
  void initState() {
    super.initState();

    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Limpia el controlador cuando el widget se elimine del árbol de widgets
    // Esto también elimina el listener _printLatestValue
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
              //          _eliminarBoton(context)
              // FloatingActionButton(
              //   onPressed: () {},
              //   child: Icon(Icons.navigate_before),
              // ),
              // FloatingActionButton(
              //   onPressed: () {},
              //   child: Icon(Icons.navigate_next),
              // )
            ],
          ),
        )
        // floatingActionButton: _crearBoton(context),
        //floatingActionButtonAnimator: _eliminarBoton(context),
        //      floatingActionButton: _crearBoton(context),
        );
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
                Map<List, List> myObject;
                Map<List, int> myObject1;
                List<Map> tralingObject = [];

                //     Map<String, String> myObject = {
                //   productos[i].nombre: productos[contadorSuma].cantidad
                // };
                return Dismissible(
                    key: Key(productos[i].key),
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
                          subtitle: Text(productos[i].key),
                          trailing: (productos[i].cantidad == null)
                              ? IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    if (productoycantidad
                                            .where((element) =>
                                                element.containsKey(
                                                    productos[i].nombre))
                                            .length ==
                                        0) {
                                      print(productoycantidad
                                          .where((element) => element
                                              .containsKey(productos[i].nombre))
                                          .length);

                                      print("dentro de if");

                                      setState(() {
                                        contadorSuma = 0;
                                        contadorSuma++;
                                        productos[i].cantidad = contadorSuma;
                                        productoL
                                            .insert(i, {productos[i].nombre});
                                        cantidadL
                                            .insert(i, {productos[i].cantidad});

                                        productoycantidad.insert(i, {
                                          productos[i].nombre:
                                              productos[i].cantidad
                                        });
                                      });
                                      print(productoycantidad);
                                      //bloque que se encontraba en setState:
                                      //
                                      // if (contadorSuma == 0) {
                                      //   contadorSuma++;
                                      //   productos[i].cantidad = contadorSuma;
                                      // } else {
                                      //   //    contadorSuma = productos[i].cantidad;
                                      //   print(contadorSuma);

                                      //   contadorSuma++;
                                      //   productos[i].cantidad = contadorSuma;
                                      // }

                                      // productoL.add(productos[i].nombre);
                                      // cantidadL.add(productos[i].cantidad);
                                      // productoycantidad.add({
                                      //   productos[i].nombre:
                                      //       productos[i].cantidad
                                      // });

                                    } else {
                                      if (contadorSuma >= 0) {
                                        print("dentro de if contadorSuma");
                                        print(cantidadL);
                                        setState(() {
                                          print(contadorSuma);
                                          contadorSuma++;
                                          productos[i].cantidad = contadorSuma;

                                          cantidadL.insert(i, {
                                            // productos[i].nombre:
                                            productos[i].cantidad
                                          });
                                          productoycantidad.removeAt(i);
                                          productoycantidad.insert(i, {
                                            productos[i].nombre:
                                                productos[i].cantidad
                                          });
                                        });

                                        // print("cantidad desde lista");
                                        // print(cantidadL);

                                        // contadorSuma++;
                                        // productos[i].cantidad = contadorSuma;
                                        // productoycantidad.insert(i, {
                                        //   productos[i].nombre:
                                        //       productos[i].cantidad
                                        // });
                                      }
                                      //  else {
                                      //   productoL.add(productos[i].nombre);
                                      //   cantidadL.add(productos[i].cantidad);
                                      //   productoycantidad.add({
                                      //     productos[i].nombre:
                                      //         productos[i].cantidad
                                      //   });
                                      // }
                                      print("productoYcantidad");
                                      print(productoycantidad);
                                      // myObject = {productoL: cantidadL};
                                      // tralingObject.add(myObject);
                                      // print("trailing");
                                      // print(tralingObject);

                                    }
                                  })
                              : null,
                        ),
                        // trailing: IconButton(
                        //     icon: Icon(Icons.alarm),
                        //     onPressed: () {
                        //       setState(() {
                        //         contadorSuma++;
                        //       });
                        //       productoL.add(productos[i].nombre);
                        //       cantidadL.add(contadorSuma);

                        //       // print(productos[i].nombre);
                        //       myObject = {productoL: cantidadL};
                        //       lista.add(myObject);
                        //       // lista.add(myObject);
                        //       print(lista);
                        //     }

                        // onLongPress: () => {
                        //       productoL.add(productos[i].nombre),
                        //     },
                        // onTap: () => productoL.remove(productos[i].nombre)

                        //     //    toggleSelection(productos[i].nombre),

                        //     ////     Navigator.pushNamed(context, 'despacho',  arguments: lista),

                        //     //        arguments: producto),
                        //     // onTap: () => Navigator.pushNamed(context, 'despacho',
                        //     //        arguments: producto),
                        // )

                        // ButtonBar(
                        //   children: <Widget>[
                        //     FlatButton(
                        //       child: Icon(Icons.add),
                        //       //Text(contadorSuma.toString()),
                        //       onPressed: () {
                        //         setState(() {
                        //           contadorSuma++;
                        //           print(lista);
                        //         });
                        //         myObject1 = {productoL: contadorSuma};
                        //         print(myObject1);

                        //         // productoL.add(productos[i].nombre);
                        //         //cantidadL.remove(contadorSuma);
                        //         lista.clear();

                        //         // print(productos[i].nombre);
                        //         //       myObject = {productoL: contadorSuma.toString()};
                        //         print(myObject);
                        //         // if (myObject.containsValue(productoL)) {
                        //         //   myObject.remove(productoL);
                        //         // }
                        //         // if (cantidadL.remove(productos[i].nombre)) {
                        //         //   lista.clear();
                        //         // } else {
                        //         //        lista.add(myObject);
                        //         //   }
                        //         // lista.add(myObject);
                        //         print(lista);
                        //         // contadorSuma = (contadorSuma + 1);
                        //         print(contadorSuma);
                        //         // setState(() {
                        //         //   myObject = {
                        //         //     productos[i].nombre:
                        //         //         productos[contadorSuma].cantidad
                        //         //   };
                        //         //   //    toggleSelection(productos[i].nombre);
                        //         //   //  lista.add(productos[i].nombre, contadorSuma);
                        //         //   contadorSuma++;

                        //         //   lista.add(myObject);
                        //         //   print(lista);
                        //         // });
                        //         /* ... */
                        //       },
                        //     ),
                        //     FlatButton(
                        //       child: Icon(Icons.delete),
                        //       //Text(contadorResta.toString()),
                        //       onPressed: () {
                        //         // contadorSuma = (contadorSuma - 1);
                        //         print(contadorSuma);
                        //         lista.clear();
                        //         setState(() {
                        //           //toggleSelection(productos[i].nombre);
                        //           contadorSuma--;
                        //           print(lista);
                        //         });
                        //         //    productoL.add(productos[i].nombre);
                        //         //    cantidadL.remove(contadorSuma);

                        //         // print(productos[i].nombre);
                        //         //        myObject = {productoL: contadorSuma.toString()};
                        //         print(myObject);
                        //         /* ... */
                        //         print(lista);
                        //         print(contadorSuma);
                        //       },
                        //     ),
                        Text(contadorSuma.toString()),
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
    return FloatingActionButton(
        heroTag: "btn1",
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
        onPressed: () => Navigator.pushNamed(context, 'despacho',
            arguments: lista.toString()));
  }

  // _eliminarBoton(BuildContext context) {
  //   return FloatingActionButton(
  //       heroTag: "btn2",
  //       child: Icon(Icons.add),
  //       backgroundColor: Colors.deepPurple,
  //       onPressed: () => Navigator.pushNamed(context, 'despacho',
  //           arguments: lista.toString()));
  // }
}
//    Navigator.pushNamed(context, 'despacho', arguments: lista);
//  return lista;

// Navigator.push(
//     context,
//     MaterialPageRoute(
//         builder: (context) => DespachoPage(despacho: productos)));
// onPressed: () => Navigator.push(
//     context, MaterialPageRoute(builder: (context) => DespachoPage(despachoss: lista))
//Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => DespachoPage(context),
//     ))
