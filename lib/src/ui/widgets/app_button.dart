import 'package:material_ui/material_ui.dart';

import '../theme/theme.dart';

enum AppButtonVariant {
  /// Amarillo: la acción principal de la pantalla (una por pantalla).
  primary,

  /// Azul: acciones importantes que no son la principal.
  secondary,

  /// Contorno azul: acciones alternativas (Cancelar, Copiar…).
  outline,

  /// Contorno rojo: acciones destructivas (Salir de la sesión, Eliminar…).
  danger,

  /// Solo texto: acciones de poca jerarquía.
  text,
}

enum AppButtonSize {
  /// 48 px de alto: el tamaño normal.
  regular,

  /// 36 px de alto: dentro de tarjetas, barras y listas.
  small,
}

/// Botón único de la app. Reemplaza los estilos sueltos de ElevatedButton.
class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final bool fullWidth;
  final IconData? icon;

  /// Sombra para botones que flotan sobre el mapa.
  final bool elevated;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.regular,
    this.fullWidth = false,
    this.icon,
    this.elevated = false,
  });

  const AppButton.primary({super.key, required this.label, required this.onPressed, this.size = AppButtonSize.regular, this.fullWidth = false, this.icon, this.elevated = false})
      : variant = AppButtonVariant.primary;

  const AppButton.secondary({super.key, required this.label, required this.onPressed, this.size = AppButtonSize.regular, this.fullWidth = false, this.icon, this.elevated = false})
      : variant = AppButtonVariant.secondary;

  const AppButton.outline({super.key, required this.label, required this.onPressed, this.size = AppButtonSize.regular, this.fullWidth = false, this.icon, this.elevated = false})
      : variant = AppButtonVariant.outline;

  const AppButton.danger({super.key, required this.label, required this.onPressed, this.size = AppButtonSize.regular, this.fullWidth = false, this.icon, this.elevated = false})
      : variant = AppButtonVariant.danger;

  /// Estilo de cada variante, para los pocos lugares que necesitan un
  /// ButtonStyle en lugar del widget.
  static ButtonStyle styleFor(BuildContext context, AppButtonVariant variant, {AppButtonSize size = AppButtonSize.regular}) {
    final theme = Theme.of(context);
    final small = size == AppButtonSize.small;
    final base = ButtonStyle(
      minimumSize: WidgetStatePropertyAll(Size(small ? 48 : 64, small ? AppSizes.controlHeightSmall : AppSizes.controlHeight)),
      padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: small ? AppSpacing.md : AppSpacing.lg)),
      textStyle: WidgetStatePropertyAll(small ? theme.textTheme.labelMedium : theme.textTheme.labelLarge),
    );

    switch (variant) {
      case AppButtonVariant.primary:
        return base.merge(theme.elevatedButtonTheme.style);
      case AppButtonVariant.secondary:
        return base.merge(theme.filledButtonTheme.style);
      case AppButtonVariant.outline:
        return base.merge(theme.outlinedButtonTheme.style);
      case AppButtonVariant.danger:
        return base.merge(theme.outlinedButtonTheme.style).copyWith(
          foregroundColor: const WidgetStatePropertyAll(AppColors.error),
          side: const WidgetStatePropertyAll(BorderSide(color: AppColors.error)),
        );
      case AppButtonVariant.text:
        return base.merge(theme.textButtonTheme.style);
    }
  }

  @override
  Widget build(BuildContext context) {
    var style = styleFor(context, variant, size: size);
    if (elevated) {
      style = style.copyWith(
        elevation: const WidgetStatePropertyAll(4),
        shadowColor: const WidgetStatePropertyAll(Colors.black54),
      );
    }

    final child = icon == null
        ? Text(label, textAlign: TextAlign.center)
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: size == AppButtonSize.small ? 18 : 20),
              const SizedBox(width: AppSpacing.xs),
              Flexible(child: Text(label, textAlign: TextAlign.center)),
            ],
          );

    final Widget button = switch (variant) {
      AppButtonVariant.primary => ElevatedButton(onPressed: onPressed, style: style, child: child),
      AppButtonVariant.secondary => FilledButton(onPressed: onPressed, style: style, child: child),
      AppButtonVariant.outline || AppButtonVariant.danger => OutlinedButton(onPressed: onPressed, style: style, child: child),
      AppButtonVariant.text => TextButton(onPressed: onPressed, style: style, child: child),
    };

    return fullWidth ? SizedBox(width: double.infinity, child: button) : button;
  }
}
