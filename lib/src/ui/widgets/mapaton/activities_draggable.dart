import 'package:flutter/material.dart';

import '../../../domain/models/activity_model.dart';
import '../../../domain/models/task_model.dart';
import '../../utils/constants.dart';
import '../activity_item.dart';
import '../task_item.dart';

class ActivitiesDraggable extends StatelessWidget {
  ActivitiesDraggable({super.key});

  final DraggableScrollableController _draggableController = DraggableScrollableController();

  final activitiesTest = [
    ActivityModel(
      title: 'Disponibilidad de estacionamientos para bicicletas',
      detail: 'Analiza los bici-estacionamientos de la zona y elige sus características',
      percentage: 0.7,
      type: 'Entorno urbano',
      backgroundColor: const Color(0xFFC2D2E7),
      borderColor: const Color(0xFF6A94C6),
      iconData: Icons.pedal_bike
    ),
    ActivityModel(
      title: 'Calidad del servicio de recolección de basura',
      detail: 'Observa y anota las características del servicio de recolección de basura',
      percentage: 0.3,
      type: 'Calidad medioambiental',
      backgroundColor: const Color(0xFFD8E9D4),
      borderColor: const Color(0xFFA8D29E),
      iconData: Icons.pedal_bike
    ),
    ActivityModel(
      title: 'Mapeo de estacios públicos',
      detail: 'Analiza la zona, ubica las paradas formales e informales del transporte público',
      percentage: 1,
      type: 'Entorno urbano',
      backgroundColor: const Color(0xFFC2D2E7),
      borderColor: const Color(0xFF6A94C6),
      iconData: Icons.pedal_bike
    ),
  ];

  final tasksTest = [
    TaskModel(
      title: 'Biciestacionamiento (Hospital San Gabriel)',
      detail: 'Ve al edificio y evalúa si tiene algún estacionamiento para bicicletas',
      percentage: 0.3,
      type: 'Disponibilidad de estacionamiento',
    ),
    TaskModel(
      title: 'Biciestacionamiento (Secretaría Municipal)',
      detail: 'Ve al edificio y evalúa si tiene algún estacionamiento para bicicletas',
      percentage: 0.3,
      type: 'Disponibilidad de estacionamiento',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final pageController = PageController(initialPage: 0);

    return DraggableScrollableSheet(
      controller: _draggableController,
      minChildSize: 0,
      initialChildSize: 0,
      maxChildSize: 0.9,
      snap: true,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Constants.borderRadius),
              topRight: Radius.circular(Constants.borderRadius),
            )
          ),
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: _searchTextField(),
                ),
              ),
              SliverFillRemaining(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  children: [
                    _page1(pageController),
                    _page2(pageController),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /*
   * WIDGETS
   */
  Widget _searchTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: 'Buscar actividad',
        suffixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50))
        )
      ),
    );
  }

  Widget _filters() {
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          SizedBox(width: 16.0),
          Chip(label: Text('Todas las dimensiones')),
          SizedBox(width: 8.0),
          Chip(label: Text('Menor progreso')),
          SizedBox(width: 8.0),
          Chip(label: Text('Mostrar completadas')),
          SizedBox(width: 16.0),
        ],
      ),
    );
  }

  Widget _page1(PageController pageController) {
    return Column(
      children: [
        _filters(),
        Expanded(
          child: ListView(
            children: activitiesTest.map((e) {
              return ActivityItem(
                activity: e,
                callback: () => _animateToPage(pageController, 1),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _page2(PageController pageController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => _animateToPage(pageController, 0),
                child: const Icon(Icons.arrow_back)
              ),
              const SizedBox(width: 8.0),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue
                ),
                child: const Icon(Icons.pedal_bike, size: 20)
              ),
              const SizedBox(width: 8.0),
              const Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Disponibilidad de estacionamientos para bicicletas',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Analiza los bici-estacionamientos de la zona y elige sus características',
                      style: TextStyle(fontSize: 12),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 16, top: 16),
          child: Text('Tareas', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: tasksTest.length,
            itemBuilder: (context, index) {
              return TaskItem(
                task: tasksTest[index]
              );
            },
          ),
        )
      ],
    );
  }

  /*
   * METHODS
   */
  void animateDraggable(bool isShowing) {
    _draggableController.animateTo(
      !isShowing ? 0.9 : 0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease
    );
  }
  
  void _animateToPage(PageController pageController, int page) {
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease
    );
  }
}