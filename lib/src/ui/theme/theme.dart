import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';

import 'app_tokens.dart';
import 'app_typography.dart';

export 'app_tokens.dart';
export 'app_typography.dart';

const _colorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: AppColors.primary,
  onPrimary: AppColors.onPrimary,
  primaryContainer: AppColors.primaryContainer,
  onPrimaryContainer: AppColors.textPrimary,
  secondary: AppColors.secondary,
  onSecondary: AppColors.onSecondary,
  surface: AppColors.surface,
  onSurface: AppColors.textPrimary,
  onSurfaceVariant: AppColors.textSecondary,
  surfaceContainerHighest: AppColors.surfaceMuted,
  outline: AppColors.outline,
  outlineVariant: AppColors.outlineVariant,
  error: AppColors.error,
  onError: Colors.white,
);

const _textTheme = AppTypography.textTheme;

/// Forma compartida por botones, campos y tarjetas.
const _controlShape = RoundedRectangleBorder(borderRadius: AppRadius.mdAll);

ButtonStyle _buttonBase() {
  return ButtonStyle(
    minimumSize: const WidgetStatePropertyAll(Size(64, AppSizes.controlHeight)),
    padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: AppSpacing.lg)),
    shape: const WidgetStatePropertyAll(_controlShape),
    textStyle: WidgetStatePropertyAll(_textTheme.labelLarge),
    elevation: const WidgetStatePropertyAll(0),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );
}

OutlineInputBorder _inputBorder(Color color, [double width = 1]) {
  return OutlineInputBorder(
    borderRadius: AppRadius.mdAll,
    borderSide: BorderSide(color: color, width: width),
  );
}

/// Tema de la app. Define colores, tipografía y el aspecto de los
/// componentes de Material para que las pantallas no tengan que hacerlo.
final appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: _colorScheme,
  fontFamily: AppTypography.fontFamily,
  textTheme: _textTheme,
  scaffoldBackgroundColor: AppColors.background,
  visualDensity: VisualDensity.standard,

  appBarTheme: AppBarTheme(
    centerTitle: true,
    elevation: 0,
    scrolledUnderElevation: 0,
    backgroundColor: AppColors.surface,
    surfaceTintColor: Colors.transparent,
    foregroundColor: AppColors.textPrimary,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    titleTextStyle: _textTheme.titleMedium,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: _buttonBase().copyWith(
      backgroundColor: WidgetStateProperty.resolveWith((states) =>
          states.contains(WidgetState.disabled) ? AppColors.disabled : AppColors.primary),
      foregroundColor: WidgetStateProperty.resolveWith((states) =>
          states.contains(WidgetState.disabled) ? AppColors.onDisabled : AppColors.onPrimary),
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: _buttonBase().copyWith(
      backgroundColor: WidgetStateProperty.resolveWith((states) =>
          states.contains(WidgetState.disabled) ? AppColors.disabled : AppColors.secondary),
      foregroundColor: WidgetStateProperty.resolveWith((states) =>
          states.contains(WidgetState.disabled) ? AppColors.onDisabled : AppColors.onSecondary),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: _buttonBase().copyWith(
      foregroundColor: const WidgetStatePropertyAll(AppColors.secondary),
      side: WidgetStateProperty.resolveWith((states) => BorderSide(
          color: states.contains(WidgetState.disabled) ? AppColors.disabled : AppColors.secondary)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: _buttonBase().copyWith(
      foregroundColor: const WidgetStatePropertyAll(AppColors.secondary),
      padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: AppSpacing.sm)),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surface,
    contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 14),
    labelStyle: _textTheme.bodyLarge!.copyWith(color: AppColors.textSecondary),
    // La etiqueta flotante se dibuja al 75 %: con bodyLarge (16) queda en 12.
    floatingLabelStyle: _textTheme.bodyLarge!.copyWith(color: AppColors.secondary, fontWeight: FontWeight.w500),
    hintStyle: _textTheme.bodyLarge!.copyWith(color: AppColors.textSecondary),
    helperStyle: _textTheme.bodySmall,
    errorStyle: _textTheme.bodySmall!.copyWith(color: AppColors.error),
    border: _inputBorder(AppColors.outline),
    enabledBorder: _inputBorder(AppColors.outline),
    focusedBorder: _inputBorder(AppColors.secondary, 2),
    errorBorder: _inputBorder(AppColors.error),
    focusedErrorBorder: _inputBorder(AppColors.error, 2),
    disabledBorder: _inputBorder(AppColors.outlineVariant),
  ),

  cardTheme: const CardThemeData(
    elevation: 0,
    margin: EdgeInsets.zero,
    color: AppColors.surfaceMuted,
    surfaceTintColor: Colors.transparent,
    shape: _controlShape,
    clipBehavior: Clip.antiAlias,
  ),

  listTileTheme: ListTileThemeData(
    contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
    titleTextStyle: _textTheme.bodyLarge,
    subtitleTextStyle: _textTheme.bodyMedium!.copyWith(color: AppColors.textSecondary),
    iconColor: AppColors.textSecondary,
  ),

  radioTheme: RadioThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) =>
        states.contains(WidgetState.selected) ? AppColors.secondary : AppColors.outline),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) =>
        states.contains(WidgetState.selected) ? AppColors.secondary : Colors.transparent),
    side: const BorderSide(color: AppColors.outline, width: 1.5),
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
  ),

  chipTheme: ChipThemeData(
    backgroundColor: AppColors.surface,
    side: const BorderSide(color: AppColors.outline),
    shape: const RoundedRectangleBorder(borderRadius: AppRadius.smAll),
    labelStyle: _textTheme.labelMedium!.copyWith(color: AppColors.textPrimary),
    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
  ),

  tabBarTheme: TabBarThemeData(
    labelColor: AppColors.textPrimary,
    unselectedLabelColor: AppColors.textSecondary,
    labelStyle: _textTheme.titleSmall,
    unselectedLabelStyle: _textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w500),
    indicatorColor: AppColors.secondary,
    indicatorSize: TabBarIndicatorSize.label,
    dividerColor: AppColors.outlineVariant,
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.surface,
    selectedItemColor: AppColors.secondary,
    unselectedItemColor: AppColors.textSecondary,
    selectedLabelStyle: _textTheme.labelSmall,
    unselectedLabelStyle: _textTheme.labelSmall,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
    elevation: 0,
  ),

  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.surface,
    foregroundColor: AppColors.secondary,
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: AppRadius.lgAll),
  ),

  dialogTheme: DialogThemeData(
    backgroundColor: AppColors.surface,
    surfaceTintColor: Colors.transparent,
    shape: const RoundedRectangleBorder(borderRadius: AppRadius.lgAll),
    titleTextStyle: _textTheme.titleMedium,
    contentTextStyle: _textTheme.bodyLarge,
  ),

  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: AppColors.surface,
    surfaceTintColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
    ),
  ),

  snackBarTheme: SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    shape: const RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
    contentTextStyle: _textTheme.bodyMedium,
  ),

  dividerTheme: const DividerThemeData(color: AppColors.outlineVariant, thickness: 1, space: 1),

  progressIndicatorTheme: const ProgressIndicatorThemeData(color: AppColors.secondary),

  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: AppColors.secondary,
    selectionHandleColor: AppColors.secondary,
  ),
);
