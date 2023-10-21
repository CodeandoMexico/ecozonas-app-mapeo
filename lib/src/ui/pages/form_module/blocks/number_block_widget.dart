// import 'package:flutter/material.dart';

// import 'block_title_widget.dart';

// class NumberBlockWidget extends StatelessWidget {
//   final String title;
//   final String description;

//   const NumberBlockWidget({super.key, required this.title, required this.description});

//   @override
//   Widget build(BuildContext context) {
//     final border = OutlineInputBorder(
//       borderRadius: BorderRadius.circular(10)
//     );

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           BlockTitleWidget(
//             title: title,
//             description: description,
//           ),
//           TextFormField(
//             decoration: InputDecoration(
//               border: border,
//               focusedBorder: border
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }