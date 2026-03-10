# Informe Ejecutivo del Código en main.dart

## Resumen Ejecutivo
Este archivo `main.dart` implementa una aplicación de consola en Dart que permite gestionar usuarios y posts a través de peticiones HTTP. Utiliza servicios para obtener datos de usuarios y crear posts, presentando un menú interactivo para listar usuarios, consultar uno específico o crear un nuevo post. El código es modular, con funciones separadas para la presentación de datos, facilitando su mantenimiento y comprensión.

## Bloques de Código y Funcionalidades

### 1. Importaciones
- **Propósito**: Importa las bibliotecas y módulos necesarios para el funcionamiento de la aplicación.
- **Detalles**:
  - `dart:io`: Para entrada/salida estándar (stdin, stdout).
  - `user_model.dart`: Modelo de datos para representar un usuario.
  - `user_service.dart`: Servicio que maneja las peticiones HTTP para obtener usuarios.
  - `post_model.dart`: Modelo de datos para representar un post.
  - `post_service.dart`: Servicio que maneja las peticiones HTTP para crear posts.
- **Por qué es importante**: Sin estas importaciones, el código no podría acceder a las clases y funciones externas.

#### Contenido del Bloque
```dart
import 'dart:io';

import 'package:peticiones_http/models/post_model.dart';
import 'package:peticiones_http/models/user_model.dart';
import 'package:peticiones_http/services/post_service.dart';
import 'package:peticiones_http/services/user_service.dart';
```

#### Explicación Línea por Línea
- Línea 1: Importa la biblioteca `dart:io` para manejar entrada y salida estándar (como leer del teclado y escribir en consola).
- Línea 3: Importa el modelo `Post` desde el paquete local `peticiones_http/models/post_model.dart`, necesario para representar los datos de post.
- Línea 4: Importa el modelo `User` desde el paquete local `peticiones_http/models/user_model.dart`, necesario para representar los datos de usuario.
- Línea 5: Importa el servicio `PostService` desde el paquete local `peticiones_http/services/post_service.dart`, que maneja las llamadas HTTP para posts.
- Línea 6: Importa el servicio `UserService` desde el paquete local `peticiones_http/services/user_service.dart`, que maneja las llamadas HTTP para usuarios.

### 2. Función `listarUsuarios(List<User> users)`
- **Propósito**: Muestra una lista formateada de todos los usuarios en la consola.
- **Detalles**:
  - Imprime un encabezado.
  - Itera sobre la lista de usuarios.
  - Formatea cada usuario con ID, nombre y email en columnas alineadas.
- **Facilidad de memorización**: "Lista usuarios en tabla: ID | Nombre | Email".
- **Explicación**: Esta función toma una lista de usuarios y los presenta de manera legible, como una tabla simple.

#### Contenido del Bloque
```dart
void listarUsuarios(List<User> users) {
  print('\n---------- Listado General -----------\n');
  for (final user in users) {
    final id = user.id.toString().padRight(3);
    final name = user.name.padRight(25);
    final email = user.email;

    print('  $id | $name | $email');
  }
}
```

#### Explicación Línea por Línea
- Línea 1: Define la función `listarUsuarios` que recibe una lista de objetos `User`.
- Línea 2: Imprime un encabezado con saltos de línea para separar la salida.
- Línea 3: Inicia un bucle `for` que itera sobre cada usuario en la lista.
- Línea 4: Convierte el ID del usuario a string y lo alinea a la derecha con padding de 3 caracteres.
- Línea 5: Alinea el nombre a la derecha con padding de 25 caracteres.
- Línea 6: Obtiene el email del usuario.
- Línea 8: Imprime el ID, nombre y email formateados como una fila de tabla.

### 3. Función `listarPosts(List<Post> posts)`
- **Propósito**: Muestra una lista formateada de todos los posts en la consola.
- **Detalles**:
  - Imprime un encabezado.
  - Itera sobre la lista de posts.
  - Formatea cada post con ID y userId.
- **Facilidad de memorización**: "Lista posts en tabla: ID | UserID".
- **Explicación**: Esta función toma una lista de posts y los presenta de manera legible.

#### Contenido del Bloque
```dart
void listarPosts(List<Post> posts) {
  print('\n---------- Listado Posts -----------\n');

  for (final post in posts) {
    print('${post.id} | ${post.userId}');
  }
}
```

#### Explicación Línea por Línea
- Línea 1: Define la función `listarPosts` que recibe una lista de objetos `Post`.
- Línea 2: Imprime un encabezado con saltos de línea para separar la salida.
- Línea 4: Inicia un bucle `for` que itera sobre cada post en la lista.
- Línea 5: Imprime el ID y userId del post formateados.

### 4. Función `mostrarUsuario(User user)`
- **Propósito**: Muestra los detalles completos de un usuario específico.
- **Detalles**:
  - Imprime un encabezado.
  - Muestra propiedades del usuario: ID, nombre, username, email, teléfono, sitio web, empresa y ciudad.
- **Facilidad de memorización**: "Muestra detalles de un usuario: ID, nombre, etc.".
- **Explicación**: Similar a una ficha de usuario, expande toda la información disponible para un solo registro.

#### Contenido del Bloque
```dart
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
```

#### Explicación Línea por Línea
- Línea 1: Define la función `mostrarUsuario` que recibe un objeto `User`.
- Línea 2: Imprime un encabezado para el usuario encontrado.
- Líneas 3-10: Imprime cada propiedad del usuario con una etiqueta, usando interpolación de strings para insertar los valores.

### 5. Función `main()` (asíncrona)
- **Propósito**: Punto de entrada de la aplicación, ejecuta un bucle infinito con un menú de opciones.
- **Detalles**:
  - Crea una instancia de `UserService`.
  - En un bucle `while(true)`:
    - Muestra un menú con 4 opciones: Listado General, Listado Único, POST, Salir.
    - Lee la entrada del usuario.
    - Usa un `switch` para manejar las opciones.
- **Facilidad de memorización**: "Menú principal: 1. Listar todos, 2. Buscar por ID, 3. Crear post, 4. Salir".
- **Explicación**: El corazón de la app; mantiene la interacción hasta que el usuario elige salir.

#### Contenido del Bloque
```dart
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


      default:
        print('Opción inválida.');
    }
  }
}
```

#### Explicación Línea por Línea
- Línea 1: Define la función `main` como asíncrona para manejar operaciones HTTP.
- Línea 2: Crea una instancia del servicio `UserService`.
- Línea 4: Inicia un bucle infinito `while(true)`.
- Líneas 5-10: Imprime el menú de opciones y solicita selección.
- Línea 12: Lee la entrada del usuario.
- Línea 13: Crea una instancia de `PostService` dentro del bucle (nota: podría optimizarse moviéndolo fuera).
- Línea 15: Inicia un `switch` basado en la opción.
- Caso '1': Obtiene usuarios y los lista.
- Caso '2': Pide ID, valida, busca usuario y lo muestra o informa error.
- Caso '3': Crea un post usando `postService.postPosts()`, muestra los detalles del post creado.
- Default: Opción inválida.

### 6. Opción 1: Listado General
- **Propósito**: Obtiene y lista todos los usuarios.
- **Detalles**:
  - Llama a `service.getUsers()` para obtener la lista.
  - Pasa la lista a `listarUsuarios()`.
- **Facilidad de memorización**: "Opción 1: Obtener todos los usuarios y listarlos".
- **Explicación**: Realiza una petición HTTP para todos los usuarios y los muestra en formato tabla.

#### Contenido del Bloque
```dart
case '1':
  final users = await service.getUsers();
  listarUsuarios(users);
  break;
```

#### Explicación Línea por Línea
- Línea 1: Caso para opción '1'.
- Línea 2: Llama al método asíncrono `getUsers()` del servicio para obtener la lista de usuarios.
- Línea 3: Pasa la lista a la función `listarUsuarios` para mostrarla.
- Línea 4: Rompe el switch.

### 7. Opción 2: Listado Único
- **Propósito**: Busca y muestra un usuario por ID.
- **Detalles**:
  - Pide al usuario ingresar un ID.
  - Valida que sea un número entero.
  - Llama a `service.getUserById(id)`.
  - Si encuentra el usuario, lo muestra con `mostrarUsuario()`; si no, informa que no se encontró.
- **Facilidad de memorización**: "Opción 2: Pedir ID, validar, buscar y mostrar usuario".
- **Explicación**: Maneja la búsqueda individual, con validación de entrada para evitar errores.

#### Contenido del Bloque
```dart
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
```

#### Explicación Línea por Línea
- Línea 1: Caso para opción '2'.
- Línea 2: Solicita el ID del usuario.
- Línea 3: Lee la entrada.
- Línea 5: Verifica si la entrada no es nula y es un entero válido.
- Línea 6: Convierte la entrada a entero.
- Línea 8: Llama al método para obtener el usuario por ID.
- Líneas 10-14: Si el usuario existe, lo muestra; si no, informa error.
- Línea 16: Si la entrada es inválida, imprime mensaje.

### 8. Opción 3: POST
- **Propósito**: Crea un nuevo post a través de una petición HTTP.
- **Detalles**:
  - Llama a `postService.postPosts()` para crear un post.
  - Muestra los detalles del post creado: ID, título y contenido.
- **Facilidad de memorización**: "Opción 3: Crear y mostrar un nuevo post".
- **Explicación**: Realiza una petición POST para crear un post y muestra la respuesta.

#### Contenido del Bloque
```dart
case '3':
  final post = await postService.postPosts();

  print('\nPOST creado correctamente');
  print('ID: ${post.id}');
  print('Título: ${post.title}');
  print('Contenido: ${post.body}');
  break;
```

#### Explicación Línea por Línea
- Línea 1: Caso para opción '3'.
- Línea 2: Llama al método asíncrono `postPosts()` del servicio para crear un post.
- Líneas 4-6: Imprime mensaje de éxito y detalles del post creado.
- Línea 7: Rompe el switch.

### 9. Opción 4: Salir
- **Propósito**: Termina la ejecución de la aplicación.
- **Detalles**:
  - No hay acción específica, ya que el default maneja opciones inválidas, pero en el código actual, salir no está implementado explícitamente en el switch.
- **Facilidad de memorización**: "Opción 4: Salir del programa".
- **Explicación**: En el código actual, la opción 4 no tiene un case específico, por lo que cae en default.

#### Contenido del Bloque
```dart
// No hay case '4' en el switch, por lo que va a default.
```

#### Explicación Línea por Línea
- En el código actual, no hay un case para '4', así que se maneja como opción inválida.

### 10. Caso Default en Switch
- **Propósito**: Maneja opciones inválidas.
- **Detalles**:
  - Si la opción no es 1, 2 o 3, imprime "Opción inválida.".
- **Facilidad de memorización**: "Default: Opción no válida".
- **Explicación**: Proporciona retroalimentación al usuario para entradas incorrectas.

#### Contenido del Bloque
```dart
default:
  print('Opción inválida.');
```

#### Explicación Línea por Línea
- Línea 1: Caso por defecto en el switch.
- Línea 2: Imprime mensaje de opción inválida.

## Conclusión
El código está estructurado de manera clara y modular, separando la lógica de presentación de la de negocio. Es fácil de extender, por ejemplo, agregando más opciones al menú. La aplicación demuestra el uso básico de Dart para aplicaciones de consola con interacciones asíncronas y manejo de errores simples.</content>
<parameter name="filePath">c:\Users\isabe\OneDrive\Desktop\Proyectos movil\peticiones_http\informe_ejecutivo.md