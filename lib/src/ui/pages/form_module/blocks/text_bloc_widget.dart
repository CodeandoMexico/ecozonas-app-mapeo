import 'package:flutter/material.dart';

import 'block_error_text_widget.dart';
import 'block_title_widget.dart';

class TextBlockWidget extends StatefulWidget {
  final String title;
  final String description;
  final int? maxLines;
  final TextInputType? textInputType;
  final bool? isRequired;
  final Function(String) onChanged;

  const TextBlockWidget({super.key, required this.title, required this.description, this.maxLines = 1, this.textInputType = TextInputType.text, this.isRequired, required this.onChanged});

  @override
  State<TextBlockWidget> createState() => _TextBlockWidgetState();
}

class _TextBlockWidgetState extends State<TextBlockWidget> {
  late bool showError;

  @override
  void initState() {
    showError = widget.isRequired ?? false;
    super.initState();
  }

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
            title: widget.title,
            description: widget.description,
          ),
          BlockErrorTextWidget(showError: showError),
          TextFormField(
            maxLines: widget.maxLines,
            keyboardType: widget.textInputType,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              border: border,
              focusedBorder: border
            ),
            onChanged: (value) {
              setState(() {
                showError = value.isEmpty;
              });
              widget.onChanged(value);
            },
          )
        ],
      ),
    );
  }
}