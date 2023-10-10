import 'package:flutter/material.dart';

class InstructionsBlockWidget extends StatelessWidget {
  final String title;
  final String description;

  const InstructionsBlockWidget({super.key, required this.title, required this.description});

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
          Row(
            children: [
              const Icon(Icons.push_pin, color: Colors.red),
              const SizedBox(width: 6.0),
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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