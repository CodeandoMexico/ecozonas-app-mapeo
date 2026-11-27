import 'package:material_ui/material_ui.dart';

import 'block_error_text_widget.dart';
import 'block_title_widget.dart';
import '../../../theme/theme.dart';

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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
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
            decoration: const InputDecoration(),
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