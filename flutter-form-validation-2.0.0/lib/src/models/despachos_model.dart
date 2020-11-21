// To parse this JSON data, do
//
//     final productoModel = productoModelFromJson(jsonString);

import 'dart:convert';

import 'package:formvalidation/src/models/pedido.model.dart';
import 'package:formvalidation/src/models/seleccionado.model.dart';

DespachoModel despachoModelFromJson(String str) =>
    DespachoModel.fromJson(json.decode(str));

String despachoModelToJson(DespachoModel data) => json.encode(data.toJson());

class DespachoModel {
  // String id;
  // String titulo;
  // double valor;
  // bool disponible;
  // String fotoUrl;
  String key;
  bool despachado;
  String nombre;
  String nombreProducto;
  String precio;
  String direccion;
  String pedido;
  String telefono;

  //bool disponible;

  DespachoModel(
      {this.key,
      this.nombre = '',
      this.direccion = '',
      this.nombreProducto = '',
      this.precio = '',
      this.telefono = '',
      this.pedido = '',
      this.despachado = false});

  factory DespachoModel.fromJson(Map<String, dynamic> json) =>
      new DespachoModel(
          key: json["key"],
          nombre: json["nombre"],
          direccion: json["direccion"],
          nombreProducto: json["nombreProducto"],
          precio: json["precio"],
          telefono: json["telefono"],
          pedido: json["pedido"],
          despachado: json["despachado"]

          //disponible: json["disponible"],
          );

  Map<String, dynamic> toJson() => {
        // "id"         : id,
        "key": key,
        "nombre": nombre,
        "nombreProducto": nombreProducto,
        "precio": precio,
        "direccion": direccion,
        "telefono": telefono,
        "pedido": pedido,
        "despachado": despachado,
//      "disponible": disponible,
      };
}
