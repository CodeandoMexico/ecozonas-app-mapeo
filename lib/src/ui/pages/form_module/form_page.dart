import 'package:flutter/material.dart';

import '../../../data/preferences/user_preferences.dart';
import '../../../data/repositories/db/activity/activity_repository_impl.dart';
import '../../../data/repositories/db/mapaton/mapaton_repository_impl.dart';
import '../../../domain/models/db/activity_db_model.dart';
import '../../../domain/models/mapaton_model.dart';
import '../../../domain/models/mapaton_post_model.dart';
import '../../../domain/use_cases/db/activity_use_case.dart';
import '../../../domain/use_cases/db/mapaton_use_case.dart';
import '../../theme/theme.dart';
import '../../widgets/my_app_bar.dart';
import '../../widgets/my_double_button_row.dart';
import '../../utils/utils.dart' as utils;
import 'blocks/blocks.dart';
import 'blocks/select_block_widget.dart';

class FormPage extends StatefulWidget {
  static String routeName = 'form';

  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  late MapatonPostModel _mapatonPost;

  @override
  void initState() {
    final prefs = UserPreferences();

    _mapatonPost = MapatonPostModel(
      mapaton: MapatonActivities(
        activities: []
      ),
      mapper: prefs.getMapper!
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final activity = ModalRoute.of(context)!.settings.arguments as Activity;
    _mapatonPost.mapaton.uuid = activity.mapatonUuid;

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
            if (e.blockType == 'INSTRUCTIONS') {
              return _instructions(e.title, e.description);
            } else if (e.blockType == 'SHORT_TEXT') {
              return _shortText(e);
            } else if (e.blockType == 'LONG_TEXT') {
              return _longText(e);
            } else if (e.blockType == 'NUMBER') {
              return e.isDecimal == true ? _decimalText(e) : _numberText(e);
            } else if (e.blockType == 'CHECKBOX') {
              return _checkbox(e);
            } else if (e.blockType == 'SELECT') {
              return _select(e);
            } else if (e.blockType == 'RADIO') {
              return _radio(e);
            } else if (e.blockType == 'PICTURE') {
              return _picture(e);
            }
            // if (e.blockType == 'POINT') {
            //   return _map(context, e.title);
            // }

            // return _checkboxImage();
            return Container();
          }),
          _buttons(activity)
        ]
      ),
    );
  }

  /*
   * WIDGETS
   */
  Widget _buttons(Activity activity) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: MyDoubleButtonRow(
        cancelText: 'Salir',
        cancelCallback: () => Navigator.pop(context),
        acceptText: 'Guardar mapeo',
        acceptCallback: () => _save(activity),
      ),
    );
  }

  /*
   * BLOCKS
   */
  Widget _instructions(String title, String description) {
    return InstructionsBlockWidget(
      description: description,
    );
  }

  Widget _shortText(Block block) {
    return TextBlockWidget(
      title: block.title,
      description: block.description,
      onChanged: (value) => block.value = value,
    );
  }

  Widget _longText(Block block) {
    return TextBlockWidget(
      title: block.title,
      description: block.description,
      maxLines: 8,
      onChanged: (value) => block.value = value,
    );
  }

  Widget _numberText(Block block) {
    return TextBlockWidget(
      title: block.title,
      description: block.description,
      textInputType: TextInputType.number,
      onChanged: (value) => block.value = value,
    );
  }

  Widget _decimalText(Block block) {
    return TextBlockWidget(
      title: block.title,
      description: block.description,
      textInputType: const TextInputType.numberWithOptions(decimal: true),
      onChanged: (value) => block.value = value,
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
      callback: (value) => block.value = value,
    );
  }

  Widget _select(Block block) {
    return SelectBlockWidget(
      title: block.title,
      description: block.description,
      choices: block.options!.choices,
      callback: (value) => block.value = value,
    );
  }

  Widget _radio(Block block) {
    return RadioBlockWidget(
      title: block.title,
      description: block.description,
      choices: block.options!.choices,
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
  void _save(Activity activity) async {
    for (var element in activity.blocks) {
      debugPrint(element.toString());
    }

    // return;

    final prefs = UserPreferences();

    final useCase = MapatonUseCase(MapatonRepositoryImpl());
    final m = await useCase.getMapatonsByUuidAndMapper(activity.mapatonUuid!, prefs.getMapper!.id.toString());

    double lat = prefs.getActivityLocation != null ? prefs.getActivityLocation!.latitude : 0;
    double lng = prefs.getActivityLocation != null ? prefs.getActivityLocation!.longitude : 0;

    final activityUseCase = ActivityUseCase(ActivityRepositoryImpl());
    final a = ActivityDbModel(
      mapatonId: m!.id!,
      uuid: activity.uuid,
      latitude: lat,
      longitude: lng,
      timestamp: utils.formatDate(DateTime.now(), strFormat: "yyyy-MM-dd HH:mm:ss"),
      blocks: blockListToJson(activity.blocks)
    );

    int id = await activityUseCase.addActivity(a);
    a.id = id;

    if (context.mounted) {
      Navigator.pop(context, a);
    }
  }
}