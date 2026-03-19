import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/user_model.dart';

class ApiService {
  // URL base de la API
  static const String _base = 'https://jsonplaceholder.typicode.com/users';

  // ── READ: Obtener todos los usuarios ──────────────────
  Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse(_base));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => User.fromJson(e)).toList();
    } else {
      throw Exception('Error al cargar usuarios');
    }
  }

  // ── CREATE: Crear un usuario nuevo ────────────────────
  Future<User> createUser(User user) async {
    final response = await http.post(
      Uri.parse(_base),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al crear usuario');
    }
  }

  // ── UPDATE: Actualizar un usuario existente ───────────
  Future<User> updateUser(User user) async {
    final response = await http.put(
      Uri.parse('$_base/${user.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al actualizar usuario');
    }
  }

  // ── DELETE: Eliminar un usuario ───────────────────────
  Future<void> deleteUser(int id) async {
    final response = await http.delete(
      Uri.parse('$_base/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar usuario');
    }
  }
}