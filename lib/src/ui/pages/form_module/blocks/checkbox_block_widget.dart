import 'package:flutter/material.dart';

import '../../../../domain/models/mapaton_model.dart';
import 'block_title_widget.dart';

class CheckboxBlockWidget extends StatefulWidget {
  final String title;
  final String description;
  final List<Choice> choices;
  final Function(List<String>) callback;

  const CheckboxBlockWidget({super.key, required this.title, required this.description, required this.choices, required this.callback});

  @override
  State<CheckboxBlockWidget> createState() => _CheckboxBlockWidgetState();
}

class _CheckboxBlockWidgetState extends State<CheckboxBlockWidget> {
  late List<String> selectedChoices;

  @override
  void initState() {
    selectedChoices = [];
    super.initState();
  }

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
                selectedChoices.add(e.label);
                setState(() => e.checked = value);
                widget.callback(selectedChoices);
              }
            );
          })
        ],
      ),
    );
  }
}