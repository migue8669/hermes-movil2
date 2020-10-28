import 'dart:convert';
import 'dart:io';

import 'package:formvalidation/src/models/despachos_model.dart';
import 'package:formvalidation/src/models/pedido.model.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:mime_type/mime_type.dart';

import 'package:formvalidation/src/models/producto_model.dart';

class ProductosProvider {
  final String _url = 'https://hermesbd-8fbb1.firebaseio.com';

  String prodTemps;

  Future<bool> crearProducto(ProductoModel producto) async {
    final url = '$_url/productos.json';

    final resp = await http.post(url, body: productoModelToJson(producto));

    final decodedData = json.decode(resp.body);

    // print(decodedData);

    return true;
  }

  Future<bool> editarProducto(ProductoModel producto) async {
    final url = '$_url/productos/${producto.key}.json';

    final resp = await http.put(url, body: productoModelToJson(producto));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<List<ProductoModel>> cargarProductos() async {
    final url = 'https://hermesbd-8fbb1.firebaseio.com/productoHermes.json';
    final resp = await http.get(url);
    //  print(resp);
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ProductoModel> productos = new List();

    if (decodedData == null) return [];

    decodedData.forEach((id, prod) {
      final prodTemp = ProductoModel.fromJson(prod);
      prodTemp.key = id;

      //   print(prod);
      productos.add(prodTemp);
    });

    // print( productos[0].id );

    return productos;
  }

  Future<int> borrarProducto(String id) async {
    final url = '$_url/despachados/$id.json';
    final resp = await http.delete(url);

    print(resp.body);

    return 1;
  }

  Future<String> subirImagen(File imagen) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dc0tufkzf/image/upload?upload_preset=cwye3brj');
    // final url = Uri.parse('');
    final mimeType = mime(imagen.path).split('/'); //image/jpeg

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', imagen.path,
        contentType: MediaType(mimeType[0], mimeType[1]));

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo salio mal');
      print(resp.body);
      return null;
    }

    final respData = json.decode(resp.body);
    print(respData);

    return respData['secure_url'];
  }

  Future<bool> guardarProducto(producto) async {
    final url = '$_url/seleccionados.json';
    final resp = await http.post(url, body: productoModelToJson(producto));

    print(resp.body);

    return true;
  }

  Future<List<PedidoModel>> cargarPedido() async {
    final url = 'https://hermesbd-8fbb1.firebaseio.com/seleccionados.json';
    final resp = await http.get(url);
    //  print(resp);
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<PedidoModel> pedido = new List();

    if (decodedData == null) return [];

    decodedData.forEach((id, prod) {
      final prodTemp = PedidoModel.fromJson(prod);
      prodTemp.key = id;
      //   print(prod);
      pedido.add(prodTemp);
    });

    // print( productos[0].id );

    return pedido;
  }

  Future<bool> actualizarProducto(ProductoModel producto) async {
    final url1 = 'https://hermesbd-8fbb1.firebaseio.com/seleccionados.json';
    final resp1 = await http.get(url1);
    //  print(resp);
    final Map<String, dynamic> decodedData = json.decode(resp1.body);
    final List<PedidoModel> pedido = new List();

    decodedData.forEach((id, prod) {
      final prodTemp = PedidoModel.fromJson(prod);
      prodTemp.key = id;
      //   print(prod);
      this.prodTemps = prodTemp.key;
      pedido.add(prodTemp);
    });

    final url = '$_url/seleccionados/${this.prodTemps}.json';
    final resp = await http.put(url, body: productoModelToJson(producto));
    final decodedData1 = json.decode(resp.body);

    print(decodedData1);

    return true;
  }

  Future<int> borrarPedido(String id) async {
    final url = '$_url/seleccionados/${this.prodTemps}.json';
    final resp = await http.delete(url);

    print(resp.body);

    return 1;
  }

  Future<bool> crearDespacho(despacho) async {
    final url = '$_url/despachados.json';

    final resp = await http.post(url, body: despachoModelToJson(despacho));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }
}
