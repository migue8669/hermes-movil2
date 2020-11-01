class SeleccionadoModel {
  int key;

  int cantidad;

  SeleccionadoModel(
    int i,
    int contadorSuma, {
    this.key,
    this.cantidad = 0,
  });

  // factory SeleccionadoModel.fromJson(Map<int, int> json) =>
  //     new SeleccionadoModel(
  //       key: json["key"],

  //       cantidad: json["cantidad"],
  //       //disponible: json["disponible"],
  //     );
}
