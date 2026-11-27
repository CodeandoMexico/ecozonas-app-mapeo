import 'package:material_ui/material_ui.dart';

import 'app_button.dart';

/// Botón de contorno. Usa [AppButton]; se conserva para no tocar todas las
/// pantallas a la vez.
class MySecondaryElevatedButton extends StatelessWidget {
  final String label;
  final IconData? iconData;
  final bool? fullWidth;
  final Function()? onPressed;

  const MySecondaryElevatedButton({super.key, required this.label, this.iconData, this.fullWidth = true, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppButton.outline(
      label: label,
      icon: iconData,
      onPressed: onPressed,
      fullWidth: fullWidth == true,
    );
  }
}
