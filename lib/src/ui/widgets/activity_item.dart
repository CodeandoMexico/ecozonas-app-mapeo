import 'package:material_ui/material_ui.dart';
import 'package:ecozonas/l10n/app_localizations.dart';

import '../../domain/models/mapaton_model.dart';
import '../../ui/utils/color_extension.dart';
import '../../ui/utils/utils.dart' as utils;
import '../theme/theme.dart';
import 'app_button.dart';

class ActivityItem extends StatelessWidget {
  final Activity activity;
  final Function? callback;

  const ActivityItem({super.key, required this.activity, this.callback});

  @override
  Widget build(BuildContext context) {
    // Fondo y borde con los colores de la dimensión (vienen del servidor).
    return Card(
      color: activity.color!.toColor(),
      margin: const EdgeInsets.fromLTRB(AppSpacing.md, 0, AppSpacing.md, AppSpacing.sm),
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.mdAll,
        side: BorderSide(color: activity.borderColor!.toColor(), width: 1.5),
      ),
      child: InkWell(
        onTap: () => callback!(),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 56,
                    width: 56,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.surface),
                    child: utils.getCategoryIcon(code: activity.category.code, size: 32),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  _activityDetails(context),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              _activityButton(context, activity),
            ],
          ),
        ),
      ),
    );
  }

  Widget _activityDetails(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            utils.localized(context, es: activity.title, en: activity.titleEn),
            style: textTheme.titleSmall,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            utils.localized(context, es: activity.description, en: activity.descriptionEn),
            style: textTheme.bodyMedium,
          ),
          if (activity.counter != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              '${AppLocalizations.of(context)!.mappingsFinished} ${activity.counter}',
              style: textTheme.bodySmall!.copyWith(color: AppColors.textPrimary),
            ),
          ],
        ],
      ),
    );
  }

  Widget _activityButton(BuildContext context, Activity activity) {
    return Row(
      children: [
        if (activity.isPriority) ...[
          Image.asset('assets/icons/ic_asterisk_50.png', width: 16),
          Image.asset('assets/icons/ic_asterisk_50.png', width: 16),
          const SizedBox(width: AppSpacing.xs),
        ],
        Expanded(
          child: Text(
            utils.localized(context, es: activity.category.name, en: activity.category.nameEn),
            style: Theme.of(context).textTheme.labelSmall!.copyWith(color: AppColors.textPrimary),
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        AppButton.secondary(
          label: AppLocalizations.of(context)!.mapOut,
          size: AppButtonSize.small,
          onPressed: () => callback!(),
        ),
      ],
    );
  }
}
