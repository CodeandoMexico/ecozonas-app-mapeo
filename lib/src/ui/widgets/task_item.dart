import 'package:flutter/material.dart';

import '../../domain/models/task_model.dart';
import '../pages/form_module/form_page.dart';

class TaskItem extends StatelessWidget {
  final TaskModel task;

  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin:const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Color(0xFFB6B6B6), width: 2)
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
              child: _activityDetails(context),
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
        Image.asset('assets/images/map_placeholder.jpg'),
        const SizedBox(height: 8.0),
        LinearProgressIndicator(
          value: task.percentage,
          color: Colors.black,
          backgroundColor: Colors.grey,
        ),
        Text('${(task.percentage * 100).round()}% completado', style: const TextStyle(fontSize: 10))
      ],
    );
  }

  Widget _activityDetails(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          task.title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8.0),
        Text(
          task.detail,
          style: const TextStyle(fontSize: 12),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const Spacer(),
        _activityButton(context)
      ],
    );
  }

  Widget _activityButton(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.business_outlined, size: 15),
              const SizedBox(width: 4.0),
              Flexible(child: Text(task.type, style: const TextStyle(fontSize: 10)))
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, FormPage.routeName),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff4B5375),
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