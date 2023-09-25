import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../../widgets/mapaton/activities_carousel.dart';
import '../../widgets/mapaton/activities_draggable.dart';

class MapatonMapPage extends StatelessWidget {
  static String routeName = 'mapatonMap';

  MapatonMapPage({super.key});
  
  final ActivitiesDraggable _activitiesDraggable = ActivitiesDraggable();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Stack(
        children: [
          _map(),
          _listButton(),
          _carousel(),
          _draggableScrollableSheet()
        ],
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  /*
   * APP BAR
   */
  AppBar _appBar() {
    return AppBar(
      title: const Row(
        children: [
          Icon(Icons.map),
          SizedBox(width: Constants.paddingSmall),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('La Metalera', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text('Hermosillo, Sonora', style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
          Column(
            children: [
              Text('Última actualización', style: TextStyle(fontSize: 12)),
              SizedBox(height: 4.0),
              Text('24/08/2023 7:20pm', style: TextStyle(fontSize: 12)),
            ],
          )
        ],
      ),
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

  Widget _listButton() {
    bool isShowing = false;

    return Positioned(
      top: 16,
      left: 16,
      child: GestureDetector(
        onTap: () {
          _activitiesDraggable.animateDraggable(isShowing);
          isShowing = !isShowing;
        },
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black),
          ),
          child: const Icon(Icons.list),
        ),
      )
    );
  }

  Widget _carousel() {
    return const Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      height: 190,
      child: ActivitiesCarousel()
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
        BottomNavigationBarItem(
          icon: Icon(Icons.checklist_sharp),
          label: 'Mis tareas'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined),
          label: 'Mi sesión'
        ),
      ],
    );
  }
}