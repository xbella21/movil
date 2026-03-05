# Informe Ejecutivo del Código en main.dart

## Resumen Ejecutivo
Este archivo `main.dart` implementa una aplicación de consola en Dart que permite gestionar usuarios a través de peticiones HTTP. Utiliza un servicio para obtener datos de usuarios y presenta un menú interactivo para listar usuarios o consultar uno específico. El código es modular, con funciones separadas para la presentación de datos, facilitando su mantenimiento y comprensión.

## Bloques de Código y Funcionalidades

### 1. Importaciones
- **Propósito**: Importa las bibliotecas y módulos necesarios para el funcionamiento de la aplicación.
- **Detalles**:
  - `dart:io`: Para entrada/salida estándar (stdin, stdout).
  - `user_model.dart`: Modelo de datos para representar un usuario.
  - `user_service.dart`: Servicio que maneja las peticiones HTTP para obtener usuarios.
- **Por qué es importante**: Sin estas importaciones, el código no podría acceder a las clases y funciones externas.

#### Contenido del Bloque
```dart
import 'dart:io';

import 'package:peticiones_http/models/user_model.dart';
import 'package:peticiones_http/services/user_service.dart';
```

#### Explicación Línea por Línea
- Línea 1: Importa la biblioteca `dart:io` para manejar entrada y salida estándar (como leer del teclado y escribir en consola).
- Línea 3: Importa el modelo `User` desde el paquete local `peticiones_http/models/user_model.dart`, necesario para representar los datos de usuario.
- Línea 4: Importa el servicio `UserService` desde el paquete local `peticiones_http/services/user_service.dart`, que maneja las llamadas HTTP.

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

### 3. Función `mostrarUsuario(User user)`
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

### 4. Función `main()` (asíncrona)
- **Propósito**: Punto de entrada de la aplicación, ejecuta un bucle infinito con un menú de opciones.
- **Detalles**:
  - Crea una instancia de `UserService`.
  - En un bucle `while(true)`:
    - Muestra un menú con 3 opciones: Listado General, Listado Único, Salir.
    - Lee la entrada del usuario.
    - Usa un `switch` para manejar las opciones.
- **Facilidad de memorización**: "Menú principal: 1. Listar todos, 2. Buscar por ID, 3. Salir".
- **Explicación**: El corazón de la app; mantiene la interacción hasta que el usuario elige salir.

#### Contenido del Bloque
```dart
void main() async {
  final service = UserService();

  while (true) {
    print('\n=========== MENU ===========');
    print('1. Listado General');
    print('2. Listado Único');
    print('3. Salir');
    stdout.write('Seleccione una opción: ');

    final opcion = stdin.readLineSync();

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
        print('Saliendo...');
        return;

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
- Líneas 5-9: Imprime el menú de opciones y solicita selección.
- Línea 11: Lee la entrada del usuario.
- Línea 13: Inicia un `switch` basado en la opción.
- Caso '1': Obtiene usuarios y los lista.
- Caso '2': Pide ID, valida, busca usuario y lo muestra o informa error.
- Caso '3': Imprime mensaje y sale.
- Default: Opción inválida.

### 5. Opción 1: Listado General
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

### 6. Opción 2: Listado Único
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

### 7. Opción 3: Salir
- **Propósito**: Termina la ejecución de la aplicación.
- **Detalles**:
  - Imprime "Saliendo..." y ejecuta `return` para salir del bucle y la función main.
- **Facilidad de memorización**: "Opción 3: Salir del programa".
- **Explicación**: Opción simple para cerrar la app de manera controlada.

#### Contenido del Bloque
```dart
case '3':
  print('Saliendo...');
  return;
```

#### Explicación Línea por Línea
- Línea 1: Caso para opción '3'.
- Línea 2: Imprime mensaje de salida.
- Línea 3: Retorna de la función main, terminando el programa.

### 8. Caso Default en Switch
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