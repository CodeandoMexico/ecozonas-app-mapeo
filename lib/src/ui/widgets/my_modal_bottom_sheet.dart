import 'package:material_ui/material_ui.dart';

import '../theme/theme.dart';

class MyModalBottomSheet extends StatelessWidget {
  final String? titleText;
  final List<String> options;
  final Function(String) callback;

  MyModalBottomSheet(
      {super.key,
      this.titleText,
      required this.options,
      required this.callback});

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Wrap(
        children: [
          if (titleText != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md, 0, AppSpacing.md, AppSpacing.xs),
              child: Text(titleText!,
                  style: Theme.of(context).textTheme.titleMedium),
            ),
          // Los círculos son decorativos: ninguno aparece seleccionado.
          RadioGroup<String>(
            groupValue: null,
            onChanged: (value) {
              if (value != null) _onTap(context, value);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: options.map((e) {
                return ListTile(
                  onTap: () => _onTap(context, e),
                  leading: Radio<String>(value: e),
                  title: Text(e),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  void _onTap(BuildContext context, String e) {
    Navigator.pop(context);
    textController.text = e;
    callback(e);
  }
}
