import 'package:ecozonas/src/ui/widgets/my_primary_elevated_button.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/mapaton_model.dart';
import '../../theme/theme.dart';
import '../../utils/constants.dart';
import '../../widgets/my_app_bar.dart';
import '../../widgets/my_text_form_field.dart';
import 'mapaton_details_page.dart';

class MapatonListPage extends StatelessWidget {
  static const routeName = 'mapatonList';
  
  MapatonListPage({super.key});

  final mapatons = [
    MapatonModel(name: 'La Metalera', address: 'Hermosillo, Sonora'),
    MapatonModel(name: 'Jardines de San Miguel', address: 'León, Guanajuato'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Mapatones',
        iconData: Icons.map,
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
            _listView()
          ],
        ),
      ),
      backgroundColor: myTheme.primaryColor,
    );
  }

  /*
   * WIDGETS
   */
  Widget _listView() {
    return Expanded(
      child: ListView.builder(
        itemCount: mapatons.length,
        itemBuilder: (context, index) {
          return _listViewItem(context, index);
        },
      ),
    );
  }

  Widget _listViewItem(BuildContext context, int index) {
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
                  Text(mapatons[index].name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Text(mapatons[index].address),
                  MyPrimaryElevatedButton(
                    label: 'Descargar',
                    fullWidth: false,
                    onPressed: () => Navigator.pushNamed(context, MapatonDetailsPage.routeName)
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

  // Widget _listViewItem(BuildContext context, int index) {
  //   return Card(
  //     margin: const EdgeInsets.symmetric(vertical: Constants.paddingSmall),
  //     child: Padding(
  //       padding: const EdgeInsets.all(Constants.paddingSmall),
  //       child: Column(
  //         children: [
  //           Container(
  //             height: 80,
  //             color: Colors.grey.shade300,
  //           ),
  //           Row(
  //             children: [
  //               Expanded(
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(mapatons[index].name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
  //                     Text(mapatons[index].address),
  //                   ],
  //                 ),
  //               ),
  //               ElevatedButton.icon(
  //                 onPressed: () {
  //                   Navigator.pushNamed(context, MapatonDetailsPage.routeName);
  //                 },
  //                 icon: const Icon(Icons.download, color: Colors.white),
  //                 label: const Text('Descargar', style: TextStyle(color: Colors.white))
  //               )
  //             ],
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
}