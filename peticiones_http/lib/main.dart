import 'package:peticiones_http/models/user_model.dart';
import 'package:peticiones_http/services/user_service.dart';

void listarUsuarios(List<User> users) {
  print('----------Listado de Usuarios-----------\n');
  for (final user in users) {
    final id = user.id.toString().padRight(3);
    final name = user.name.padRight(25);
    final email = user.email;

    print('  $id | $name | $email');
  }
}

void main() async {
  final service = UserService();
  final users = await service.getUsers();

  listarUsuarios(users);
}
