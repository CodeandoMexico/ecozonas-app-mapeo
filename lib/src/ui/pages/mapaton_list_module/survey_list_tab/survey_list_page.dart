import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../domain/models/survey_model.dart';
import '../../../utils/constants.dart';
import '../../../widgets/my_primary_elevated_button.dart';
import '../../../widgets/my_text_form_field.dart';
import '../../../widgets/no_data_widget.dart';
import '../mapaton_survey_provider.dart';

class SurveyListPage extends StatefulWidget {
  const SurveyListPage({super.key});

  @override
  State<SurveyListPage> createState() => _SurveyListPageState();
}

class _SurveyListPageState extends State<SurveyListPage> {
  late TextEditingController _controller;
  late MapatonSurveyProvider _provider;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _provider = Provider.of<MapatonSurveyProvider>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _search(),
        _listView(context)
      ],
    );
  }

  /*
   * WIDGETS
   */
  Widget _search() {
    return Padding(
      padding: const EdgeInsets.all(Constants.padding),
      child: MyTextFormField(
        controller: _controller,
        hintText: '${AppLocalizations.of(context)!.search}...',
        suffixIconData: Icons.search,
        onChanged: (value) => _provider.filterSurveyList(value),
      ),
    );
  }

  Widget _listView(BuildContext context) {
    return _provider.surveys.isNotEmpty ?
      Expanded(
        child: ListView.builder(
          itemCount: _provider.surveys.length,
          itemBuilder: (context, index) {
            return _listViewItem(context, _provider.surveys[index]);
          },
        ),
      ) : 
      NoDataWidget(
        callback: () {},
      );
  }

  Widget _listViewItem(BuildContext context, SurveyModel survey) {
    return Card(
      color: const Color(0xFFECECEC),
      margin: const EdgeInsets.symmetric(vertical: Constants.paddingSmall, horizontal: Constants.padding),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Color(0xFFB6B6B6), width: 1)
      ),
      child: Padding(
        padding: const EdgeInsets.all(Constants.padding),
        child: Row(
          children: [
            Expanded(
              child: Text(survey.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
            MyPrimaryElevatedButton(
              label: AppLocalizations.of(context)!.goToSurvey,
              onPressed: () async => await launchUrl(Uri.parse(survey.surveyUrl))
            )
          ],
        ),
      ),
    );
  }
}