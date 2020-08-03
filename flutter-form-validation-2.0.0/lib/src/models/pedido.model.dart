// To parse this JSON data, do
//
//     final productoModel = productoModelFromJson(jsonString);

import 'dart:convert';

PedidoModel productoModelFromJson(String str) =>
    PedidoModel.fromJson(json.decode(str));

String productoModelToJson(PedidoModel data) => json.encode(data.toJson());

class PedidoModel {
  List pedido;
  // String key;
  // String nombre;
  // String precio;
  // //bool disponible;
  // String imageUrl;
  // bool isSelected = false; //the initializtion is mandatory

  PedidoModel({this.pedido
      // this.key,
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
        // "id"         : id,
        "pedido": pedido,
//         "nombre": nombre,
//         "precio": precio,
// //      "disponible": disponible,
//         "imageUrl": imageUrl,
      };
}
