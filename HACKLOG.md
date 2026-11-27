# Hacklog: EcoZonas App Mapeo

## 11 de diciembre de 2025

### Documentación técnica

- Revisión exhaustiva del codebase para entender arquitectura, patrones y funcionalidades
- Creación de `docs/DESARROLLO.md` con documentación técnica del proyecto
  - Descripción del proyecto y contexto (EcoZonas, WRI México)
  - Documentación de arquitectura Clean Architecture (capas data/domain/ui)
  - Patrones de diseño implementados (Repository, BLoC, Provider, Use Cases)
  - Funcionalidades principales (sesiones, mapeo, formularios dinámicos, offline-first)
  - Dependencias clave y integraciones externas (Mapbox, API EcoZonas, KoboToolbox)
  - Identificación de mejoras prioritarias (testing, migraciones BD, DI, logging)

## 26 de noviembre de 2026

### Actualización a Flutter 3.50 y MapLibre (PR #7)

- Compatibilidad con Flutter 3.50
  - `intl` ^0.20.2
  - Las traducciones se importan desde `package:ecozonas/l10n` (el paquete `flutter_gen` ya no existe); los archivos generados en `lib/l10n/` quedan fuera de git
- Android al día con la plantilla de Flutter 3.50
  - Gradle en Kotlin DSL: Gradle 9.5.0, AGP 9.3.1, Kotlin 2.4.20, Java 17
  - compileSdk/targetSdk 36, minSdk 24 (antes 23)
- iOS
  - Versión mínima 15.5 (la pide `maplibre_gl`)
  - Plugins con Swift Package Manager; se quitó CocoaPods
  - Corregido `ONLY_ACTIVE_ARCH = NO` en Debug, que hacía fallar `flutter run` ("Unsupported Swift architecture")
- Mapas: `mapbox_gl` (abandonado, incompatible con AGP 8+) reemplazado por `maplibre_gl` ^0.28.1 con el estilo de OpenFreeMap
  - Ya no se necesitan `ACCESS_TOKEN` ni `MAPBOX_DOWNLOADS_TOKEN`
  - La descarga de regiones espera a que termine de verdad (antes avisaba "Descarga completa" en cuanto empezaba)
- `location` 10.2: se acepta la ubicación aproximada; se quitan del manifest los permisos de servicio en primer plano que la app no usa
- Limpieza de credenciales y permisos sin uso: clave de Google Maps, `MBXAccessToken` y `READ_PHONE_STATE`

### Correcciones

- Género, edad y discapacidad se guardan como código (`MUJER`, `18_25`…) en vez de la etiqueta traducida; antes, enviar mapeos podía tronar si la sesión se creó en otro idioma. Las sesiones existentes se convierten al leerlas
- La pantalla de idioma cambia el idioma por código (base para agregar más idiomas)
- El mapa avisa cuando no puede obtener la ubicación (permiso negado o servicio apagado)
- Al borrar un marcador se quita la tarjeta con su nombre
- Crear sesión ya no reinicia las opciones elegidas
- No se usa `BuildContext` después de un `await` en el mapa ni en "Mi sesión"

### Preparación para traducción

- `objectCount` usa plural ICU (antes pegaba una "s", que no sirve en otros idiomas)
- Textos fijos en el código pasan a los `.arb`: "Selecciona una opción", "Información actualizada correctamente" y "Objetos a mapear prioritarios"
- `showEnglish()` reemplazado por `localized()`: elige el texto del servidor según el idioma y usa el español si falta la traducción
- El nombre del marcador se muestra en el idioma actual (antes quedaba en el idioma con el que se guardó)
- Título de la app "EcoZonas" (antes "Material App") y correcciones de redacción en español
- Notas para traductores en `app_en.arb` para las claves ambiguas

### Mantenimiento

- Migración de `package:flutter/material.dart` a `material_ui`/`cupertino_ui` (obsoleto desde Flutter 3.47)
- APIs obsoletas: `Radio` → `RadioGroup`, `WillPopScope` → `PopScope`
- `bloc`/`flutter_bloc` 9 y `equatable` 3; se quitaron `font_awesome_flutter` y `cupertino_icons`, que no se usaban
- `ActivitiesDraggable` inmutable: recibe mapatón, controlador y callback por constructor
- Se borró código sin uso (`mapbox_test.dart`, `CheckBlockWidget`, `MapBlockWidget`, `ViewMapPage`)
- `flutter analyze` sin avisos
- Pruebas: la del contador de la plantilla se reemplazó por pruebas de códigos sociodemográficos, selector, `localized()`, plurales y consistencia de los `.arb`
- CI con GitHub Actions: análisis, pruebas y compilación del APK en cada pull request

### Base de datos y errores

- Consultas SQL con parámetros (`whereArgs`) en lugar de valores pegados al texto; un apóstrofo en un dato rompía la consulta
- Estructura de migraciones: `schemaVersion` y un mapa de migraciones por versión que se aplican en orden; los pasos para cambiar el esquema quedan documentados en `MyDatabase`
- Guardar y enviar mapeos muestran mensajes traducidos en lugar de la excepción; el detalle queda en el log
- Pruebas de la base con SQLite en memoria (`sqflite_common_ffi`): consultas, actividades por enviar y migraciones

