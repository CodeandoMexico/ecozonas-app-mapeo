import 'package:flutter/material.dart';

import 'src/data/preferences/user_preferences.dart';
import 'src/ui/pages/pages.dart';
import 'src/ui/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await UserPreferences.initPrefs();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: myTheme,
      home: const LoginTabPage(),
      routes: {
        NewSessionPage.routeName: (_) => const NewSessionPage(),
        NewIdPage.routeName: (_) => const NewIdPage(),
        MapatonListPage.routeName: (_) => const MapatonListPage(),
        MapatonDetailsPage.routeName: (_) => const MapatonDetailsPage(),
        MapatonMapPage.routeName: (_) => const MapatonMapPage(),
        FormPage.routeName: (_) => const FormPage(),
        ViewMapPage.routeName: (_) => const ViewMapPage(),
        UpdateMapPage.routeName: (_) => const UpdateMapPage(),
        MapatonMainPage.routeName: (_) => const MapatonMainPage(),
      },
    );
  }
}