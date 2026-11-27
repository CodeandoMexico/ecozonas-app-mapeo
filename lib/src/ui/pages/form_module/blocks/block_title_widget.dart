import 'package:material_ui/material_ui.dart';

import '../../../theme/theme.dart';

class BlockTitleWidget extends StatelessWidget {
  final String title;
  final String? description;

  const BlockTitleWidget({super.key, required this.title, this.description});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final hasDescription = description != null && description!.trim().isNotEmpty;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: textTheme.titleSmall),
          if (hasDescription) ...[
            const SizedBox(height: AppSpacing.xxs),
            Text(description!, style: textTheme.bodyMedium!.copyWith(color: AppColors.textSecondary)),
          ],
        ],
      ),
    );
  }
}
