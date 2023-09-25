import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/activity_model.dart';
import '../activity_item.dart';

class ActivitiesCarousel extends StatelessWidget {
  const ActivitiesCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        ActivityItem(activity: ActivityModel(
          title: 'Disponibilidad de estacionamientos para bicicletas',
          detail: 'Analiza los bici-estacionamientos de la zona y elige sus características',
          percentage: 0.7,
          type: 'Entorno urbano',
          backgroundColor: const Color(0xFFC2D2E7),
          borderColor: const Color(0xFF6A94C6),
          iconData: Icons.pedal_bike
        )),
        ActivityItem(activity: ActivityModel(
          title: 'Calidad del servicio de recolección de basura',
          detail: 'Observa y anota las características del servicio de recolección de basura',
          percentage: 0.3,
          type: 'Calidad medioambiental',
          backgroundColor: const Color(0xFFD8E9D4),
          borderColor: const Color(0xFFA8D29E),
          iconData: Icons.pedal_bike
        ))
      ],
      options: CarouselOptions(
        enableInfiniteScroll: false,
        viewportFraction: 1
      )
    );
  }
}