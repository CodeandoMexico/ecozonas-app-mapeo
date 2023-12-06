import 'package:flutter/material.dart';

import '../../../../domain/models/mapaton_model.dart';
import 'block_error_text_widget.dart';
import 'block_title_widget.dart';

class CheckboxBlockWidget extends StatefulWidget {
  final String title;
  final String description;
  final List<Choice> choices;
  final bool? isRequired;
  final Function(List<String>) callback;

  const CheckboxBlockWidget({super.key, required this.title, required this.description, required this.choices, this.isRequired, required this.callback});

  @override
  State<CheckboxBlockWidget> createState() => _CheckboxBlockWidgetState();
}

class _CheckboxBlockWidgetState extends State<CheckboxBlockWidget> {
  late List<String> selectedChoices;
  late bool showError;

  @override
  void initState() {
    selectedChoices = [];
    showError = widget.isRequired ?? false;
    for (var element in widget.choices) {
      element.checked = false;
    }
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
          BlockErrorTextWidget(showError: showError),
          ...widget.choices.map((e) {
            return CheckboxListTile(
              value: e.checked ?? false,
              title: Text(e.label),
              onChanged: (value) {
                if (value != null && value) {
                  selectedChoices.add(e.value);
                } else {
                  selectedChoices.remove(e.value);
                }

                setState(() {
                  e.checked = value;
                  showError = selectedChoices.isEmpty;
                });

                widget.callback(selectedChoices);
              }
            );
          })
        ],
      ),
    );
  }
}