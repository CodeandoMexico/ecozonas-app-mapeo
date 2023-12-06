import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'src/data/preferences/user_preferences.dart';
import 'src/ui/pages/mapaton_list_module/mapaton_survey_provider.dart';
import 'src/ui/pages/mapaton_map_module/bloc/bloc.dart';
import 'src/ui/pages/pages.dart';
import 'src/ui/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await UserPreferences.initPrefs();

  runApp(MultiBlocProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => MapatonSurveyProvider()),
      BlocProvider(create: (context) => MapatonBloc()),
    ],
    child: const MyApp())
  );
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String accessToken = 'sk.eyJ1Ijoib3NjYXJjbXgiLCJhIjoiY2xvOHk4eHI2MDUyNTJtcWY0cGNvYjd4NCJ9.MTaSSc-yq8sUpQXWCbhT9w';//String.fromEnvironment("ACCESS_TOKEN");
  
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
        MapatonTabsPage.routeName: (_) => const MapatonTabsPage(),
        MapatonOnboardingPage.routeName: (_) => const MapatonOnboardingPage(),
        MapatonMapPage.routeName: (_) => const MapatonMapPage(),
        FormPage.routeName: (_) => const FormPage(),
        ViewMapPage.routeName: (_) => const ViewMapPage(),
        UpdateMapPage.routeName: (_) => const UpdateMapPage(),
        MapatonMainPage.routeName: (_) => const MapatonMainPage(),
        ManageSessionsPage.routeName: (_) => const ManageSessionsPage(),
      },
    );
  }
}