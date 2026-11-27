![Logo Codeando México](/recursos/imagenes/logo-cmx.svg#gh-light-mode-only)
![Logo Codeando México](/recursos/imagenes/logo-cmx-blanco.svg#gh-dark-mode-only)

[![website](https://img.shields.io/badge/website-CodeandoMexico-00D88E.svg)](http://www.codeandomexico.org/)
[![slack](https://img.shields.io/badge/slack-CodeandoMexico-EC0E4F.svg)](http://slack.codeandomexico.org/)


# EcoZonas - App de mapeo

Este repositorio contiene el código de la aplicación móvil para el mapeo comunitario del proyecto EcoZonas.

## Acerca de EcoZonas

El proyecto “EcoZonas: Piloto para diseñar, escalar y replicar la acción climática inclusiva en el nivel de barrio” es implementado por WRI México y el Instituto Wuppertal, con financiamiento de la iniciativa Climática Internacional del Gobierno Alemán (IKI, por sus siglas en alemán).

Este proyecto se centra en la implementación de proyectos piloto en dos barrios vulnerables de ciudades mexicanas de tamaño medio con el objetivo de desarrollar, apoyar y fortalecer procesos y métodos participativos de acción climática inclusiva y replicable a nivel comunitario, enmarcados en planes de acción climática municipales y nacionales. Los principales beneficiarios son las comunidades locales, sociedad civil organizada, los municipios y los gobiernos estatales y nacionales.

## Mapas

Los mapas se muestran con [MapLibre](https://maplibre.org/) (`maplibre_gl`) y el estilo de [OpenFreeMap](https://openfreemap.org/), basado en OpenStreetMap. No se necesita ningún token ni cuenta. La URL del estilo está en `Constants.mapStyleUrl` (`lib/src/ui/utils/constants.dart`).

## Como compilar la aplicación
1. Clonar proyecto desde: ___
2. Instalar Visual Studio Code para abrir el proyecto
3. En Visual Studio Code y abrir el proyecto utiilzando Open Folder
4. Usar Java 17 o superior para Gradle. Flutter usa por defecto el JDK incluido en Android Studio; para usar otro, ejecutar `flutter config --jdk-dir=/PATH_TO_JDK`
5. En la terminal de Visual Studio Code, ejecutar el comando “flutter pub get” para descargar las librerías del proyecto
6. Seleccionar y arrancar el dispositivo para el que se quiere probar. En VS Code está abajo a la derecha.
7. Ejecutar `flutter run` para compilar y abrir la app en el dispositivo
8. Para compilar el APK final para Android ejecutar `flutter build apk`

## Pruebas y análisis

- `flutter test` corre las pruebas de `test/`
- `flutter analyze` debe terminar sin avisos

GitHub Actions corre ambos y compila el APK de Android en cada pull request (`.github/workflows/ci.yml`).

## Versiones utilizadas
1. Flutter 3.50.1 (channel stable), Dart 3.14.0
2. Android
    1. Gradle 9.5.0, Android Gradle Plugin 9.3.1, Kotlin 2.4.20
    2. compileSdk y targetSdk 36, minSdk 24 (valores de Flutter)
    3. Java 17 o superior (probado con el JDK 25 incluido en Android Studio)

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
