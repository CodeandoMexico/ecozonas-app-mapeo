import 'package:material_ui/material_ui.dart';

import '../../../../domain/models/mapaton_model.dart';
import '../../../utils/utils.dart' as utils;
import 'block_error_text_widget.dart';
import 'block_title_widget.dart';
import '../../../theme/theme.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
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
            child: RadioGroup<int>(
              groupValue: selectedRadioTile,
              onChanged: (value) {
                if (value != null) _onChanged(MapEntry(value, widget.choices[value]), value);
              },
              child: Wrap(
                direction: Axis.horizontal,
                runAlignment: WrapAlignment.center,
                alignment: WrapAlignment.center,
                children: widget.choices.asMap().entries.map((e) {
                  return GestureDetector(
                    onTap: () => _onChanged(e, e.key),
                    child: Row(
                      children: [
                        Radio<int>(
                          value: e.key,
                          visualDensity: VisualDensity.compact,
                        ),
                        Expanded(child: Text(utils.localized(context, es: e.value.label, en: e.value.labelEn), style: Theme.of(context).textTheme.bodyLarge))
                      ],
                    ),
                  );
                }).toList()
              ),
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