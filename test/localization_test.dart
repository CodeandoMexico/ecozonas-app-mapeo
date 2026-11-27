import 'dart:convert';
import 'dart:io';

import 'package:ecozonas/l10n/app_localizations.dart';
import 'package:ecozonas/main.dart' show appLocalizationsDelegates;
import 'package:ecozonas/src/ui/utils/utils.dart' as utils;
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

/// Monta la app en [locale] y devuelve un BuildContext dentro de ella.
Future<BuildContext> pumpWithLocale(WidgetTester tester, Locale locale) async {
  late BuildContext context;
  await tester.pumpWidget(MaterialApp(
    locale: locale,
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: appLocalizationsDelegates,
    home: Builder(builder: (c) {
      context = c;
      return const SizedBox();
    }),
  ));
  return context;
}

void main() {
  test('los .arb de todos los idiomas tienen las mismas claves', () {
    Set<String> keys(String lang) {
      final arb = jsonDecode(File('lib/l10n/app_$lang.arb').readAsStringSync()) as Map<String, dynamic>;
      return arb.keys.where((k) => !k.startsWith('@')).toSet();
    }

    final template = keys('en');
    for (final lang in AppLocalizations.supportedLocales.map((l) => l.languageCode)) {
      expect(keys(lang), template, reason: 'app_$lang.arb');
    }
  });

  test('objectCount usa el plural de cada idioma', () {
    final es = lookupAppLocalizations(const Locale('es'));
    final en = lookupAppLocalizations(const Locale('en'));
    expect(es.objectCount(0), 'No hay objetos mapeados por enviar');
    expect(es.objectCount(1), 'Hay 1 objeto mapeado por enviar');
    expect(es.objectCount(3), 'Hay 3 objetos mapeados por enviar');
    expect(en.objectCount(1), 'There is 1 mapped object to be submitted');
    expect(en.objectCount(3), 'There are 3 mapped objects to be submitted');
  });

  group('localized', () {
    testWidgets('en inglés usa el texto en inglés', (tester) async {
      final context = await pumpWithLocale(tester, const Locale('en'));
      expect(utils.localized(context, es: 'Parque', en: 'Park'), 'Park');
    });

    testWidgets('en inglés sin traducción usa el español', (tester) async {
      final context = await pumpWithLocale(tester, const Locale('en'));
      expect(utils.localized(context, es: 'Parque', en: ''), 'Parque');
      expect(utils.localized(context, es: 'Parque'), 'Parque');
    });

    testWidgets('en español usa el español', (tester) async {
      final context = await pumpWithLocale(tester, const Locale('es'));
      expect(utils.localized(context, es: 'Parque', en: 'Park'), 'Parque');
    });
  });
}
