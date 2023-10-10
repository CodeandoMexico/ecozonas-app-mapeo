import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../domain/models/mapaton_model.dart';
import '../../../domain/models/new_mapaton_model.dart';
import '../../theme/theme.dart';
import '../../utils/constants.dart';
import '../../widgets/my_app_bar.dart';
import '../../widgets/my_primary_elevated_button.dart';
import '../../widgets/my_text_form_field.dart';
import 'mapaton_details_page.dart';

class MapatonListPage extends StatelessWidget {
  static const routeName = 'mapatonList';
  
  const MapatonListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: Text('Mapatones'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Constants.padding),
        child: Column(
          children: [
            MyTextFormField(
              controller: TextEditingController(),
              hintText: 'Buscar por estado, ciudad o colonia',
              suffixIconData: Icons.search,
            ),
            const SizedBox(height: Constants.padding),
            _listView(context)
          ],
        ),
      ),
      backgroundColor: myTheme.primaryColor,
    );
  }

  /*
   * WIDGETS
   */
  Widget _listView(BuildContext context) {
    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString("assets/json/mapaton.json"),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.hasData) {
          final data = newMapatonModelFromJson(snapshot.data!);

          return Expanded(
            child: ListView.builder(
              itemCount: data.mapatones.length,
              itemBuilder: (context, index) {
                return _listViewItem(context, data.mapatones[index]);
              },
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget _listViewItem(BuildContext context, Mapatone mapaton) {
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
                    label: 'Descargar',
                    fullWidth: false,
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
}