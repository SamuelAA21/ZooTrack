# ZooTrack

Aplicación Flutter para administrar un inventario de fauna desde Android y web. Los registros se guardan localmente con SQLite y continúan disponibles sin conexión.

## Funcionalidades

- Registro, edición y eliminación de especies.
- Nombre común y científico, hábitat, cantidad y estado de conservación.
- Búsqueda por nombre y filtros por hábitat.
- Indicadores de especies, ejemplares y hábitats activos.
- Estados de carga, error, lista vacía y filtros sin resultados.
- Diseño responsive: resumen lateral en escritorio y composición compacta en móvil.
- Persistencia local con datos iniciales de demostración.

## Decisiones técnicas

- **Flutter y Material 3:** interfaz compartida para Android y web.
- **Drift sobre SQLite:** consultas y modelos tipados. En web, SQLite se ejecuta mediante WebAssembly y guarda los datos en el almacenamiento del navegador.
- **ChangeNotifier:** estado suficiente para el alcance del proyecto, sin introducir una biblioteca adicional.
- **Repositorio:** separa la interfaz y el controlador del mecanismo de almacenamiento.
- **Organización por funcionalidad:** evita una arquitectura ceremonial para una aplicación académica pequeña.

```text
lib/
├── core/
│   ├── database/
│   └── theme/
└── features/animals/
    ├── data/
    ├── domain/
    └── presentation/
```

## Comandos rápidos

Ejecuta todos los comandos desde la raíz del proyecto, en PowerShell.

| Quiero... | Comando |
|---|---|
| Descargar dependencias | `flutter pub get` |
| Regenerar el código de Drift | `dart run build_runner build` |
| Correr en el navegador | `flutter run -d edge` |
| Ver los dispositivos conectados | `flutter devices` o `adb devices` |
| Correr en el teléfono (desarrollo) | `flutter run` |
| Correr en el teléfono (rendimiento real) | `flutter run --release` |
| Generar el APK | `flutter build apk --release` |
| Generar APK más livianos | `flutter build apk --split-per-abi` |
| Instalar el APK generado en el teléfono | `flutter install` |
| Revisar que el entorno esté bien | `flutter doctor` |
| Limpiar compilaciones viejas | `flutter clean` y después `flutter pub get` |

## Requisitos

Versión verificada: **Flutter 3.47.9 (stable)** con Dart 3.13.7.

- **Web:** Flutter y Edge o Chrome.
- **Android:** no hace falta Android Studio ni emuladores. Para usar un teléfono por USB basta con este toolchain:
  - JDK 17.
  - Android SDK en `%LOCALAPPDATA%\Android\Sdk` con:
    - `cmdline-tools/latest`
    - `platform-tools` (incluye `adb`)
    - `build-tools;36.0.0`
    - `platforms;android-36`
    - `ndk;28.2.13676358`

    El NDK es obligatorio porque SQLite incluye código nativo. Su versión debe coincidir con la que pide Flutter (`flutter.ndkVersion`).

Variables de entorno de usuario:

| Variable | Valor |
|---|---|
| `ANDROID_HOME` | `%LOCALAPPDATA%\Android\Sdk` |
| `JAVA_HOME` | Carpeta del JDK 17 |
| `Path` | Añadir `%ANDROID_HOME%\platform-tools`, `%ANDROID_HOME%\cmdline-tools\latest\bin` y `%JAVA_HOME%\bin` |

Para preparar otro equipo desde cero, después de copiar las cmdline-tools a `%LOCALAPPDATA%\Android\Sdk\cmdline-tools\latest`:

```powershell
sdkmanager "platform-tools" "build-tools;36.0.0" "platforms;android-36" "ndk;28.2.13676358" "cmake;3.22.1"
sdkmanager --licenses
flutter doctor
```

> Después de cambiar variables de entorno, **cierra y vuelve a abrir VS Code por completo**. Las terminales que ya estaban abiertas no ven los cambios.

## Primera vez después de descargar el proyecto

```powershell
flutter pub get
dart run build_runner build
```

Vuelve a ejecutar `dart run build_runner build` cada vez que cambies las tablas en `lib/core/database/app_database.dart`. Ese comando regenera `app_database.g.dart`.

## Correr en web

```powershell
flutter run -d edge     # o: flutter run -d chrome
```

Los datos quedan guardados en el navegador. Si borras los datos del sitio, la app vuelve a los datos de demostración.

## Correr en un teléfono Android por USB

1. En el teléfono, ve a **Ajustes → Acerca del teléfono** y toca **Número de compilación** 7 veces para activar las opciones de desarrollador.
2. En **Opciones de desarrollador**, activa **Depuración USB**.
3. Conecta el teléfono con un cable de datos. Si el teléfono pregunta, elige el modo "Transferencia de archivos".
4. Acepta el mensaje **"¿Permitir depuración USB?"** en el teléfono.
5. Comprueba que aparezca:

   ```powershell
   adb devices
   ```

   Debe decir `device`. Si dice `unauthorized`, revisa la sección de problemas comunes.
6. Ejecuta la app:

   ```powershell
   flutter run              # modo desarrollo, con hot reload
   flutter run --release    # rendimiento real, sin hot reload
   ```

Con la app corriendo, en la terminal puedes usar:

| Tecla | Acción |
|---|---|
| `r` | Hot reload: aplica los cambios sin perder el estado |
| `R` | Hot restart: reinicia la app |
| `q` | Salir |

Si hay varios dispositivos conectados, por ejemplo el teléfono y Edge, elige uno con `flutter devices` y luego `flutter run -d <id>`.

## Generar e instalar el APK

```powershell
flutter build apk --release
```

Resultado: `build\app\outputs\flutter-apk\app-release.apk`, de unos 55 MB porque incluye tres arquitecturas. La primera compilación tarda varios minutos y las siguientes son más rápidas.

Para obtener un APK más liviano por arquitectura:

```powershell
flutter build apk --split-per-abi
```

La mayoría de los teléfonos modernos usan `app-arm64-v8a-release.apk`.

Formas de instalarlo:

```powershell
flutter install                                                     # instala el APK ya generado en el teléfono conectado
adb install -r build\app\outputs\flutter-apk\app-release.apk        # equivalente con adb
```

También puedes enviar el `.apk` al teléfono por Drive o WhatsApp e instalarlo a mano. Para eso hay que permitir "instalar apps de origen desconocido".

> El APK release se firma con la llave de depuración. Sirve para instalarlo en teléfonos propios y para la entrega, pero **no para publicarlo en Play Store**.

Para cambiar la versión antes de compilar, edita `version:` en `pubspec.yaml`. El formato es `nombre+número`, por ejemplo `1.0.1+2`.

## Problemas comunes

| Problema | Solución |
|---|---|
| `adb` o `flutter` no se reconocen | Cierra y vuelve a abrir VS Code. Si persiste, revisa el `Path`. |
| `adb devices` muestra `unauthorized` | Desbloquea el teléfono y acepta el mensaje. Si no aparece: `adb kill-server`, luego `adb start-server`, y reconecta el cable. |
| El teléfono no aparece | Usa un cable de datos (no solo de carga) y el modo "Transferencia de archivos". Algunas marcas necesitan el driver USB del fabricante en Windows. |
| La instalación falla por firma o versión | `adb uninstall com.samit.zootrack` y vuelve a instalar. **Esto borra los datos guardados en el teléfono.** |
| Error de compilación extraño tras cambiar dependencias | `flutter clean`, `flutter pub get` y `dart run build_runner build`. |
| Errores en `app_database.g.dart` | `dart run build_runner build` |
| Gradle deja procesos `java` usando mucha RAM | `cd android; .\gradlew --stop; cd ..` |
| Poco espacio en disco | La caché de Gradle (`%USERPROFILE%\.gradle`) y la carpeta `build` crecen con cada compilación. `flutter clean` libera `build`. |

## Verificación

```powershell
dart format .
flutter analyze
flutter test
flutter build web
```

Las pruebas cubren indicadores, búsqueda, filtros y ausencia de desbordamientos en tamaños representativos de escritorio y móvil.

## Persistencia web

Los archivos `web/sqlite3.wasm` y `web/drift_worker.js` pertenecen a la versión de Drift fijada por `pubspec.lock`. Al actualizar Drift deben actualizarse también ambos binarios desde la publicación oficial correspondiente.

## Por qué no se usa Docker

La base de datos vive dentro de la aplicación y no necesita un servidor. Docker añadiría valor si el proyecto incorporara un backend, una base de datos remota o un pipeline de integración continua, pero no simplifica la ejecución de una aplicación Flutter en un teléfono.

La guía sugerida para la sustentación está en [docs/GUIA_EXPOSICION.md](docs/GUIA_EXPOSICION.md).
