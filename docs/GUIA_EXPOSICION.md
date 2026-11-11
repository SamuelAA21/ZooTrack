# Guía de exposición de ZooTrack

## 1. Presentar el problema

ZooTrack administra especies y cantidades de ejemplares sin depender de internet. El mismo proyecto ofrece una interfaz adaptada para teléfono y navegador.

## 2. Explicar qué es Flutter

> Flutter es un framework de interfaz creado por Google que utiliza Dart para construir aplicaciones compiladas para Android, iOS, web y escritorio desde una base de código compartida.

No conviene decir “se escribe una vez y funciona igual en todo”. La lógica y muchos componentes se comparten, pero el diseño responsive, los permisos y algunas integraciones deben adaptarse a cada plataforma.

## 3. Recorrido técnico

1. `Animal` representa el dominio y no depende de la interfaz.
2. `AnimalRepository` define las operaciones de almacenamiento.
3. `DriftAnimalRepository` implementa esas operaciones con SQLite.
4. `AnimalsController` conserva el estado, calcula indicadores y aplica filtros.
5. Los widgets escuchan el controlador y reconstruyen solo la información visible.

## 4. Demostración recomendada

1. Abrir la aplicación y explicar la diferencia entre especies y ejemplares.
2. Registrar una especie y mostrar las validaciones del formulario.
3. Buscar por nombre científico y filtrar por hábitat.
4. Editar la cantidad y eliminar un registro con confirmación.
5. Recargar o cerrar la aplicación para demostrar que los datos persisten.
6. Mostrar móvil y web desde el mismo proyecto.
7. Cambiar un texto o color y ejecutar hot reload.
8. Ejecutar `flutter analyze` o una prueba automatizada.

## 5. Ventajas de Flutter

- Gran reutilización de código entre plataformas.
- Hot reload para iterar rápidamente sobre la interfaz.
- Widgets consistentes y altamente personalizables.
- Buen rendimiento al compilar la aplicación.
- Ecosistema de paquetes y herramientas de análisis y pruebas.
- Null safety en Dart.

## 6. Desventajas y límites

- Algunos paquetes no soportan todas las plataformas.
- Las funciones nativas pueden requerir Kotlin, Java, Swift u Objective-C.
- Una interfaz móvil no se convierte automáticamente en una buena interfaz web.
- El tamaño inicial puede ser mayor que en algunas soluciones nativas.
- Actualizar dependencias exige revisar compatibilidad y migraciones.
- El equipo debe aprender Dart y el modelo declarativo de widgets.

## 7. Preguntas previsibles

### ¿Por qué Drift y no una lista en memoria?

Porque una lista se pierde al cerrar la aplicación. Drift proporciona SQLite, consultas tipadas, migraciones y soporte para Android y web.

### ¿Por qué no Firebase?

El requisito es persistencia local y funcionamiento sin conexión. Firebase agregaría configuración, red y servicios externos que no son necesarios para el alcance actual.

### ¿Por qué no BLoC o Riverpod?

El estado es pequeño y `ChangeNotifier` lo resuelve con menos conceptos. Una arquitectura más grande no sería automáticamente una mejor práctica.

### ¿Por qué no Docker?

No existe un backend que contenerizar. Docker podría utilizarse más adelante para servicios o automatización, pero no reemplaza el emulador ni ejecuta la aplicación dentro del teléfono.

### ¿La base de código es realmente la misma?

Sí para el dominio, las reglas, la persistencia y la mayor parte de los widgets. El layout cambia según el ancho disponible y cada plataforma conserva particularidades propias.
