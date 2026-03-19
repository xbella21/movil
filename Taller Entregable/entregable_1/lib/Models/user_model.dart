class User {
  final int? id;
  final String name;
  final String email;
  final String phone;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  /// Crea un User desde un Map (respuesta JSON)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id:    json['id']    as int?,
      name:  json['name']  as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
    );
  }

  /// Convierte el User a un Map (para enviar a la API)
  Map<String, dynamic> toJson() {
    return {
      'name':  name,
      'email': email,
      'phone': phone,
    };
  }
}