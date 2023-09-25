import 'package:flutter/material.dart';

import '../../domain/models/activity_model.dart';

class ActivityItem extends StatelessWidget {
  final ActivityModel activity;
  final Function? callback;

  const ActivityItem({super.key, required this.activity, this.callback});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: activity.backgroundColor,
      margin:const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: activity.borderColor, width: 2)
      ),
      child: Container(
        height: 160,
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Flexible(
              flex: 2,
              child: _activityIcon(),
            ),
            const SizedBox(width: 16.0),
            Flexible(
              flex: 5,
              child: _activityDetails(),
            )
          ],
        ),
      ),
    );
  }

  Widget _activityIcon() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white
          ),
          child: Icon(activity.iconData, size: 60)
        ),
        const SizedBox(height: 8.0),
        LinearProgressIndicator(
          value: activity.percentage,
          color: Colors.black,
        ),
        Text('${activity.percentage * 100}% completado', style: const TextStyle(fontSize: 10))
      ],
    );
  }

  Widget _activityDetails() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          activity.title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8.0),
        Text(
          activity.detail,
          style: const TextStyle(fontSize: 12),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const Spacer(),
        _activityButton()
      ],
    );
  }

  Widget _activityButton() {
    return Row(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.business_outlined, size: 15),
              const SizedBox(width: 4.0),
              Flexible(child: Text(activity.type, style: const TextStyle(fontSize: 10)))
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () => callback!(),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff4B5375),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)
            )
          ),
          child: const Text('Ver tareas', style: TextStyle(color: Colors.white, fontSize: 14))
        )
      ],
    );
  }
}