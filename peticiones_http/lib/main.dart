
import 'dart:io';

import 'package:peticiones_http/models/post_model.dart';
import 'package:peticiones_http/models/user_model.dart';
import 'package:peticiones_http/services/post_service.dart';
import 'package:peticiones_http/services/user_service.dart';

void listarUsuarios(List<User> users) {
  print('\n---------- Listado General -----------\n');
  for (final user in users) {
    final id = user.id.toString().padRight(3);
    final name = user.name.padRight(25);
    final email = user.email;

    print('  $id | $name | $email');
  }
}

void listarPosts(List<Post> posts) {
  print('\n---------- Listado Posts -----------\n');

  for (final post in posts) {
    print('${post.id} | ${post.userId}');
  }
}


void mostrarUsuario(User user) {
  print('\n---------- Usuario Encontrado -----------\n');
  print('ID: ${user.id}');
  print('Nombre: ${user.name}');
  print('Username: ${user.username}');
  print('Email: ${user.email}');
  print('Teléfono: ${user.phone}');
  print('Web: ${user.website}');
  print('Empresa: ${user.company.name}');
  print('Ciudad: ${user.address.city}');
}



void main() async {
  final service = UserService();

  while (true) {
    print('\n=========== MENU ===========');
    print('1. Listado General');
    print('2. Listado Único');
    print('3. POST');
    print('4. salir');
    stdout.write('Seleccione una opción: ');

    final opcion = stdin.readLineSync();
    final postService = PostService();


    switch (opcion) {
      case '1':
        final users = await service.getUsers();
        listarUsuarios(users);
        break;

     case '2':
      stdout.write('Ingrese el ID del usuario: ');
      final input = stdin.readLineSync();

      if (input != null && int.tryParse(input) != null) {
        final id = int.parse(input);

        final user = await service.getUserById(id);

        if (user != null) {
          mostrarUsuario(user);
        } else {
          print('Usuario no encontrado.');
        }
      } else {
      print('ID inválido.');
      }
      break;

      case '3':
      final post = await postService.postPosts();
      

      print('\nPOST creado correctamente');
      print('ID: ${post.id}');
      print('Título: ${post.title}');
      print('Contenido: ${post.body}');
      break;

      case '4':
        print('Saliendo...');
        return;

      default:
        print('Opción inválida.');
    }
  }
}
