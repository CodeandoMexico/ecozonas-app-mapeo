import 'package:material_ui/material_ui.dart';

import '../utils/constants.dart';
import '../utils/dialogs.dart' as dialogs;
import '../utils/utils.dart' as utils;

/// Selector de opciones. [initialValue] y el valor que recibe [callback] son el
/// `value` (código) de un [ItemModel]; el texto que se muestra es su `label`.
class MyBottomSheetTextField extends StatelessWidget {
  final String titleText;
  final List<ItemModel> options;
  final Function(String) callback;
  final String? initialValue;

  MyBottomSheetTextField({super.key, required this.titleText, required this.options, required this.callback, this.initialValue});

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (initialValue != null) {
      textController.text = utils.optionLabel(options, initialValue!);
    }

    return TextFormField(
      controller: textController,
      onTap: () => showMyBottomSheet(context),
      readOnly: true,
      canRequestFocus: false,
      decoration: InputDecoration(
        labelText: titleText,
        suffixIcon: const Icon(Icons.keyboard_arrow_down),
      ),
    );
  }

  void showMyBottomSheet(BuildContext context) {
    dialogs.showMyBottomSheet(
      context: context,
      titleText: titleText,
      options: options.map((e) => e.label).toList(),
      callback: (label) {
        textController.text = label;
        callback(options.firstWhere((e) => e.label == label).value);
      }
    );
  }
}