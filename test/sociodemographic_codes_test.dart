import 'package:ecozonas/src/domain/models/sociodemographic_codes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('normalize', () {
    test('deja igual los códigos', () {
      expect(SociodemographicCodes.normalizeGender('MUJER'), 'MUJER');
      expect(SociodemographicCodes.normalizeAge('18_25'), '18_25');
      expect(SociodemographicCodes.normalizeDisability('OTRA'), 'OTRA');
      expect(SociodemographicCodes.normalizeDisability('NO_CONTESTO'), 'NO_CONTESTO');
    });

    test('convierte las etiquetas que se guardaban antes, en español e inglés', () {
      expect(SociodemographicCodes.normalizeGender('Mujer'), 'MUJER');
      expect(SociodemographicCodes.normalizeGender('Woman'), 'MUJER');
      expect(SociodemographicCodes.normalizeAge('Más de 65 años'), 'MAS_65');
      expect(SociodemographicCodes.normalizeAge('Between 26 and 35 years'), '26_35');
      expect(SociodemographicCodes.normalizeDisability('Auditiva'), 'AUDITIVA');
      expect(SociodemographicCodes.normalizeDisability('Hearing'), 'AUDITIVA');
    });

    test('"Other" depende del campo: OTRO en género, OTRA en discapacidad', () {
      expect(SociodemographicCodes.normalizeGender('Other'), 'OTRO');
      expect(SociodemographicCodes.normalizeDisability('Other'), 'OTRA');
    });

    test('"Prefiero no contestar" en discapacidad ya no se confunde con "Otra"', () {
      expect(SociodemographicCodes.normalizeDisability('Prefiero no contestar'), 'NO_CONTESTO');
      expect(SociodemographicCodes.normalizeDisability('I prefer not to answer'), 'NO_CONTESTO');
    });

    test('un valor desconocido se trata como "prefiero no contestar"', () {
      expect(SociodemographicCodes.normalizeGender('???'), SociodemographicCodes.noAnswer);
    });
  });

  test('al API, "prefiero no contestar" en discapacidad se envía como OTRA', () {
    expect(SociodemographicCodes.disabilityForApi('NO_CONTESTO'), 'OTRA');
    expect(SociodemographicCodes.disabilityForApi('MOTRIZ'), 'MOTRIZ');
  });
}
