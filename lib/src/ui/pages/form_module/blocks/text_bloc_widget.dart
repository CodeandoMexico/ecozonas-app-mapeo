import 'package:flutter/material.dart';

import 'block_title_widget.dart';

class TextBlockWidget extends StatelessWidget {
  final String title;
  final String description;
  final int? maxLines;
  final TextInputType? textInputType;
  final Function(String) onChanged;

  const TextBlockWidget({super.key, required this.title, required this.description, this.maxLines = 1, this.textInputType = TextInputType.text, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10)
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlockTitleWidget(
            title: title,
            description: description,
          ),
          TextFormField(
            maxLines: maxLines,
            keyboardType: textInputType,
            decoration: InputDecoration(
              border: border,
              focusedBorder: border
            ),
            onChanged: (value) => onChanged(value),
          )
        ],
      ),
    );
  }
}