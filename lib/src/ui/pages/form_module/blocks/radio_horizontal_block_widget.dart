import 'package:flutter/material.dart';

import '../../../../domain/models/mapaton_model.dart';
import 'block_error_text_widget.dart';
import 'block_title_widget.dart';

class RadioHorizontalBlockWidget extends StatefulWidget {
  final String title;
  final String description;
  final List<Choice> choices;
  final bool? isRequired;
  final Function(String) callback;

  const RadioHorizontalBlockWidget({super.key, required this.title, required this.description, required this.choices, this.isRequired, required this.callback});

  @override
  State<RadioHorizontalBlockWidget> createState() => _RadioBlockWidgetState();
}

class _RadioBlockWidgetState extends State<RadioHorizontalBlockWidget> {
  int? selectedRadioTile;
  late String selectedValue;
  late bool showError;

  @override
  void initState() {
    showError = widget.isRequired ?? false;
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlockTitleWidget(
            title: widget.title,
            description: widget.description,
          ),
          BlockErrorTextWidget(showError: showError),
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: widget.choices.asMap().entries.map((e) {
                return GestureDetector(
                  onTap: () => _onChanged(e, e.key),
                  child: Column(
                    children: [
                      Radio(
                        value: e.key,
                        groupValue: selectedRadioTile,
                        visualDensity: VisualDensity.compact,
                        onChanged: (value) => _onChanged(e, value),
                      ),
                      Text(e.value.label, style: const TextStyle(fontSize: 16))
                    ],
                  ),
                );
              }).toList()
            ),
          )
        ],
      ),
    );
  }

  void _onChanged(MapEntry<int, Choice> e, int? value) {
    selectedValue = e.value.label;
    setState(() {
      _setSelectedRadioTile(value!);
      showError = false;
    });
    widget.callback(e.value.value);
  }

  void _setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }
}