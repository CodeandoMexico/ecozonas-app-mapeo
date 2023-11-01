import 'package:flutter/material.dart';

import '../../domain/models/mapaton_model.dart';
import '../../ui/utils/color_extension.dart';
import '../../ui/utils/constants.dart';

class ActivityItem extends StatelessWidget {
  final Activity activity;
  final Function? callback;

  const ActivityItem({super.key, required this.activity, this.callback});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: activity.color != null ? activity.color!.toColor() : const Color(0xFFC2D2E7),
      margin:const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        // side: const BorderSide(color: Color(0xFF6A94C6), width: 2)
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white
                  ),
                  child: const Icon(Icons.abc, size: 60)
                  // child: const FaIcon(FontAwesomeIcons.adn, size: 60)
                ),
                const SizedBox(width: 16.0),
                _activityDetails()
              ],
            ),
            _activityButton(activity.isPriority)
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
          const SizedBox(height: 8.0),
          Text(
            activity.description,
            style: const TextStyle(fontSize: 12),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _activityButton(bool isPriority) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            children: [
              isPriority ? Image.asset('assets/icons/ic_asterisk_50.png', width: 18) : Container(),
              isPriority ? Image.asset('assets/icons/ic_asterisk_50.png', width: 18) : Container(),
              SizedBox(width: isPriority ? 8.0 : 0),
              const Icon(Icons.business_outlined, size: 15),
              const SizedBox(width: 4.0),
              Flexible(child: Text(activity.category.description!, style: const TextStyle(fontSize: 10)))
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