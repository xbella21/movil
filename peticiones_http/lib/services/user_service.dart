import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:peticiones_http/models/user_model.dart';

class UserService {
  static final String _baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<User>> getUsers() async {
    final url = Uri.parse('$_baseUrl/users');

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);

        return jsonData.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
