import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/models/despachos_model.dart';
import 'package:formvalidation/src/models/producto_model.dart';
import 'package:formvalidation/src/pages/despacho_page.dart';
import 'dart:developer';

import 'package:formvalidation/src/providers/productos_provider.dart';

class BorrarPage extends StatefulWidget {
  @override
  _BorrarPageState createState() => new _BorrarPageState();
}

class _BorrarPageState extends State<BorrarPage> {
  var isSelected = false;
  var mycolor = Colors.white;
  var lista = List();

  final productosProvider = new ProductosProvider();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Scaffold(
        appBar: AppBar(title: Text('Borrar')),
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
    final String prodDatas = ModalRoute.of(context).settings.arguments;
    print(prodDatas.toString());

    return FutureBuilder(
      // future: prodData,
      // future: productosProvider.cargarProductos(),
      builder: (BuildContext context, prodData) {
        // print(snapshot.hasData);
        final productos = prodDatas.toString();
        lista.add(productos);
        if (lista != null) {
          print(productos);
          return ListView.builder(
              itemCount: lista.length,
              itemBuilder: (context, i) {
                return Dismissible(
                    key: Key(productos),
                    background: Container(
                      color: Colors.red,
                    ),
                    onDismissed: (direccion) {
                      lista.remove(productos);

                      Navigator.pushNamed(context, 'despacho',
                          arguments: lista.toString());
                      //  productosProvider.borrarProducto(lista[i]);
                    },
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          //    (productos[i].imageUrl == null)
                          //      ? Image(image: AssetImage('assets/no-image.png'))
                          // : FadeInImage(
                          //     image: NetworkImage(productos[i].imageUrl),
                          //     placeholder:
                          //         AssetImage('assets/jar-loading.gif'),
                          //     height: 300.0,
                          //     width: double.infinity,
                          //     fit: BoxFit.cover,
                          //   ),
                          ListTile(
                            //   selected: isSelected,

                            title: Text('${lista[i]} '),
                            // subtitle: Text(productos[i].key),
                            selected: isSelected,

                            onLongPress: () => toggleSelection(productos[i]),

                            ////     Navigator.pushNamed(context, 'despacho',  arguments: lista),

                            //        arguments: producto),
                            // onTap: () => Navigator.pushNamed(context, 'despacho',
                            //        arguments: producto),
                          ),
                        ],
                      ),
                    ));
              });
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  void toggleSelection(producto) {
    // setState(() {
    //   if (isSelected == false) {
    //     lista.add(producto);
    //     print(lista);
    //     mycolor = Colors.blue;
    //     isSelected = true;
    //     return lista;
    //   } else {
    //     //  lista.remove(producto);
    //     mycolor = Colors.grey[300];
    //     isSelected = false;
    //   }
    // });
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
