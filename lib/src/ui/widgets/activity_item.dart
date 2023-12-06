import 'package:flutter/material.dart';

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
    return Card(
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
                _activityDetails()
              ],
            ),
            _activityButton(activity)
          ],
        ),
      ),
    );
  }

  Widget _activityDetails() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            activity.title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: Constants.paddingSmall),
          Text(
            activity.description,
            style: const TextStyle(fontSize: 12)
          ),
          const SizedBox(height: Constants.paddingSmall),
          activity.counter != null ?
            Text('Mapeos realizados: ${activity.counter}') :
            Container()
        ],
      ),
    );
  }

  Widget _activityButton(Activity activity) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            children: [
              activity.isPriority ? Image.asset('assets/icons/ic_asterisk_50.png', width: 18) : Container(),
              activity.isPriority ? Image.asset('assets/icons/ic_asterisk_50.png', width: 18) : Container(),
              SizedBox(width: activity.isPriority ? 8.0 : 0),
              Flexible(child: Text(activity.category.description, style: const TextStyle(fontSize: 10)))
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
          child: const Text('Mapear', style: TextStyle(color: Colors.white, fontSize: 14))
        )
      ],
    );
  }
}