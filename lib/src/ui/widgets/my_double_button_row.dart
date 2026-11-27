import 'package:material_ui/material_ui.dart';

import '../theme/theme.dart';
import 'app_button.dart';

/// Par de botones al pie de un formulario: cancelar (contorno) y aceptar (principal).
class MyDoubleButtonRow extends StatelessWidget {
  final String cancelText;
  final Function cancelCallback;
  final String acceptText;
  final Function acceptCallback;

  const MyDoubleButtonRow({super.key, required this.cancelText, required this.cancelCallback, required this.acceptText, required this.acceptCallback});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppButton.outline(label: cancelText, onPressed: () => cancelCallback(), fullWidth: true),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: AppButton.primary(label: acceptText, onPressed: () => acceptCallback(), fullWidth: true),
        ),
      ],
    );
  }
}
