import 'dart:convert';
import 'package:http/http.dart' as http;

class PostService{

  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  static Future <List<dynamic>> obtenerPosts() async{
    try{
      final url = Uri.parse('$_baseUrl/posts');
      final response = await http.get(url);

      if (response.statusCode == 200){
        return jsonDecode(response.body);
      }else{
        throw Exception('Error del servidor: ${response.statusCode}');
      }
    }catch(e){
      throw Exception('Falló la conexión: $e');
    }
  }

  static Future <void> crearPost(String titulo, String cuerpo) async{
    try{
      final url = Uri.parse('$_baseUrl/posts');
      
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'title': titulo,
          'body': cuerpo,
          'userIde': 1,
        }),
      );

      print('Statuts: 4{response.statusCode}');
      print('Respuesta: ${response.body}');
    }catch (e){
      throw Exception('Error al crear post: $e');
    }
  }
}
