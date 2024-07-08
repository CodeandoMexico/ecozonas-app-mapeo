import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../domain/models/mapaton_model.dart';
import '../../ui/utils/color_extension.dart';
import '../../ui/utils/constants.dart';
import '../../ui/utils/utils.dart' as utils;

class ActivityItem extends StatelessWidget {
  final Activity activity;
  final Function? callback;

  const ActivityItem({super.key, required this.activity, this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callback!(),
      child: Card(
        color: activity.color!.toColor(),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: activity.borderColor!.toColor(), width: 2)
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 92,
                    width: 92,
                    padding: const EdgeInsets.all(20.0),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white
                    ),
                    child: utils.getCategoryIcon(code: activity.category.code, size: 60)
                  ),
                  const SizedBox(width: 16.0),
                  _activityDetails(context)
                ],
              ),
              _activityButton(context, activity)
            ],
          ),
        ),
      ),
    );
  }

  Widget _activityDetails(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            utils.showEnglish(context) ? activity.titleEn : activity.title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: Constants.paddingSmall),
          Text(
            utils.showEnglish(context) ? activity.descriptionEn : activity.description,
            style: const TextStyle(fontSize: 12)
          ),
          const SizedBox(height: Constants.paddingSmall),
          activity.counter != null ?
            Text(
              '${AppLocalizations.of(context)!.mappingsFinished} ${activity.counter}',
              style: const TextStyle(fontSize: 12)) :
            Container()
        ],
      ),
    );
  }

  Widget _activityButton(BuildContext context, Activity activity) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            children: [
              activity.isPriority ? Image.asset('assets/icons/ic_asterisk_50.png', width: 18) : Container(),
              activity.isPriority ? Image.asset('assets/icons/ic_asterisk_50.png', width: 18) : Container(),
              SizedBox(width: activity.isPriority ? 8.0 : 0),
              Flexible(child: Text(utils.showEnglish(context) ? activity.category.nameEn : activity.category.name, style: const TextStyle(fontSize: 10)))
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () => callback!(),
          style: ElevatedButton.styleFrom(
            backgroundColor: Constants.darkBlueColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)
            )
          ),
          child: Text(AppLocalizations.of(context)!.mapOut, style: const TextStyle(color: Colors.white, fontSize: 14))
        )
      ],
    );
  }
}