import 'package:material_ui/material_ui.dart';

class MyModalBottomSheet extends StatelessWidget {
  final String ?titleText;
  final List<String> options;
  final Function(String) callback;

  MyModalBottomSheet({super.key, this.titleText, required this.options, required this.callback});

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        titleText != null ? ListTile(
          title: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              titleText!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
            ),
          ),
        ) : Container(margin: const EdgeInsets.only(top: 12.0)),
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
                title: Text(e, style: const TextStyle(fontSize: 18)),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  void _onTap(BuildContext context, String e) {
    Navigator.pop(context);
    textController.text = e;
    callback(e);
  }
}