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

## Cómo compilar la aplicación

### Requisitos
- Flutter 3.50 o superior (canal stable)
- Android: JDK 21 o superior (lo pide `maplibre_gl`). Flutter usa por defecto el JDK incluido en Android Studio; para usar otro, ejecutar `flutter config --jdk-dir=/PATH_TO_JDK`
- iOS: Xcode. Las dependencias nativas se instalan con Swift Package Manager; no hace falta CocoaPods ni `pod install`

### Pasos
1. Clonar el proyecto: `git clone https://github.com/CodeandoMexico/ecozonas-app-mapeo.git`
2. Desde la carpeta del proyecto, ejecutar `flutter pub get` para descargar las librerías; también genera los textos traducidos (`lib/l10n/app_localizations*.dart`)
3. Conectar un dispositivo o abrir un emulador; `flutter devices` lista los disponibles y `flutter emulators --launch <id>` abre un emulador
4. Ejecutar `flutter run` para compilar y abrir la app (con varios dispositivos, `flutter run -d <id>`)
5. Para un iPhone físico, abrir `ios/Runner.xcworkspace` en Xcode y configurar la firma en *Signing & Capabilities* del target Runner

### Compilar para publicar
- Android: `flutter build appbundle` (Google Play) o `flutter build apk`. La firma se configura en `android/key.properties`, que no se sube al repositorio; ver [Build and release an Android app](https://docs.flutter.dev/deployment/android)
- iOS: `flutter build ipa`; ver [Build and release an iOS app](https://docs.flutter.dev/deployment/ios)

## Pruebas y análisis

- `flutter test` corre las pruebas de `test/`
- `flutter analyze` debe terminar sin avisos

GitHub Actions corre ambos y compila el APK de Android en cada pull request (`.github/workflows/ci.yml`).

## Sistema de diseño

Los estilos de la app se definen en un solo lugar, `lib/src/ui/theme/`:
- `app_tokens.dart`: colores según su uso (`AppColors`), espaciado en múltiplos de 4 (`AppSpacing`), radios de borde (`AppRadius`) y alturas de controles (`AppSizes`)
- `app_typography.dart`: escala tipográfica con [Inter](https://rsms.me/inter/) (fuente variable incluida en `assets/fonts/inter/`, licencia SIL OFL)
- `theme.dart`: tema de Material que aplica todo lo anterior a botones, campos, tarjetas, barras, diálogos y mensajes

Al crear o modificar pantallas:
- Usar `Theme.of(context).textTheme` y los tokens en lugar de tamaños, colores o márgenes escritos a mano
- Usar `AppButton` (`lib/src/ui/widgets/app_button.dart`) para los botones: primario, secundario, contorno, peligro o texto, en tamaño normal o pequeño

## Traducciones

La app está en español e inglés. Los textos están en `lib/l10n/app_es.arb` y `lib/l10n/app_en.arb`; `app_en.arb` es la plantilla y tiene notas para traductores en las claves ambiguas. Los archivos `app_localizations*.dart` se generan con `flutter pub get` y no se suben al repositorio.

Para agregar un idioma:
1. Crear `lib/l10n/app_<código>.arb` con todas las claves de `app_en.arb` traducidas (una prueba verifica que todos los `.arb` tengan las mismas claves)
2. Agregar la opción del idioma en `getLanguageOptions` (`lib/src/ui/utils/utils.dart`)
3. Para el contenido que llega del servidor (mapatones, actividades, opciones), agregar los campos del idioma en los modelos y en `localized()` (`lib/src/ui/utils/utils.dart`)

## Versiones utilizadas
1. Flutter 3.50.1 (channel stable), Dart 3.14.0
2. Android
    1. Gradle 9.5.0, Android Gradle Plugin 9.3.1, Kotlin 2.4.20
    2. compileSdk y targetSdk 36, minSdk 24 (valores de Flutter)
    3. JDK 21 o superior (lo pide `maplibre_gl`; probado con el JDK 25 incluido en Android Studio)
3. iOS
    1. Versión mínima iOS 15.5 (la pide `maplibre_gl`)
    2. Xcode 27.2, dependencias con Swift Package Manager

## Notas

La versión de la app está en `pubspec.yaml` con el formato `AA.MM.DD+AAMMDDn` (fecha de la versión y un consecutivo del día):

```
version: 25.03.13+2503131
```

## Cómo contribuir al proyecto

De momento el proyecto no está abierto a contribuciones, pero está planeado abrirlo a futuro.

## Licencia

Esta aplicación se publica bajo la licencia GNU Affero General Public License v3.0 (ver `LICENSE`).

Si estás planeando reutilizar el código, es necesario que publiques el código bajo la misma licencia, GPL Affero 3, en un repositorio de acceso público y mantengas los avisos de autoría, además de indicar los cambios realizados al código existente.

Te recomendamos leas a detalle la licencia. Puedes contactarnos si tienes alguna duda al respecto.

## Equipo y colaboradores

* [Jesús L.](https://github.com/jck9007)
* [Óscar Hernández](https://github.com/oxcar)

---

Creado con ❤️ por la comunidad de [Codeando México](http://www.codeandomexico.org).
