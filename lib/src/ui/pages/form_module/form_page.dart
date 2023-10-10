import 'package:flutter/material.dart';

import '../../../domain/models/new_mapaton_model.dart';
import '../../theme/theme.dart';
import '../../widgets/my_app_bar.dart';
import '../../widgets/my_double_button_row.dart';
import 'blocks/check_block_widget.dart';
import 'blocks/instructions_block_widget.dart';
import 'blocks/long_text_widget.dart';
import 'blocks/map_block_widget.dart';
import 'blocks/radio_block_widget.dart';
import 'blocks/select_block_widget.dart';
import 'blocks/short_text_widget.dart';

class FormPage extends StatelessWidget {
  static String routeName = 'form';

  const FormPage({super.key});

  @override
  Widget build(BuildContext context) {
    final activity = ModalRoute.of(context)!.settings.arguments as Activity;

    return Scaffold(
      appBar: _appBar(activity),
      body: _body(activity, context),
      backgroundColor: myTheme.primaryColor,
    );
  }

  MyAppBar _appBar(Activity activity) {
    const style = TextStyle(fontSize: 14);

    return MyAppBar(
      title: Column(
        children: [
          Text(activity.mapatonTitle!, style: style),
          Text(activity.mapatonLocationText!, style: style),
        ],
      ),
    );
  }

  Widget _body(Activity activity, BuildContext context) {
    return SingleChildScrollView(
      child:  Column(
        children: [
          ...activity.blocks.map((e) {
            // if (e.blockType == 'POINT') {
            //   return _map(context, e.title);
            // }
            if (e.blockType == 'INSTRUCTIONS') {
              return _instructions(e.title, e.description);
            } else if (e.blockType == 'SHORT_TEXT') {
              return _shortText(e.title, e.description);
            } else if (e.blockType == 'LONG_TEXT') {
              return _longText(e.title, e.description);
            } else if (e.blockType == 'SELECT') {
              return _select(e.title, e.description, e.options!);
            } else if (e.blockType == 'RADIO') {
              return _radio(e.title, e.description, e.options!);
              // return _checkbox();
            }

            return Container();
          }),
          _buttons()
        ]
      ),
    );
  }

  /*
   * WIDGETS
   */
  Widget _buttons() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: MyDoubleButtonRow(
        cancelText: 'Salir',
        cancelCallback: () {},
        acceptText: 'Guardar mapeo',
        acceptCallback: () {},
      ),
    );
  }

  /*
   * BLOCKS
   */
  Widget _instructions(String title, String description) {
    return InstructionsBlockWidget(
      title: title,
      description: description,
    );
  }

  Widget _shortText(String title, String description) {
    return ShortTextWidget(
      title: title,
      description: description,
    );
  }

  Widget _longText(String title, String description) {
    return LongTextWidget(
      title: title,
      description: description,
    );
  }

  Widget _map(String title) {
    return MapBlockWidget(
      title: title,
    );
  }

  Widget _select(String title, String description, Options options) {
    return SelectBlockWidget(
      title: title,
      description: description,
      choices: options.choices,
    );
  }

  Widget _radio(String title, String description, Options options) {
    return RadioBlockWidget(
      title: title,
      description: description,
      choices: options.choices,
    );
  }

  Widget _checkbox() {
    return const CheckBlockWidget();
  }
}