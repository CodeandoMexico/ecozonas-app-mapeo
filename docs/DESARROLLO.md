# Documentación de Arquitectura - EcoZonas App

## Sobre el Proyecto

Esta app fue desarrollada para el proyecto EcoZonas, una iniciativa de WRI México y el Instituto Wuppertal financiada por el IKI del Gobierno Federal Alemán. Básicamente es una herramienta de mapeo colaborativo que permite a las comunidades identificar y documentar diferentes aspectos de sus colonias o barrios.

El enfoque está en cuatro áreas principales:
- Entorno urbano (espacios públicos, transporte, etc.)
- Calidad ambiental (contaminación, manejo de residuos)
- Bienestar socioeconómico (empleo, educación, salud)
- Riesgo de desastres

La app está construida con Flutter 3.22.3, lo que nos permite correrla en prácticamente cualquier plataforma (Android, iOS, Web, incluso desktop). La versión actual es `25.03.13+2503131` - usamos versionado basado en fecha para facilitar el seguimiento. Tenemos soporte completo para español e inglés.

## Cómo está organizado el código

Decidimos usar Clean Architecture porque el proyecto necesitaba una separación clara entre la lógica de negocio y los detalles de implementación. La estructura está dividida en tres capas:

```
lib/src/
├── data/           # Capa de Datos (Dependencias Externas)
│   ├── apis/       # Clientes HTTP para APIs
│   ├── db/         # Base de datos SQLite
│   ├── device/     # Servicios del dispositivo (conectividad, ubicación)
│   ├── preferences/# Wrapper de SharedPreferences
│   └── repositories/ # Implementaciones de repositorios
│
├── domain/         # Capa de Dominio (Lógica de Negocio)
│   ├── models/     # Entidades del dominio y DTOs
│   └── use_cases/  # Casos de uso de lógica de negocio
│
└── ui/             # Capa de Presentación
    ├── bloc/       # Gestión de estado con BLoC
    ├── pages/      # Módulos de pantallas/páginas
    ├── widgets/    # Componentes UI reutilizables
    ├── styles/     # Definiciones de estilo
    ├── theme/      # Configuración de tema
    └── utils/      # Utilidades de UI
```

### Patrones que estamos usando

La app usa varios patrones para mantener el código ordenado:

**Repository Pattern** - Todas las fuentes de datos (API, base de datos local, GPS, preferencias) están abstraídas detrás de interfaces. Esto hace que sea más fácil cambiar implementaciones o mockear cosas para testing.

**BLoC para gestión de estado** - Usamos el patrón BLoC (`flutter_bloc` + `rxdart`) principalmente para el mapeo y la navegación. Nos gusta porque separa bien la lógica de negocio de la UI.

**Provider** - Para cosas más simples como las listas de mapatones y encuestas, Provider es suficiente y más directo.

**Use Cases** - Cada operación importante (llamadas a API, gestión de mapatones, actividades, perfiles de usuario, GPS) tiene su propio caso de uso. Esto ayuda a reutilizar lógica y mantener las cosas separadas.

### Flujo de Datos

```
UI (Pages/Widgets)
    ↓ dispatch events
BLoC / Provider
    ↓ call
Use Cases
    ↓ access
Repositories
    ↓ fetch/store
Data Sources (API / Database / Device Services)
```

## Qué hace la app

### Sistema de sesiones

Los usuarios crean perfiles anónimos con un alias, género, edad e información sobre discapacidad. Pueden continuar sesiones previas o eliminarlas si quieren. El flujo empieza con la selección de idioma, luego pasan por las pantallas de login/creación de sesión hasta llegar al onboarding educativo.

### Mapeo interactivo

Esta es la funcionalidad principal. Usamos Mapbox GL para mostrar el mapa y permitir que los usuarios:
- Descarguen regiones para trabajar offline
- Vean marcadores de actividades mapeadas anteriormente  
- Seleccionen qué tipo de actividad quieren registrar
- Capturen la ubicación exacta con GPS

La lista de mapatones y encuestas disponibles se muestra en tabs. Las encuestas externas (de KoboToolbox) se abren en el navegador.

### Formularios dinámicos

Todo el sistema de formularios está configurado vía JSON (el archivo `survey.json` tiene como 11K líneas). Soportamos diferentes tipos de inputs: texto corto/largo, números, selección única o múltiple, desplegables, instrucciones y captura de fotos. Los formularios se renderizan en `MapatonMapContent` y todo está en español e inglés.

### Diseño offline-first

Esto fue importante desde el inicio porque muchas zonas donde se usa la app no tienen buena conexión. Todo se guarda localmente en SQLite (perfiles, sesiones, actividades, cache de mapatones/encuestas). Cuando hay conexión, los datos se sincronizan con el servidor. Cada registro tiene un flag de "enviado/no enviado" para controlar esto.

La app también permite ver qué actividades están pendientes de envío y el perfil del mapeador actual.

## Dependencias principales

Para gestión de estado usamos `bloc`, `flutter_bloc`, `rxdart` y `provider`. La UI usa cosas estándar como `carousel_slider` para el onboarding, `flutter_svg` para SVGs y Font Awesome para iconos.

La parte crítica es `mapbox_gl` para los mapas (requiere un ACCESS_TOKEN en tiempo de compilación). Para ubicación usamos el paquete `location`.

Persistencia: `sqflite` para la base de datos local y `shared_preferences` para cosas simples. Captura de fotos con `image_picker`.

Red: cliente HTTP básico (`http`) y `url_launcher` para abrir las encuestas externas de KoboToolbox.

### Integraciones externas

- Mapbox (tiles y geocoding) - token configurado en tiempo de build
- API de EcoZonas (`https://ecozonas.org/api/`) - endpoints para obtener mapatones/encuestas y enviar datos. Es pública, no requiere auth
- KoboToolbox - las URLs vienen en el JSON de configuración

## Cosas por mejorar

### Lo más urgente

**Testing** - Actualmente tenemos menos del 5% de cobertura. Solo existe el test por defecto que genera Flutter. Necesitamos tests unitarios para los use cases, tests de integración para los repositorios, y tests de BLoC al menos para `MapatonBloc`. Sería ideal configurar CI/CD para correr los tests automáticamente.

**Migraciones de BD** - Ahora mismo si cambiamos el esquema de la base de datos, los usuarios tienen que reinstalar la app. Esto es malo. Hay que implementar un sistema de versionado en `database_provider.dart` para poder hacer migraciones incrementales.

**Inyección de dependencias** - Los use cases y repositorios se están instanciando directamente en el código de UI, lo cual hace el testing más difícil y crea acoplamiento fuerte. Algo como GetIt ayudaría bastante aquí.

**Logging y manejo de errores** - El manejo de errores es muy básico. Deberíamos integrar un paquete de logging estructurado y algún sistema de crash reporting (Crashlytics o Sentry). También falta lógica de reintento para cuando fallen las llamadas a la API.

### Otras mejoras importantes

**Sistema de formularios** - Hay mucha lógica en `MapatonMapContent` manejando esas 11K líneas de JSON. Sería bueno extraer el renderizado de bloques a un factory o builder dedicado. También falta validación del esquema JSON.

**Documentación** - La documentación inline es mínima. Deberíamos actualizar el `CONTRIBUTING.md` y agregar comentarios en las APIs públicas.

**Limpieza de código** - Hay código comentado en varios archivos (especialmente navegación), imports sin usar, y algunas inconsistencias de nombres.

**Ciclo de vida de BLoC** - Hay una lógica medio rara de recreación de BLoC en `MapatonMapPage` que probablemente cause memory leaks. Hay que revisarla.

### Cosas que estarían bien pero no son urgentes

- Optimizar el renderizado de formularios y marcadores en el mapa
- Comprimir imágenes antes de subirlas (esto ayudaría con el ancho de banda)
- Mejorar accesibilidad (etiquetas semánticas, ratios de contraste, etc.)
- Agregar límites de tamaño para las imágenes
- Integrar analytics para entender mejor cómo se usa la app
- Crear una guía de estilo y estandarizar el formateo del código

## Notas finales

La app tiene una base sólida - la arquitectura es clara, el diseño offline-first funciona bien, y el sistema de formularios dinámicos es bastante flexible. Pero definitivamente necesitamos mejorar el testing (estamos en menos del 5% de cobertura), implementar migraciones de BD, y mejorar el manejo de errores.

El proyecto tiene como ~141 archivos Dart (15-20K líneas de código aproximadamente) más los 13K líneas de configuración JSON. La BD tiene 5 tablas y la API tiene 4 endpoints.

---

Última actualización: diciembre 2025  
Versión: `25.03.13+2503131` (Flutter 3.22.3)
