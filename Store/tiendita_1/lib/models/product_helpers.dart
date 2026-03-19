import 'product_model.dart';

List<Producto> filtrarProductos(List<Producto> productos){
  return productos
    .where((p) => p.precio > 50000 && p.disponible)
    .toList();

}