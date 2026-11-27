import 'package:material_ui/material_ui.dart';

import 'app_button.dart';

/// Botón principal (amarillo). Usa [AppButton]; se conserva para no tocar
/// todas las pantallas a la vez.
class MyPrimaryElevatedButton extends StatelessWidget {
  final String label;
  final bool? fullWidth;
  final double? elevation;
  final Function()? onPressed;

  const MyPrimaryElevatedButton({super.key, required this.label, this.fullWidth = false, required this.onPressed, this.elevation = 0});

  @override
  Widget build(BuildContext context) {
    return AppButton.primary(
      label: label,
      onPressed: onPressed,
      fullWidth: fullWidth == true,
      elevated: (elevation ?? 0) > 0,
    );
  }
}
