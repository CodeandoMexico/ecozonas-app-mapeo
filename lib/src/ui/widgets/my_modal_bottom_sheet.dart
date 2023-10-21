import 'package:flutter/material.dart';

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
          title: Text(
            titleText!,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
          ),
        ) : Container(margin: const EdgeInsets.only(top: 12.0)),
        ...options.map((e) {
          return ListTile(
            onTap: () {
              Navigator.pop(context);
              textController.text = e;
              callback(e);
            },
            leading: Radio(
              value: false,
              groupValue: 'options',
              onChanged: (value) {}
            ),
            title: Text(e, style: const TextStyle(fontSize: 18)),
          );
        }).toList(),
      ],
    );
  }
}