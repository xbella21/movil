class Producto{
  final int id;
  final String nombre;
  final double precio;
  final bool disponible;

  Producto({
    required this.id,
    required this.nombre,
    required this.precio,
    required this.disponible,
  });

  factory Producto.fromJson(Map<String, dynamic>json){
    return Producto(
      id: json['id'],
      nombre: json['nombre'],
      precio: json['precio'].toDouble(),
      disponible: json['disponible'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id':id,
      'nombre':nombre,
      'precio':precio,
      'disponible':disponible,
    };
  }
}