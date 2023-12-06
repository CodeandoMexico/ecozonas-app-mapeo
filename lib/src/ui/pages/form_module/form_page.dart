import 'package:flutter/material.dart';

import '../../../data/preferences/user_preferences.dart';
import '../../../data/repositories/db/activity/activity_repository_impl.dart';
import '../../../data/repositories/db/mapaton/mapaton_repository_impl.dart';
import '../../../domain/models/db/activity_db_model.dart';
import '../../../domain/models/mapaton_model.dart';
import '../../../domain/use_cases/db/activity_use_case.dart';
import '../../../domain/use_cases/db/mapaton_use_case.dart';
import '../../theme/theme.dart';
import '../../widgets/my_app_bar.dart';
import '../../widgets/my_double_button_row.dart';
import '../../utils/utils.dart' as utils;
import 'blocks/blocks.dart';
import 'blocks/select_block_widget.dart';

class FormPage extends StatelessWidget {
  static String routeName = 'form';

  const FormPage({super.key});

  @override
  Widget build(BuildContext context) {
    final activity = ModalRoute.of(context)!.settings.arguments as Activity;

    return Scaffold(
      appBar: _appBar(activity),
      body: _body(context, activity),
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

  Widget _body(BuildContext context, Activity activity) {
    return SingleChildScrollView(
      child:  Column(
        children: [
          ...activity.blocks.map((e) {
            e.value = null;
            if (e.blockType == 'instructions') {
              return _instructions(e.title, e.description);
            } else if (e.blockType == 'short_text') {
              return _shortText(e);
            } else if (e.blockType == 'long_text') {
              return _longText(e);
            } else if (e.blockType == 'number') {
              return _numberText(e);
            } else if (e.blockType == 'checkbox') {
              return _checkbox(e);
            } else if (e.blockType == 'select') {
              return _select(e);
            } else if (e.blockType == 'radio') {
              return _radio(e);
            } else if (e.blockType == 'picture') {
              return _picture(e);
            }
            // if (e.blockType == 'POINT') {
            //   return _map(context, e.title);
            // }

            // return _checkboxImage();
            return Container();
          }),
          _buttons(context, activity)
        ]
      ),
    );
  }

  /*
   * WIDGETS
   */
  Widget _buttons(BuildContext context, Activity activity) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: MyDoubleButtonRow(
        cancelText: 'Salir',
        cancelCallback: () => Navigator.pop(context),
        acceptText: 'Guardar mapeo',
        acceptCallback: () => _save(context, activity),
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

  Widget _shortText(Block block) {
    return TextBlockWidget(
      title: block.title,
      description: block.description,
      isRequired: block.isRequired,
      onChanged: (value) => block.value = value,
    );
  }

  Widget _longText(Block block) {
    return TextBlockWidget(
      title: block.title,
      description: block.description,
      maxLines: 8,
      isRequired: block.isRequired,
      onChanged: (value) => block.value = value,
    );
  }

  Widget _numberText(Block block) {
    return TextBlockWidget(
      title: block.title,
      description: block.description,
      textInputType: TextInputType.number,
      isRequired: block.isRequired,
      onChanged: (value) => block.value = int.parse(value),
    );
  }

  Widget _map(String title) {
    return MapBlockWidget(
      title: title,
    );
  }

  Widget _checkbox(Block block) {
    return CheckboxBlockWidget(
      title: block.title,
      description: block.description,
      choices: block.options!.choices,
      isRequired: block.isRequired,
      callback: (value) => block.value = value,
    );
  }

  Widget _select(Block block) {
    return SelectBlockWidget(
      title: block.title,
      description: block.description,
      choices: block.options!.choices,
      isRequired: block.isRequired,
      callback: (value) => block.value = value,
    );
  }

  Widget _radio(Block block) {
    return RadioBlockWidget(
      title: block.title,
      description: block.description,
      choices: block.options!.choices,
      isRequired: block.isRequired,
      callback: (value) => block.value = value,
    );
  }

  Widget _picture(Block block) {
    return PictureBlockWidget(
      title: block.title,
      description: block.description,
      callback: (value) => block.value = value,
    );
  }

  Widget _checkboxImage() {
    return const CheckBlockWidget();
  }

  /*
   * METHODS
   */
  void _save(BuildContext context, Activity activity) async {
    final mandatoryCount = activity.blocks.where((element) {
      debugPrint(element.toString());
      return element.isRequired && (element.value == null || (element.blockType == 'checkbox' && element.value.isEmpty));
    }).length;

    if (mandatoryCount > 0) {
      utils.showSnackBarError(context, 'Por favor, revise los campos obligatorios');
      return;
    }

    try {
      final prefs = UserPreferences();

      final useCase = MapatonUseCase(MapatonRepositoryImpl());
      final m = await useCase.getMapatonsByUuidAndMapper(activity.mapatonUuid!, prefs.getMapper!.id.toString());

      double lat = prefs.getActivityLocation != null ? prefs.getActivityLocation!.latitude : 0;
      double lng = prefs.getActivityLocation != null ? prefs.getActivityLocation!.longitude : 0;

      final activityUseCase = ActivityUseCase(ActivityRepositoryImpl());
      final a = ActivityDbModel(
        mapatonId: m!.id!,
        uuid: activity.uuid,
        name: activity.title,
        color: activity.category.color,
        borderColor: activity.category.borderColor!,
        latitude: lat,
        longitude: lng,
        timestamp: utils.formatDate(DateTime.now().toUtc(), strFormat: "yyyy-MM-dd HH:mm:ssZ"),
        blocks: blockListToJson(activity.blocks),
        categoryCode: activity.category.code
      );

      int id = await activityUseCase.addActivity(a);
      a.id = id;

      if (context.mounted) {
        Navigator.pop(context, a);
      }
    } catch (err) {
      if (context.mounted) {
        utils.showSnackBarError(context, err.toString());
      }
    }
  }
}