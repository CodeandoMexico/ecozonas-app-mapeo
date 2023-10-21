import 'package:ecozonas/src/ui/utils/constants.dart';
import 'package:flutter/material.dart';

class BlockTitleWidget extends StatelessWidget {
  final String title;
  final String? description;

  const BlockTitleWidget({super.key, required this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, color: Constants.labelTextColor, fontWeight: FontWeight.bold)
        ),
        description != null && description!.isNotEmpty ?
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              description!,
              style: const TextStyle(fontSize: 16, color: Constants.labelTextColor),
            ),
          ) : Container()
      ],
    );
  }
}