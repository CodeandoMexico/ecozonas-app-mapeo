import 'package:flutter/material.dart';

import 'src/ui/pages/pages.dart';
import 'src/ui/theme/theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: myTheme,
      home: const NewSessionPage(),
      // home: MapatonMapPage(),
      routes: {
        NewSessionPage.routeName: (_) => const NewSessionPage(),
        NewIdPage.routeName: (_) => const NewIdPage(),
        MapatonListPage.routeName: (_) => MapatonListPage(),
        MapatonDetailsPage.routeName: (_) => MapatonDetailsPage(),
        MapatonMapPage.routeName: (_) => MapatonMapPage(),
      },
    );
  }
}