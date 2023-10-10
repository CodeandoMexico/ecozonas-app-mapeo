import 'package:flutter/material.dart';

import 'block_title_widget.dart';

class CheckBlockWidget extends StatelessWidget {
  const CheckBlockWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BlockTitleWidget(
            title: '¿El edificio tiene algún biciestacionamiento?',
            description: 'Puede verse así:',
          ),
          Row(
            children: [
              Flexible(child: Image.asset('assets/images/map_placeholder.jpg')),
              const SizedBox(width: 8.0),
              Flexible(child: Image.asset('assets/images/map_placeholder.jpg')),
              const SizedBox(width: 8.0),
              Flexible(child: Image.asset('assets/images/map_placeholder.jpg')),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    const Text('Si'),
                    Checkbox(
                      value: false,
                      onChanged: (value) {}
                    )
                  ],
                ),
                Row(
                  children: [
                    const Text('No'),
                    Checkbox(
                      value: false,
                      onChanged: (value) {}
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}