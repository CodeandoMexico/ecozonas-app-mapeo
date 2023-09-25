// import 'package:flutter/material.dart';

// import '../../../utils/constants.dart';
// import '../../../widgets/my_text_form_field.dart';

// class ContinueSessionPage extends StatelessWidget {
//   const ContinueSessionPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Padding(
//       padding: EdgeInsets.all(Constants.padding),
//       child: Column(
//         children: [
//           Text('Sesiones guardadas en este dispositivo'),
//           SizedBox(height: Constants.paddingHuge),
//           Text('Continuar como', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
//           SizedBox(height: Constants.padding),
//           MyTextFormField(
//             hintText: '#4763',
//             suffixIconData: Icons.arrow_forward_ios_outlined
//           ),
//           SizedBox(height: Constants.padding),
//           MyTextFormField(
//             hintText: '#3752',
//             suffixIconData: Icons.arrow_forward_ios_outlined
//           ),
//           SizedBox(height: Constants.paddingHuge),
//           Text('Administrar sesiones'),
//         ],
//       ),
//     );
//   }
// }