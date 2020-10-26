// To parse this JSON data, do
//
//     final productoModel = productoModelFromJson(jsonString);

import 'dart:convert';

import 'package:formvalidation/src/models/producto_model.dart';

PedidoModel productoModelFromJson(String str) =>
    PedidoModel.fromJson(json.decode(str));

String pedidoModelToJson(PedidoModel data) => json.encode(data.toJson());

class PedidoModel {
  List<ProductoModel> pedido;
  String key;
  // String nombre;
  // String precio;
  // //bool disponible;
  // String imageUrl;
  // bool isSelected = false; //the initializtion is mandatory

  PedidoModel({
    this.pedido,
    this.key,
    // this.nombre = '',
    // this.precio = '',
    // //this.disponible = true,
    // this.imageUrl,
  });

  factory PedidoModel.fromJson(Map<String, dynamic> json) => new PedidoModel(
        pedido: json["pedido"],
        // nombre: json["nombre"],
        // precio: json["precio"],
        // //disponible: json["disponible"],
        // imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": key,
        "pedido": pedido,
//         "nombre": nombre,
//         "precio": precio,
// //      "disponible": disponible,
//         "imageUrl": imageUrl,
      };
}
