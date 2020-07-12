import 'dart:io';

import 'package:flutter/material.dart';
import 'package:formvalidation/src/models/despachos_model.dart';
import 'package:formvalidation/src/providers/despachos_providers.dart';
import 'package:image_picker/image_picker.dart';

import 'package:formvalidation/src/models/producto_model.dart';
import 'package:formvalidation/src/providers/productos_provider.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;

class DespachoPage extends StatefulWidget {
  // final ProductoModel usernameController; //if you have multiple values add here
  // DespachoPage(this.usernameController, {Key key}) : super(key: key);
  @override
  _DespachoPageState createState() => _DespachoPageState();
}

class _DespachoPageState extends State<DespachoPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final productoProvider = new DespachoProvider();

  ProductoModel despacho = new ProductoModel();
  DespachoModel despachos = new DespachoModel();
  bool _guardando = false;
  File foto;

  @override
  Widget build(BuildContext context) {
    final ProductoModel prodData = ModalRoute.of(context).settings.arguments;
    //  final ProductoModel prodDatas = ModalRoute.of(context).settings.arguments;
    DespachoModel prodDatas;
    if (prodData != null) {
      despacho = prodData;
      despachos.nombre = "";
      despachos.direccion = "";
      despachos.telefono = "";
      despachos.pedido = "";

      print(despacho);
      //  print(despachos);
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Despacho'),
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
                _crearNombreProducto(),
                _crearPrecio(),
                _crearDireccion(),
                _crearTelefono(),
                _crearPedido(),
                _crearDespachado(),
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
      decoration: InputDecoration(labelText: 'Nombre'),
      //decoration: InputDecoration(labelText: despachos.nombre),
      // decoration: InputDecoration(labelText: ''),

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

  Widget _crearNombreProducto() {
    return TextFormField(
      initialValue: despacho.nombre,
      textCapitalization: TextCapitalization.sentences,
      // decoration: InputDecoration(labelText: 'Nombre'),
      decoration: InputDecoration(labelText: despacho.nombre),

      onSaved: (value) => despacho.nombre = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese su nombre';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: despacho.precio,
      textCapitalization: TextCapitalization.sentences,
      // decoration: InputDecoration(labelText: 'Nombre'),
      decoration: InputDecoration(labelText: despacho.precio),

      onSaved: (value) => despacho.precio = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese precio';
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
      decoration: InputDecoration(labelText: 'Direccion'),
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
    return TextFormField(
      initialValue: despachos.pedido,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Pedido'),
      // decoration: InputDecoration(labelText: ''),

      onSaved: (value) => despachos.pedido = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese pedido';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearDespachado() {
    return SwitchListTile(
      value: despachos.despachado,
      title: Text('Despachado'),
      activeColor: Colors.deepPurple,
      onChanged: (value) => setState(() {
        despachos.despachado = value;
      }),
    );
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

    // if (foto != null) {
    //   despacho.imageUrl = await productoProvider.subirImagen(foto);
    // }

    // if (despacho.key == null) {
    // productoProvider.crearDespacho(despacho);
    // } else {
    //productoProvider.editarProducto(despacho);
    // }

    // setState(() {_guardando = false; });
    mostrarSnackbar('Registro guardado');

    Navigator.pop(context);
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

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
}
