import 'package:material_ui/material_ui.dart';

import '../theme/theme.dart';

/// Elemento de una lista numerada o con letras ("1.", "a.") con sangría
/// francesa: el texto largo se alinea con la primera línea, no con el número.
class AppNumberedText extends StatelessWidget {
  final String marker;
  final String text;

  const AppNumberedText({super.key, required this.marker, required this.text});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyLarge;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: AppSpacing.lg, child: Text(marker, style: style)),
          Expanded(child: Text(text, style: style)),
        ],
      ),
    );
  }
}
