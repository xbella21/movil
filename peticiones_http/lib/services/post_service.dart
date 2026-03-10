import 'dart:convert';
import 'package:peticiones_http/models/post_model.dart';
import 'package:http/http.dart' as http;

class PostService {
  static final String _baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<Post> postPosts() async {
  final url = Uri.parse('$_baseUrl/posts');

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      "title": "Mi primer post",
      "body": "Contenido del post",
      "userId": 1
    }),
  );

  if (response.statusCode == 201 || response.statusCode == 200) {
    print("Status code: ${response.statusCode}");
    print("Respuesta: ${response.body}");

    final jsonData = jsonDecode(response.body);
    return Post.fromJson(jsonData);
  } else {
    throw Exception('Error ${response.statusCode}');
  }
  } 


}

