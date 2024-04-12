import 'package:flutter/material.dart';

import '../../../../domain/models/mapaton_model.dart';
import 'block_error_text_widget.dart';
import 'block_title_widget.dart';

class RadioBlockWidget extends StatefulWidget {
  final String title;
  final String description;
  final List<Choice> choices;
  final bool? isRequired;
  final Function(String) callback;

  const RadioBlockWidget({super.key, required this.title, required this.description, required this.choices, this.isRequired, required this.callback});

  @override
  State<RadioBlockWidget> createState() => _RadioBlockWidgetState();
}

class _RadioBlockWidgetState extends State<RadioBlockWidget> {
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
            child: Wrap(
              direction: Axis.horizontal,
              runAlignment: WrapAlignment.center,
              alignment: WrapAlignment.center,
              children: widget.choices.asMap().entries.map((e) {
                return GestureDetector(
                  onTap: () => _onChanged(e, e.key),
                  child: Row(
                    children: [
                      Radio(
                        value: e.key,
                        groupValue: selectedRadioTile,
                        visualDensity: VisualDensity.compact,
                        onChanged: (value) => _onChanged(e, value),
                      ),
                      Expanded(child: Text(e.value.label, style: const TextStyle(fontSize: 16)))
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