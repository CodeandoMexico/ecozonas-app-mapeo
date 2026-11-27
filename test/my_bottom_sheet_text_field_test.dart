import 'package:ecozonas/src/ui/utils/constants.dart';
import 'package:ecozonas/src/ui/widgets/my_bottom_sheet_text_field.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  final options = [
    ItemModel(label: 'Mujer', value: 'MUJER'),
    ItemModel(label: 'Hombre', value: 'HOMBRE'),
    ItemModel(label: 'Prefiero no contestar', value: 'NO_CONTESTO'),
  ];

  Future<void> pump(WidgetTester tester, {String? initialValue, required void Function(String) callback}) {
    return tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: MyBottomSheetTextField(
          titleText: 'Género',
          options: options,
          initialValue: initialValue,
          callback: callback,
        ),
      ),
    ));
  }

  testWidgets('muestra la etiqueta del código inicial', (tester) async {
    await pump(tester, initialValue: 'NO_CONTESTO', callback: (_) {});
    expect(find.text('Prefiero no contestar'), findsOneWidget);
  });

  testWidgets('al elegir una opción devuelve su código, no la etiqueta', (tester) async {
    String? selected;
    await pump(tester, initialValue: 'NO_CONTESTO', callback: (value) => selected = value);

    await tester.tap(find.byType(TextFormField));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mujer').last);
    await tester.pumpAndSettle();

    expect(selected, 'MUJER');
    expect(find.text('Mujer'), findsOneWidget);
  });
}
