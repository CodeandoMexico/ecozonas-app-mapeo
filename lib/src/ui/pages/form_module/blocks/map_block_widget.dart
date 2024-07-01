import 'package:flutter/material.dart';

import '../view_map_page.dart';
import 'block_title_widget.dart';

class MapBlockWidget extends StatelessWidget {
  final String title;

  const MapBlockWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlockTitleWidget(title: title),
          const SizedBox(height: 8.0),
          Container(
            height: 230,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(  
              borderRadius: BorderRadius.circular(8.0)
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/map_placeholder.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, ViewMapPage.routeName),
                      child: const Text('Ver mapa')
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}