import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class BlockTitleWidget extends StatelessWidget {
  final String title;
  final String? description;

  const BlockTitleWidget({super.key, required this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 16, color: Constants.labelTextColor, fontWeight: FontWeight.bold)
          ),
        ),
        description != null && description!.trim().isNotEmpty ?
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              description!,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                fontStyle: FontStyle.italic
              ),
            ),
          ) :
          Container()
      ],
    );
  }
}