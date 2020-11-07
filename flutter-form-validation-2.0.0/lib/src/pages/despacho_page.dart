import 'dart:io';

import 'package:flutter/material.dart';
import 'package:formvalidation/src/models/despachos_model.dart';
import 'package:formvalidation/src/models/pedido.model.dart';

import 'package:formvalidation/src/providers/despachos_providers.dart';
import 'package:image_picker/image_picker.dart';

import 'package:formvalidation/src/models/producto_model.dart';
import 'package:formvalidation/src/providers/productos_provider.dart';
//import 'package:formvalidation/src/utils/utils.dart' as utils;

class DespachoPage extends StatefulWidget {
  // final ProductoModel usernameController; //if you have multiple values add here
  // DespachoPage(this.usernameController, {Key key}) : super(key: key);
  final DespachoModel despachoss;

  // En el constructor, se requiere un objeto Todo
  DespachoPage({Key key, @required this.despachoss}) : super(key: key);
  @override
  _DespachoPageState createState() => _DespachoPageState();
}

class _DespachoPageState extends State<DespachoPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final productoProvider = new DespachoProvider();
  PedidoModel pedido = new PedidoModel();
  ProductoModel despacho = new ProductoModel();
  DespachoModel despachos = new DespachoModel();
  bool _guardando = false;
  File foto;
  List<DespachoModel> list;

  @override
  Widget build(BuildContext context) {
    //   final DespachoModel prodData = ModalRoute.of(context).settings.arguments;
    // final PedidoModel prodDatas = ModalRoute.of(context).settings.arguments;
    final String prodData = ModalRoute.of(context).settings.arguments;
    //  DespachoModel prodDatas;
    if (prodData != null) {
      despachos.key = "";
      despachos.nombre = "";
      despachos.direccion = "";
      despachos.telefono = "";
      despachos.pedido = prodData;
      print("prodData");

      print(prodData);
      //  print(despachos);
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Despacho'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                //_mostrarFoto(),
                _crearNombre(),
                _crearDireccion(),
                _crearTelefono(),
                _crearPedido(),
                // _crearPrecio(),
                // _crearDespachado(),
                _crearBoton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
//      initialValue: despachos.nombre,
      initialValue: '',

      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Nombre completo'),

      onSaved: (value) => despachos.nombre = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese su nombre';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearDireccion() {
    return TextFormField(
      initialValue: despachos.direccion,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Dirección'),
      // decoration: InputDecoration(labelText: ''),

      onSaved: (value) => despachos.direccion = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese su dirección';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearTelefono() {
    return TextFormField(
      initialValue: despachos.telefono,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Telefono'),
      keyboardType: TextInputType.number,
      //  decoration: InputDecoration(labelText: ''),

      onSaved: (value) => despachos.telefono = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese su telefono';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearPedido() {
    return ListTile(
        // title: Text('${widget.despachoss.nombre}'),
        title: Text('${despachos.pedido}'),
        onTap: () {
          Navigator.pushNamed(context, 'borrar',
              arguments: despachos.pedido.toString());
        });
  }

  Widget _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.deepPurple,
      textColor: Colors.white,
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      onPressed: (_guardando) ? null : _submit,
    );
  }

  void _submit() async {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();
    setState(() {
      _guardando = true;
    });
    productoProvider.crearDespacho(despachos);
    mostrarSnackbar('Registro guardado');
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }
}
// actions: <Widget>[
//   IconButton(
//     icon: Icon(Icons.photo_size_select_actual),
//     onPressed: _seleccionarFoto,
//   ),
//   IconButton(
//     icon: Icon(Icons.camera_alt),
//     onPressed: _tomarFoto,
//   ),
// ],

//   subtitle: Text(productos[i].key),
// initialValue: despachoss.pedido,
// textCapitalization: TextCapitalization.sentences,
// decoration: InputDecoration(labelText: 'Pedido'),
// // decoration: InputDecoration(labelText: ''),

// onSaved: (value) => despachoss.pedido = value as List,
// validator: (value) {
//   if (value.length < 3) {
//     return 'Ingrese pedido';
//   } else {
//     return null;
//   }
// },

// Widget _crearDespachado() {
//   return SwitchListTile(
//     value: despachos.despachado,
//     title: Text('Despachado'),
//     activeColor: Colors.deepPurple,
//     onChanged: (value) => setState(() {
//       despachos.despachado = value;
//     }),
//   );
// }

// if (foto != null) {
//   despacho.imageUrl = await productoProvider.subirImagen(foto);
// }

// if (despacho.key == null) {
// productoProvider.crearDespacho(despacho);
// } else {
//productoProvider.editarProducto(despacho);
// }

// setState(() {_guardando = false; });

//  Navigator.pop(context);

// @override
// State<StatefulWidget> createState() {
//   // TODO: implement createState
//   //throw UnimplementedError();
//     _DespachoPageState createState() => _DespachoPageState();

// }

// Widget _mostrarFoto() {
//   if (producto.imageUrl != null) {
//     return FadeInImage(
//       image: NetworkImage(producto.imageUrl),
//       placeholder: AssetImage('assets/jar-loading.gif'),
//       height: 300.0,
//       fit: BoxFit.contain,
//     );
//   } else {
//     return Image(
//       image: AssetImage(foto?.path ?? 'assets/no-image.png'),
//       height: 300.0,
//       fit: BoxFit.cover,
//     );
//   }
// }

// _seleccionarFoto() async {
//   _procesarImagen(ImageSource.gallery);
// }

// _tomarFoto() async {
//   _procesarImagen(ImageSource.camera);
// }

// _procesarImagen(ImageSource origen) async {
//   foto = await ImagePicker.pickImage(source: origen);

//   if (foto != null) {
//     producto.imageUrl = null;
//   }

//   setState(() {});
// }

// Widget _crearNombreProducto() {
//   return TextFormField(
//     initialValue: despacho.nombre,
//     textCapitalization: TextCapitalization.sentences,
//     // decoration: InputDecoration(labelText: 'Nombre'),
//     decoration: InputDecoration(labelText: despacho.nombre),

//     onSaved: (value) => despacho.nombre = value,
//     validator: (value) {
//       if (value.length < 3) {
//         return 'Ingrese su nombre';
//       } else {
//         return null;
//       }
//     },
//   );
// }

// Widget _crearPrecio() {
//   return TextFormField(
//     initialValue: despacho.precio,
//     textCapitalization: TextCapitalization.sentences,
//     // decoration: InputDecoration(labelText: 'Nombre'),
//     decoration: InputDecoration(labelText: despachos.precio),

//     onSaved: (value) => despacho.precio = value,
//     validator: (value) {
//       if (value.length < 3) {
//         return 'Ingrese precio';
//       } else {
//         return null;
//       }
//     },
//   );
// }
