// import 'package:flutter/material.dart';

// import 'continue_session_module/continue_session_page.dart';
// import 'new_session_module/new_session_page.dart';

// class LoginPage extends StatelessWidget {
//   static const routeName = 'login';

//   const LoginPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: _appBar(),
//         body: _body(),
//       )
//     );
//   }

//   /*
//    * WIDGETS
//    */
//   AppBar _appBar() {
//     return AppBar(
//       bottom: const TabBar(
//         indicatorColor: Colors.white,
//         labelColor: Colors.black,
//         tabs: [
//           Tab(text: 'Nueva sesión'),
//           Tab(text: 'Continuar sesión'),
//         ],
//       ),
//       toolbarHeight: 0,
//     );
//   }

//   Widget _body() {
//     return const TabBarView(
//       children: [
//         NewSessionPage(),
//         ContinueSessionPage(),
//       ],
//     );
//   }
// }