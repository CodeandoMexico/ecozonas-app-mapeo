import 'package:ecozonas/src/ui/widgets/my_primary_elevated_button.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/new_mapaton_model.dart';
import '../../styles/my_button_styles.dart';
import '../../utils/utils.dart' as utils;
import '../../widgets/activity_item.dart';
import '../../widgets/mapaton/activities_draggable.dart';

class MapatonMapPage extends StatelessWidget {
  static String routeName = 'mapatonMap';

  MapatonMapPage({super.key});
  
  final ActivitiesDraggable _activitiesDraggable = ActivitiesDraggable();

  @override
  Widget build(BuildContext context) {
    final mapaton = ModalRoute.of(context)!.settings.arguments as Mapatone;

    _activitiesDraggable.setActivities(mapaton);

    return Scaffold(
      appBar: _appBar(mapaton),
      body: Stack(
        children: [
          _map(),
          // _listButton(),
          // _carousel(mapaton),
          _startButton(),
          _draggableScrollableSheet()
        ],
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  /*
   * APP BAR
   */
  AppBar _appBar(Mapatone mapaton) {
    return AppBar(
      title: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(mapaton.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(mapaton.locationText, style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
          Column(
            children: [
              const Text('Última actualización', style: TextStyle(fontSize: 12)),
              const SizedBox(height: 4.0),
              Text(utils.formatDate(mapaton.updatedAt), style: const TextStyle(fontSize: 12)),
            ],
          )
        ],
      ),
      elevation: 0,
      iconTheme: const IconThemeData(
        color: Colors.black
      ),
    );
  }

  /*
   * WIDGETS
   */
  Widget _map() {
    return Positioned.fill(
      child: Image.asset(
        'assets/images/map_placeholder.jpg',
        fit: BoxFit.fitHeight,
      )
    );
  }

  // Widget _listButton() {
  //   bool isShowing = false;

  //   return Positioned(
  //     top: 16,
  //     left: 16,
  //     child: GestureDetector(
  //       onTap: () {
  //         _activitiesDraggable.animateDraggable(isShowing);
  //         isShowing = !isShowing;
  //       },
  //       child: Container(
  //         padding: const EdgeInsets.all(6),
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(8),
  //           border: Border.all(color: Colors.black),
  //         ),
  //         child: const Icon(Icons.list),
  //       ),
  //     )
  //   );
  // }

  Widget _carousel(Mapatone mapaton) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      height: 190,
      // child: ActivitiesCarousel()
      // child: ActivityItem(activity: ActivityModel(
      //   title: 'Disponibilidad de estacionamientos para bicicletas',
      //   detail: 'Analiza los bici-estacionamientos de la zona y elige sus características',
      //   percentage: 0.7,
      //   type: 'Entorno urbano',
      //   backgroundColor: const Color(0xFFC2D2E7),
      //   borderColor: const Color(0xFF6A94C6),
      //   iconData: Icons.pedal_bike,
      // ), callback: () {
      //   _activitiesDraggable.animateDraggable(false);
      // })
      child: ActivityItem(activity: mapaton.activities[0], callback: () {
        _activitiesDraggable.animateDraggable(false);
      })
    );
  }

  Widget _startButton() {
    return Positioned(
      left: 16.0,
      right: 16.0,
      bottom: 16.0,
      child: MyPrimaryElevatedButton(
        label: 'Mapear aquí',
        onPressed: () {
          _activitiesDraggable.animateDraggable(false);
        },
      ),
    );
  }

  Widget _draggableScrollableSheet() {
    return Positioned.fill(
      child: _activitiesDraggable
    );
  }

  /*
   * BOTTOM NAVIGATION BAR
   */
  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
      selectedItemColor: Colors.black,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio'
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.checklist_sharp),
        //   label: 'Mis tareas'
        // ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined),
          label: 'Mi sesión'
        ),
      ],
    );
  }
}