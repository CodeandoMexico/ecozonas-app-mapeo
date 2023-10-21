import 'package:flutter/material.dart';

class InstructionsBlockWidget extends StatelessWidget {
  final String description;

  const InstructionsBlockWidget({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFBE5B0),
        borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.push_pin, color: Colors.red),
              SizedBox(width: 6.0),
              Text('Instrucciones', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            '\u2022 \t $description',
            style: const TextStyle(fontSize: 16)
          )
        ],
      ),
    );
  }
}