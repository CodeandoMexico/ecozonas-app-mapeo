import 'package:material_ui/material_ui.dart';

/// Colores de la app según su uso. Conserva la paleta original de EcoZonas
/// (amarillo, azul oscuro y rojo) y agrega los neutros que faltaban.
abstract final class AppColors {
  // Marca
  static const primary = Color(0xFFF9D47C); // amarillo: acción principal
  static const onPrimary = Color(0xFF4B5375); // texto sobre amarillo (5.4:1)
  static const primaryContainer = Color(0xFFFBE5B0); // amarillo claro: avisos, destacados
  static const secondary = Color(0xFF4B5375); // azul oscuro: acciones secundarias
  static const onSecondary = Colors.white;

  // Superficies
  static const background = Colors.white;
  static const surface = Colors.white;
  static const surfaceMuted = Color(0xFFF4F4F5); // tarjetas sobre fondo blanco

  // Texto
  static const textPrimary = Color(0xFF1F1F1F);
  static const textSecondary = Color(0xFF646464); // 5.9:1 sobre blanco

  // Bordes
  static const outline = Color(0xFF8A8A8A); // campos (3.5:1 sobre blanco)
  static const outlineVariant = Color(0xFFE0E0E0); // separadores y tarjetas

  // Estados
  static const error = Color(0xFFDC362E);
  static const disabled = Color(0xFFDDDDDD);
  static const onDisabled = Color(0xFF8A8A8A);
}

/// Escala de espaciado (múltiplos de 4). Usar estos valores en márgenes,
/// paddings y separaciones en lugar de números sueltos.
abstract final class AppSpacing {
  static const xxs = 4.0;
  static const xs = 8.0;
  static const sm = 12.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
  static const xxl = 48.0;

  /// Margen horizontal de todas las pantallas.
  static const page = EdgeInsets.symmetric(horizontal: md);

  /// Margen de pantalla con espacio arriba y abajo.
  static const pageWithVertical = EdgeInsets.all(md);
}

/// Radios de borde.
abstract final class AppRadius {
  static const sm = 8.0; // chips, etiquetas
  static const md = 12.0; // botones, campos, tarjetas
  static const lg = 16.0; // diálogos, hojas inferiores
  static const pill = 999.0;

  static const smAll = BorderRadius.all(Radius.circular(sm));
  static const mdAll = BorderRadius.all(Radius.circular(md));
  static const lgAll = BorderRadius.all(Radius.circular(lg));
}

/// Tamaños de controles.
abstract final class AppSizes {
  /// Alto de botones y campos (mínimo táctil recomendado: 48).
  static const controlHeight = 48.0;
  static const controlHeightSmall = 36.0;
  static const icon = 24.0;
}
