import 'package:flutter/material.dart';

import '../../../../domain/models/mapaton_model.dart';
import '../../../widgets/my_dropdown_button.dart';
import 'block_title_widget.dart';

class SelectBlockWidget extends StatelessWidget {
  final String title;
  final String description;
  final List<Choice> choices;
  final Function(String) callback;

  const SelectBlockWidget({super.key, required this.title, required this.description, required this.choices, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlockTitleWidget(
            title: title,
            description: description,
          ),
          MyDropdownButton(
            labelText: '',
            items: choices.map((e) => e.label).toList(),
            onChange: (value) {
              if (value != null) {
                callback(value);
              }
            },
          )
        ],
      ),
    );
  }
}