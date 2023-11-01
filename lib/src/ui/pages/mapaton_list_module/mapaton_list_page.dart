import 'package:flutter/material.dart';

import '../../../domain/models/mapaton_model.dart';
import '../../theme/theme.dart';
import '../../utils/constants.dart';
import '../../widgets/my_app_bar.dart';
import '../../widgets/my_primary_elevated_button.dart';
import '../../widgets/my_text_form_field.dart';
import '../mapaton_map_module/mapaton_details_page.dart';

class MapatonListPage extends StatefulWidget {
  static const routeName = 'mapatonList';
  
  const MapatonListPage({super.key});

  @override
  State<MapatonListPage> createState() => _MapatonListPageState();
}

class _MapatonListPageState extends State<MapatonListPage> {
  List<Mapaton> _mapatons = [];
  List<Mapaton> _filteredMapatons = [];

  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: Text('Herramientas de diagnóstico'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Constants.padding),
        child: Column(
          children: [
            _search(),
            const SizedBox(height: Constants.padding),
            _listView(context)
          ],
        ),
      ),
      backgroundColor: myTheme.primaryColor,
    );
  }

  Widget _search() {
    return MyTextFormField(
      controller: _controller,
      hintText: 'Buscar por estado, ciudad o colonia',
      suffixIconData: Icons.search,
      onChanged: (value) {
        setState(() {
          _filteredMapatons = _mapatons.where((element) {
            return element.title.toLowerCase().contains(value.toLowerCase());
          }).toList();
        });
      },
    );
  }

  /*
   * WIDGETS
   */
  Widget _listView(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: _filteredMapatons.length,
        itemBuilder: (context, index) {
          return _listViewItem(context, _filteredMapatons[index]);
        },
      ),
    );
  }

  Widget _listViewItem(BuildContext context, Mapaton mapaton) {
    return Card(
      color: const Color(0xFFECECEC),
      margin: const EdgeInsets.symmetric(vertical: Constants.paddingSmall),
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
                    onPressed: () => Navigator.pushNamed(context, MapatonDetailsPage.routeName, arguments: mapaton)
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

  /*
   * METHODS
   */
  void _getData() async {
    final json = await DefaultAssetBundle.of(context).loadString("assets/json/mapaton_2.json");
    final data = mapatonModelFromJson(json);
    setState(() {
      _mapatons = data.mapatones;
      _filteredMapatons = _mapatons;
    });
  }
}