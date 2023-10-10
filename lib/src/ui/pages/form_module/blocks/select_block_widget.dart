import 'package:flutter/material.dart';

import '../../../../domain/models/new_mapaton_model.dart';
import 'block_title_widget.dart';

class SelectBlockWidget extends StatefulWidget {
  final String title;
  final String description;
  final List<Choice> choices;

  const SelectBlockWidget({super.key, required this.title, required this.description, required this.choices});

  @override
  State<SelectBlockWidget> createState() => _SelectBlockWidgetState();
}

class _SelectBlockWidgetState extends State<SelectBlockWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlockTitleWidget(
            title: widget.title,
            description: widget.description,
          ),
          ...widget.choices.map((e) {
            return CheckboxListTile(
              value: e.checked ?? false,
              title: Text(e.label),
              onChanged: (value) {
                setState(() => e.checked = value);
              }
            );
          })
        ],
      ),
    );
  }
}