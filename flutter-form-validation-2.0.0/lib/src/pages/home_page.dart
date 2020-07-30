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
  var lista = List();

  final productosProvider = new ProductosProvider();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: _crearListado(),
      floatingActionButton: _crearBoton(context),
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
                return Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      color: Colors.red,
                    ),
                    onDismissed: (direccion) {
                      productosProvider.borrarProducto(productos[i].key);
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
                            selected: isSelected,

                            onTap: () => toggleSelection(productos[i].nombre),

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

  void toggleSelection(productos) {
    setState(() {
      if (isSelected == false) {
        print("dentro de isselected");
        lista.add(productos);
        print(lista);
        mycolor = Colors.blue;
        isSelected = true;
        //    Navigator.pushNamed(context, 'despacho', arguments: lista);
        //  return lista;
      } else {
        mycolor = Colors.grey[300];
        isSelected = false;
      }
    });
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed: () => Navigator.pushNamed(context, 'despacho'),
      // onPressed: () => Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => DespachoPage(context),
      //     ))
    );
  }
}
