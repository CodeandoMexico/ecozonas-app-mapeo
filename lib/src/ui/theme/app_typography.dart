import 'package:material_ui/material_ui.dart';

import 'app_tokens.dart';

/// Escala tipográfica de la app con Inter (fuente variable incluida en
/// assets/fonts/inter). Usar estos estilos vía Theme.of(context).textTheme
/// en lugar de TextStyle con tamaños sueltos.
///
/// | Estilo         | Tamaño | Peso     | Uso                                   |
/// |----------------|--------|----------|---------------------------------------|
/// | headlineSmall  | 24     | semibold | títulos de pantalla grandes           |
/// | titleLarge     | 20     | semibold | títulos de sección destacados         |
/// | titleMedium    | 18     | semibold | barra superior, títulos de diálogo    |
/// | titleSmall     | 16     | semibold | títulos de tarjeta y de campo         |
/// | bodyLarge      | 16     | regular  | texto principal, valores de campos    |
/// | bodyMedium     | 14     | regular  | descripciones, textos de apoyo        |
/// | bodySmall      | 12     | regular  | notas, metadatos                      |
/// | labelLarge     | 16     | semibold | botones                               |
/// | labelMedium    | 14     | medium   | botones pequeños, chips               |
/// | labelSmall     | 12     | medium   | etiquetas de la barra inferior        |
abstract final class AppTypography {
  static const fontFamily = 'Inter';

  static const _regular = FontWeight.w400;
  static const _medium = FontWeight.w500;
  static const _semibold = FontWeight.w600;

  static const textTheme = TextTheme(
    headlineSmall: TextStyle(fontSize: 24, height: 1.25, fontWeight: _semibold, color: AppColors.textPrimary),
    titleLarge: TextStyle(fontSize: 20, height: 1.3, fontWeight: _semibold, color: AppColors.textPrimary),
    titleMedium: TextStyle(fontSize: 18, height: 1.3, fontWeight: _semibold, color: AppColors.textPrimary),
    titleSmall: TextStyle(fontSize: 16, height: 1.35, fontWeight: _semibold, color: AppColors.textPrimary),
    bodyLarge: TextStyle(fontSize: 16, height: 1.5, fontWeight: _regular, color: AppColors.textPrimary),
    bodyMedium: TextStyle(fontSize: 14, height: 1.45, fontWeight: _regular, color: AppColors.textPrimary),
    bodySmall: TextStyle(fontSize: 12, height: 1.4, fontWeight: _regular, color: AppColors.textSecondary),
    labelLarge: TextStyle(fontSize: 16, height: 1.25, fontWeight: _semibold),
    labelMedium: TextStyle(fontSize: 14, height: 1.25, fontWeight: _medium),
    labelSmall: TextStyle(fontSize: 12, height: 1.25, fontWeight: _medium),
  );
}
