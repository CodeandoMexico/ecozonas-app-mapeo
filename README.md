![Logo Codeando México](/recursos/imagenes/logo-cmx.svg#gh-light-mode-only)
![Logo Codeando México](/recursos/imagenes/logo-cmx-blanco.svg#gh-dark-mode-only)

[![website](https://img.shields.io/badge/website-CodeandoMexico-00D88E.svg)](http://www.codeandomexico.org/)
[![slack](https://img.shields.io/badge/slack-CodeandoMexico-EC0E4F.svg)](http://slack.codeandomexico.org/)


# EcoZonas - App de mapeo

Este repositorio contiene el código de la aplicación móvil para el mapeo comunitario del proyecto EcoZonas.

## Acerca de EcoZonas

El proyecto “EcoZonas: Piloto para diseñar, escalar y replicar la acción climática inclusiva en el nivel de barrio” es implementado por WRI México y el Instituto Wuppertal, con financiamiento de la iniciativa Climática Internacional del Gobierno Alemán (IKI, por sus siglas en alemán).

Este proyecto se centra en la implementación de proyectos piloto en dos barrios vulnerables de ciudades mexicanas de tamaño medio con el objetivo de desarrollar, apoyar y fortalecer procesos y métodos participativos de acción climática inclusiva y replicable a nivel comunitario, enmarcados en planes de acción climática municipales y nacionales. Los principales beneficiarios son las comunidades locales, sociedad civil organizada, los municipios y los gobiernos estatales y nacionales.

## Obtener api de Mapbox
1. Visitar la página de Mapbox
2. ___

## Como compilar la aplicación
1. Clonar proyecto desde: ___
2. Instalar Visual Studio Code para abrir el proyecto
3. En Visual Studio Code y abrir el proyecto utiilzando Open Folder
4. Especificar la versión de java en `android/gradle.properties`
   1. `org.gradle.java.home=/PATH_TO_JDK/java/17.0.13-tem`
5. En la terminal de Visual Studio Code, ejecutar el comando “flutter pub get” para descargar las librerías del proyecto
6. Copiar el token al archivo `android/gradle.properties`
   1. `MAPBOX_DOWNLOADS_TOKEN=`
7. Seleccionar y arrancar el dispositivo para el que se quiere probar. En VS Code está abajo a la derecha.
8. Una vez terminado el proceso, ejecutar `flutter run --dart-define=ACCESS_TOKEN=[API_DE_MAPBOX]` para compilar el proyecto. Se debe reemplazar [API_DE_MAPBOX] con el obtenido en la página oficial de Mapbox
9. Para compilar el APK final para Android ejecutar `flutter build apk --dart-define=ACCESS_TOKEN=[API_DE_MAPBOX]`

## Versiones utilizadas
1. Flutter (Channel stable, 3.22.3, on macOS 15.0.1)
    1. Flutter version 3.22.3 on channel stable
    2. Dart version 3.4.4
    3. DevTools version 2.34.3
2. Android toolchain - develop for Android devices (Android SDK version 33.0.1)
    1. Platform android-34, build-tools 33.0.1
    2. Java version OpenJDK Runtime Environment (build 17.0.9+0-17.0.9b1087.7-11185874)
3. Xcode - develop for iOS and macOS (Xcode 16.1)
    1. CocoaPods version 1.14.3
4. Android Studio (version 2023.2)
    1. Java version OpenJDK Runtime Environment (build 17.0.9+0-17.0.9b1087.7-11185874)
5. VS Code (version 1.94.2)
    1. Flutter extension version 3.98.0

## Notas

Para actualizar la versión del proyecto, editar el archivo pubspec.yaml

```
version: 24.11.12+2411121
```

Para poder compilar el APK para distribución de Android revisar la página [Build and release an Android app](https://docs.flutter.dev/deployment/android).

## Cómo contribuir al proyecto

De momento el proyecto no está abierto a contribuciones, pero está planeado abrirlo a futuro.

## Licencia

Esta aplicación se publica bajo la licencia GNU Affero General Public License v3.0. License: LGPL v3

Si estás planeando reutilizar el código, es necesario que publiques el código bajo la misma licencia, GPL Affero 3, en un repositorio de acceso público y mantengas los avisos de autoría, además de indicar los cambios realizados al código existente.

Te recomendamos leas a detalle la licencia. Puedes contactarnos si tienes alguna duda al respecto.

## Equipo y colaboradores

* [Jesús L.](https://github.com/jck9007)
* [Óscar Hernández](https://github.com/oxcar)

---

Creado con ❤️ por la comunidad de [Codeando México](http://www.codeandomexico.org).
