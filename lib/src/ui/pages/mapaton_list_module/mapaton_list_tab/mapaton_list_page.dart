import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/models/mapaton_model.dart';
import '../../../utils/constants.dart';
import '../../../widgets/my_primary_elevated_button.dart';
import '../../../widgets/my_text_form_field.dart';
import '../../../widgets/no_data_widget.dart';
import '../../mapaton_map_module/mapaton_map_page.dart';
import '../mapaton_survey_provider.dart';

class MapatonListPage extends StatefulWidget {
  const MapatonListPage({super.key});

  @override
  State<MapatonListPage> createState() => _MapatonListPageState();
}

class _MapatonListPageState extends State<MapatonListPage> {
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
        _listView()
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
        hintText: 'Buscar por estado, ciudad o colonia',
        suffixIconData: Icons.search,
        onChanged: (value) => _provider.filterMapatonList(value),
      ),
    );
  }

  Widget _listView() {
    return _provider.mapatons.isNotEmpty ?
      Expanded(
        child: ListView.builder(
          itemCount: _provider.mapatons.length,
          itemBuilder: (context, index) {
            return _listViewItem(context, _provider.mapatons[index]);
          },
        ),
      ) :
      const NoDataWidget();
  }

  Widget _listViewItem(BuildContext context, MapatonModel mapaton) {
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(mapaton.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Text(mapaton.locationText),
                  MyPrimaryElevatedButton(
                    label: 'Mapear',
                    onPressed: () => Navigator.pushNamed(context, MapatonMapPage.routeName, arguments: mapaton)
                  )
                ],
              ),
            ),
            Image.asset('assets/images/map_placeholder.jpg', height: 80)
          ],
        ),
      ),
    );
  }
}