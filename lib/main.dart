import 'package:cupertino_ui/cupertino_ui.dart' show GlobalCupertinoLocalizations;
import 'package:ecozonas/l10n/app_localizations.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart' show GlobalWidgetsLocalizations;
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import 'src/data/preferences/user_preferences.dart';
import 'src/ui/pages/mapaton_list_module/mapaton_survey_provider.dart';
import 'src/ui/pages/mapaton_map_module/bloc/bloc.dart';
import 'src/ui/pages/pages.dart';
import 'src/ui/theme/theme.dart';

/// Delegados de localización de la app. No se usa
/// AppLocalizations.localizationsDelegates porque gen-l10n todavía incluye
/// los delegados de flutter_localizations, que no sirven con material_ui.
const appLocalizationsDelegates = <LocalizationsDelegate<dynamic>>[
  AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await UserPreferences.initPrefs();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((value) {
    return runApp(MultiBlocProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MapatonSurveyProvider()),
        BlocProvider(create: (context) => MapatonBloc()),
      ],
      child: const MyApp())
    );
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void _changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EcoZonas',
      locale: _locale,
      localizationsDelegates: appLocalizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: myTheme,
      home: LanguagePage(
        localeCallback: (value) {
          _changeLanguage(value);
        },
      ),
      routes: {
        LoginTabPage.routeName: (_) => const LoginTabPage(),
        NewSessionPage.routeName: (_) => const NewSessionPage(),
        NewIdPage.routeName: (_) => const NewIdPage(),
        MapatonTabsPage.routeName: (_) => const MapatonTabsPage(),
        MapatonOnboardingPage.routeName: (_) => const MapatonOnboardingPage(),
        MapatonMapPage.routeName: (_) => const MapatonMapPage(),
        FormPage.routeName: (_) => const FormPage(),
        UpdateMapPage.routeName: (_) => const UpdateMapPage(),
        MapatonMainPage.routeName: (_) => const MapatonMainPage(),
        ManageSessionsPage.routeName: (_) => const ManageSessionsPage(),
        MapatonTextOnboardingPage.routeName: (_) => const MapatonTextOnboardingPage(),
        MapatonMoreInfoPage.routeName: (_) => const MapatonMoreInfoPage(),
      },
    );
  }
}