// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// import '../../../../data/preferences/user_preferences.dart';
// import '../../../../data/repositories/db/mapaton/mapaton_repository_impl.dart';
// import '../../../../domain/models/db/mapaton_db_model.dart';
// import '../../../../domain/models/mapaton_model.dart';
// import '../../../../domain/use_cases/db/mapaton_use_case.dart';
// import '../../../utils/constants.dart';
// import '../../../widgets/my_primary_elevated_button.dart';
// import '../../../widgets/my_text_form_field.dart';
// import '../../../widgets/no_data_widget.dart';
// import '../../mapaton_map_module/mapaton_map_page.dart';
// import '../mapaton_survey_provider.dart';

// class MapatonListPage extends StatefulWidget {
//   const MapatonListPage({super.key});

//   @override
//   State<MapatonListPage> createState() => _MapatonListPageState();
// }

// class _MapatonListPageState extends State<MapatonListPage> {
//   late TextEditingController _controller;
//   late MapatonSurveyProvider _provider;

//   @override
//   void initState() {
//     _controller = TextEditingController();
//     super.initState();
//   }

//   @override
//   void didChangeDependencies() {
//     _provider = Provider.of<MapatonSurveyProvider>(context);
//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         _search(),
//         _listView()
//       ],
//     );
//   }

//   /*
//    * WIDGETS
//    */
//   Widget _search() {
//     return Padding(
//       padding: const EdgeInsets.all(Constants.padding),
//       child: MyTextFormField(
//         controller: _controller,
//         hintText: AppLocalizations.of(context)!.searchBy,
//         suffixIconData: Icons.search,
//         onChanged: (value) => _provider.filterMapatonList(value),
//       ),
//     );
//   }

//   Widget _listView() {
//     return _provider.mapatons.isNotEmpty ?
//       Expanded(
//         child: ListView.builder(
//           itemCount: _provider.mapatons.length,
//           itemBuilder: (context, index) {
//             return _listViewItem(context, _provider.mapatons[index]);
//           },
//         ),
//       ) :
//       NoDataWidget(
//         callback: () {},
//       );
//   }

//   Widget _listViewItem(BuildContext context, MapatonModel mapaton) {
//     return Card(
//       color: const Color(0xFFECECEC),
//       margin: const EdgeInsets.symmetric(vertical: Constants.paddingSmall, horizontal: Constants.padding),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8),
//         side: const BorderSide(color: Color(0xFFB6B6B6), width: 1)
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(Constants.padding),
//         child: Row(
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(mapaton.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//                   Text(mapaton.locationText),
//                   MyPrimaryElevatedButton(
//                     label: AppLocalizations.of(context)!.mapOut,
//                     onPressed: () async {
//                       await _goToMapaton(mapaton, context);
//                     }
//                   )
//                 ],
//               ),
//             ),
//             Image.asset('assets/images/map_placeholder.jpg', height: 80)
//           ],
//         ),
//       ),
//     );
//   }

//   /*
//    * METHODS
//    */
//   Future<void> _goToMapaton(MapatonModel mapaton, BuildContext context) async {
//     final prefs = UserPreferences();
//     final mapper = prefs.getMapper;
    
//     final useCase = MapatonUseCase(MapatonRepositoryImpl());
//     final m = await useCase.getMapatonsByUuidAndMapper(mapaton.uuid, mapper!.id.toString());
    
//     if (m == null) {
//       final id = await useCase.addMapaton(MapatonDbModel(
//         uuid: mapaton.uuid,
//         dateTime: DateTime.now(),
//         mapperId: mapper.id,
//         mapperGender: mapper.sociodemographicData.gender,
//         mapperAge: mapper.sociodemographicData.ageRange,
//         mapperDisability: mapper.sociodemographicData.disability,
//       ));
//       prefs.setMapatonDbId = id;
//     } else {
//       prefs.setMapatonDbId = m.id;
//     }
    
//     if (context.mounted) {
//       Navigator.pushNamed(context, MapatonMapPage.routeName, arguments: mapaton);
//     }
//   }
// }