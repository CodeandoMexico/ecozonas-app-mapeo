import 'package:flutter/material.dart';

import '../../../../domain/models/new_mapaton_model.dart';
import 'block_title_widget.dart';

class RadioBlockWidget extends StatefulWidget {
  final String title;
  final String description;
  final List<Choice> choices;

  const RadioBlockWidget({super.key, required this.title, required this.description, required this.choices});

  @override
  State<RadioBlockWidget> createState() => _RadioBlockWidgetState();
}

class _RadioBlockWidgetState extends State<RadioBlockWidget> {
  late int selectedRadioTile;

  @override
  void initState() {
    selectedRadioTile = 0;
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {

    setSelectedRadioTile(int val) {
      setState(() {
        selectedRadioTile = val;
      });
    }

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
          SizedBox(
            width: double.infinity,
            child: Wrap(
              direction: Axis.horizontal,
              runAlignment: WrapAlignment.center,
              alignment: WrapAlignment.center,
              children: widget.choices.asMap().entries.map((e) {
                return RadioListTile(
                  value: e.key,
                  title: Text(e.value.label),
                  groupValue: selectedRadioTile,
                  onChanged: (value) {
                    setState(() => setSelectedRadioTile(value!));
                  },
                );
              }).toList()
            ),
          )
        ],
      ),
    );
  }
}



// return Row(
//   mainAxisSize: MainAxisSize.min,
//   children: [
//     Text(e.label),
//     Checkbox(
//       value: e.checked ?? false,
//       onChanged: (value) {
//         setState(() {
//           e.checked = value;
//         });
//       }
//     )
//   ],
// );