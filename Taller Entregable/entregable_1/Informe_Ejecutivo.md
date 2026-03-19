# Informe Ejecutivo: Proyecto "Entregable 1" - Aplicación CRUD de Usuarios en Flutter

## 1. Descripción del Proyecto
El proyecto "Entregable 1" es una aplicación móvil desarrollada en Flutter que implementa un sistema de gestión de usuarios mediante operaciones CRUD (Crear, Leer, Actualizar, Eliminar). La aplicación consume una API REST externa (jsonplaceholder.typicode.com) para simular la persistencia de datos de usuarios, permitiendo a los usuarios finales interactuar con una lista de usuarios de manera intuitiva. El enfoque está en la experiencia de usuario, con interfaces responsivas y funcionalidades como búsqueda, ordenamiento y vistas alternativas (lista o cuadrícula).

El proyecto se presenta como un entregable académico o de taller, diseñado para demostrar el uso de Flutter en el desarrollo de aplicaciones móviles con integración de servicios web.

## 2. Funciones Principales del Proyecto
La aplicación cumple las siguientes funciones clave:
- **Listado de Usuarios**: Muestra una lista o cuadrícula de usuarios obtenidos desde la API, con información básica (nombre, email, teléfono).
- **Búsqueda**: Permite filtrar usuarios por nombre en tiempo real.
- **Ordenamiento**: Ordena la lista alfabéticamente (ascendente/descendente) por nombre.
- **Vista de Detalles**: Muestra información completa de un usuario seleccionado.
- **Creación de Usuarios**: Formulario para agregar nuevos usuarios con validación de campos.
- **Edición de Usuarios**: Modificación de datos existentes mediante un formulario pre-llenado.
- **Eliminación de Usuarios**: Confirmación y eliminación con manejo de errores.
- **Interfaz Adaptable**: Alterna entre vista de lista y cuadrícula para mejor usabilidad.
- **Manejo de Estados**: Indicadores de carga, errores y confirmaciones mediante SnackBars y diálogos.

La aplicación maneja errores de red y validaciones de entrada para asegurar una experiencia robusta.

## 3. Estructura de Carpetas
El proyecto sigue la estructura estándar de un proyecto Flutter, organizada de manera modular para separar responsabilidades:

- **Raíz del Proyecto**:
  - `pubspec.yaml`: Archivo de configuración con dependencias (Flutter, HTTP, Cupertino Icons).
  - `README.md`: Documentación básica del proyecto.
  - `analysis_options.yaml`: Configuración de lints para calidad de código.
  - `ActividadSemana4.html`: Archivo HTML no relacionado con el proyecto Flutter (posiblemente un entregable anterior).

- **Carpeta `android/`**: Configuración específica para Android (build.gradle, manifest, etc.).
- **Carpeta `ios/`**: Configuración específica para iOS (Xcode project, plist, etc.).
- **Carpeta `lib/`**: Código fuente principal de la aplicación.
  - `main.dart`: Punto de entrada de la aplicación.
  - `Models/`: Modelos de datos.
    - `user_model.dart`: Definición del modelo User.
  - `Service/`: Lógica de negocio y comunicación externa.
    - `api_service.dart`: Servicio para interacciones con la API REST.
  - `UI/`: Interfaces de usuario.
    - `user_list_screen.dart`: Pantalla principal con lista de usuarios.
    - `user_form_screen.dart`: Pantalla de formulario para crear/editar usuarios.
    - `user_detail_screen.dart`: Pantalla de detalles de un usuario.
- **Carpeta `test/`**: Pruebas unitarias (widget_test.dart).
- **Carpeta `web/`**: Configuración para despliegue web.
- **Carpeta `windows/`, `linux/`, `macos/`**: Configuraciones para otros plataformas.
- **Carpeta `build/`**: Archivos generados durante la compilación.

Esta estructura promueve la separación de concerns: modelos para datos, servicios para lógica externa, y UI para presentación.

## 4. Descripción de Archivos Clave
- **`lib/main.dart`**: 
  - **Propósito**: Configura la aplicación Flutter como punto de entrada.
  - **Contenido**: Define `MyApp` como un `StatelessWidget` que configura `MaterialApp` con tema teal, título "CRUD Usuarios" y establece `UserListScreen` como pantalla inicial. Internamente, inicializa la app con `runApp()`.

- **`lib/Models/user_model.dart`**:
  - **Propósito**: Representa la estructura de datos de un usuario.
  - **Contenido**: Clase `User` con propiedades `id` (opcional), `name`, `email`, `phone`. Incluye métodos `fromJson()` para deserializar respuestas de la API y `toJson()` para serializar datos a enviar.

- **`lib/Service/api_service.dart`**:
  - **Propósito**: Maneja todas las interacciones HTTP con la API externa.
  - **Contenido**: Clase `ApiService` con métodos asíncronos para CRUD: `getUsers()` (GET), `createUser()` (POST), `updateUser()` (PUT), `deleteUser()` (DELETE). Usa el paquete `http` para solicitudes y `json` para codificación/decodificación. Maneja excepciones para errores de red.

- **`lib/UI/user_list_screen.dart`**:
  - **Propósito**: Pantalla principal que muestra la lista de usuarios con funcionalidades interactivas.
  - **Contenido**: `StatefulWidget` con estado para lista de usuarios, filtros, orden y vista (lista/grid). Incluye AppBar con botones de orden y vista, campo de búsqueda, y `ListView` o `GridView` con tarjetas de usuarios. Maneja navegación a detalles, edición y eliminación.

- **`lib/UI/user_form_screen.dart`**:
  - **Propósito**: Formulario para crear o editar usuarios.
  - **Contenido**: `StatefulWidget` con `Form` y campos validados (nombre, email, teléfono). Usa controladores de texto y validadores con expresiones regulares. Botón de guardar que llama al API y regresa a la lista tras éxito.

- **`lib/UI/user_detail_screen.dart`**:
  - **Propósito**: Muestra detalles completos de un usuario seleccionado.
  - **Contenido**: `StatelessWidget` con cabecera visual (avatar con inicial del nombre) y `ListTile`s para email y teléfono. Diseño simple y centrado en presentación.

## 5. Análisis de Fragmentos de Código: Aspectos Visuales e Internos
### Aspectos Visuales
- **Tema y Colores**: La app usa `ThemeData` con `ColorScheme.fromSeed(seedColor: Colors.teal)`, aplicando un esquema de colores teal en AppBars, botones y avatares para consistencia visual.
- **Widgets Principales**:
  - `Scaffold`: Estructura base con AppBar y body en todas las pantallas.
  - `ListView` y `GridView`: Para mostrar usuarios; `GridView` usa `SliverGridDelegateWithFixedCrossAxisCount` para 2 columnas.
  - `Card`: Envuelve cada usuario en la lista/grid para separación visual.
  - `CircleAvatar`: Representa usuarios con inicial del nombre en color teal.
  - `TextFormField`: Campos de formulario con íconos, bordes y validación visual (errores en rojo).
  - `ElevatedButton`: Botones de acción (guardar, editar, eliminar) con colores teal y estados deshabilitados.
  - `SnackBar` y `AlertDialog`: Para feedback de errores y confirmaciones.
- **Layout Responsivo**: Usa `Padding`, `Column`, `Expanded` y `MediaQuery` implícitamente para adaptarse a diferentes tamaños de pantalla. La vista grid cambia el aspecto ratio para optimizar espacio.

### Aspectos Internos
- **Gestión de Estado**: Usa `StatefulWidget` en pantallas dinámicas (`UserListScreen`, `UserFormScreen`) para manejar listas, filtros y carga. `setState()` actualiza la UI tras operaciones asíncronas.
- **Navegación**: `Navigator.push()` y `Navigator.pop()` para transiciones entre pantallas, pasando datos (e.g., usuario a editar).
- **Manejo de Datos**: 
  - Modelos inmutables con `factory` constructors para parsing JSON.
  - Servicios asíncronos con `Future` y `async/await` para llamadas API no bloqueantes.
- **Validación y Errores**: 
  - `Form` con `GlobalKey<FormState>` y validadores personalizados (regex para email, teléfono).
  - Try-catch en operaciones API para manejar excepciones y mostrar errores al usuario.
- **Optimización**: 
  - `TextEditingController` para campos de texto, liberados en `dispose()`.
  - `RefreshIndicator` para recargar lista con swipe.
  - Filtrado y ordenamiento en memoria (no en API) para rendimiento.
- **Dependencias Externas**: 
  - `http`: Para solicitudes REST.
  - `json`: Para serialización (built-in en Dart).
  - Sin estado global complejo; estado local por pantalla.

Este proyecto demuestra buenas prácticas en Flutter: arquitectura limpia, manejo de estado local, validación robusta y UI material design. Es ideal para aprendizaje de desarrollo móvil con APIs. Si se requiere expansión, se podría integrar un gestor de estado global como Provider o Riverpod para escalabilidad.