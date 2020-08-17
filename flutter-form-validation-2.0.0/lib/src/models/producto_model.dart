// To parse this JSON data, do
//
//     final productoModel = productoModelFromJson(jsonString);

import 'dart:convert';

ProductoModel productoModelFromJson(String str) =>
    ProductoModel.fromJson(json.decode(str));

String productoModelToJson(ProductoModel data) => json.encode(data.toJson());

class ProductoModel {
  // String id;
  // String titulo;
  // double valor;
  // bool disponible;
  // String fotoUrl;
  String key;
  String nombre;
  String precio;
  int cantidad;
  //bool disponible;
  String imageUrl;
  bool isSelected = false; //the initializtion is mandatory

  ProductoModel({
    this.key,
    this.nombre = '',
    this.precio = '',
    this.cantidad = 0,

    //this.disponible = true,
    this.imageUrl,
  });

  factory ProductoModel.fromJson(Map<String, dynamic> json) =>
      new ProductoModel(
        key: json["key"],
        nombre: json["nombre"],
        precio: json["precio"],
        cantidad: json["cantidad"],
        //disponible: json["disponible"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        // "id"         : id,
        "key": key,
        "nombre": nombre,
        "precio": precio,
        "cantidad": cantidad,
//      "disponible": disponible,
        "imageUrl": imageUrl,
      };
}
