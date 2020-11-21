import 'dart:convert';

import 'package:formvalidation/src/models/producto_model.dart';

// SeleccionadoModel seleccionadoModelFromJson(String str) =>
//     SeleccionadoModel.fromJson(json.decode(str));

// String pedidoModelToJson(SeleccionadoModel data) => json.encode(data.toJson());

class SeleccionadoModel {
  String pedido;
  int cantidad;
  // String nombre;
  // String precio;
  // //bool disponible;
  // String imageUrl;
  // bool isSelected = false; //the initializtion is mandatory

  SeleccionadoModel(this.pedido, this.cantidad // this.nombre = '',
      // this.precio = '',
      // //this.disponible = true,
      // this.imageUrl,
      );

//   factory SeleccionadoModel.fromJson(Map<String, dynamic> json) =>
//       new SeleccionadoModel(
//         pedido: json["pedido"],
//         // nombre: json["nombre"],
//         // precio: json["precio"],
//         // //disponible: json["disponible"],
//         // imageUrl: json["imageUrl"],
//       );

//   Map<String, dynamic> toJson() => {
//         "cantidad": cantidad,
//         "pedido": pedido,
// //         "nombre": nombre,
// //         "precio": precio,
// // //      "disponible": disponible,
// //         "imageUrl": imageUrl,
//       };
}

// SeleccionadoModel(
//   int i,
//   int contadorSuma, {
//   this.key,
//   this.cantidad = 0,
// });

// factory SeleccionadoModel.fromJson(Map<int, int> json) =>
//     new SeleccionadoModel(
//       key: json["key"],

//       cantidad: json["cantidad"],
//       //disponible: json["disponible"],
//     );
