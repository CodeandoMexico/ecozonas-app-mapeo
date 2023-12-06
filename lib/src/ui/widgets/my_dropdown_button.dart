import 'package:flutter/material.dart';

import '../pages/form_module/blocks/block_error_text_widget.dart';
import '../theme/theme.dart';
import '../utils/constants.dart';

class MyDropdownButton extends StatefulWidget {
  final String labelText;
  final List<String> items;
  final bool? isRequired;
  final Function(String?) onChange;

  const MyDropdownButton({super.key, required this.labelText, required this.items, this.isRequired = false, required this.onChange});

  @override
  State<MyDropdownButton> createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  late bool showError;

  @override
  void initState() {
    showError = widget.isRequired ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlockErrorTextWidget(showError: showError),
        DropdownButtonFormField(
          hint: const Text('Selecciona una opción'),
          isExpanded: true,
          items: _getItems(),
          style: const TextStyle(fontSize: 18, color: Constants.labelTextColor),
          icon: const Icon(Icons.keyboard_arrow_down),
          decoration: InputDecoration(
            labelText: widget.labelText,
            labelStyle: const TextStyle(color: Colors.black),
            enabledBorder: _border(),
            focusedBorder: _border(),
          ),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                showError = false;     
              });
            }

            widget.onChange(value);
          }
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> _getItems() {
    List<DropdownMenuItem<String>> list = [];

    for (var element in widget.items) {
      list.add(DropdownMenuItem(
        value: element,
        child: Text(element),
      ));
    }

    return list;
  }

  InputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(Constants.borderRadius),
      borderSide: BorderSide(color: myTheme.colorScheme.secondary),
    );
  }
}