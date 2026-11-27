/// Códigos de los datos sociodemográficos del perfil (género, rango de edad y
/// discapacidad).
///
/// Lo que se guarda (BD local y preferencias) y lo que se envía al API es
/// siempre el código (`MUJER`, `18_25`, `MOTRIZ`...). La etiqueta visible se
/// obtiene en la UI según el idioma con `getGenderOptions`, `getAgeRange` y
/// `getDisiability` (ver `ui/utils/utils.dart`).
///
/// Hasta la versión 25.03.13 la app guardaba la etiqueta traducida ("Mujer",
/// "Woman"...). Las funciones `normalize*` convierten esos valores antiguos en
/// código al leerlos, así que las sesiones creadas antes siguen funcionando.
class SociodemographicCodes {
  static const noAnswer = 'NO_CONTESTO';

  static const _genderCodes = {'MUJER', 'HOMBRE', 'NO_BINARIO', 'OTRO', noAnswer};
  static const _ageCodes = {'MENOS_18', '18_25', '26_35', '36_45', '46_55', '56_65', 'MAS_65', noAnswer};
  static const _disabilityCodes = {'NINGUNA', 'MOTRIZ', 'VISUAL', 'AUDITIVA', 'COGNITIVA', 'OTRA', noAnswer};

  // Etiquetas que se guardaban antes (español e inglés) y su código.
  static const _legacyGender = {
    'Mujer': 'MUJER', 'Woman': 'MUJER',
    'Hombre': 'HOMBRE', 'Man': 'HOMBRE',
    'No binario': 'NO_BINARIO', 'Nonbinary': 'NO_BINARIO',
    'Otro': 'OTRO', 'Other': 'OTRO',
    'Prefiero no contestar': noAnswer, 'I prefer not to answer': noAnswer,
  };
  static const _legacyAge = {
    'Menos de 18 años': 'MENOS_18', 'Under 18 years': 'MENOS_18',
    'Entre 18 y 25 años': '18_25', 'Between 18 and 25 years': '18_25',
    'Entre 26 y 35 años': '26_35', 'Between 26 and 35 years': '26_35',
    'Entre 36 y 45 años': '36_45', 'Between 36 and 45 years': '36_45',
    'Entre 46 y 55 años': '46_55', 'Between 46 and 55 years': '46_55',
    'Entre 56 y 65 años': '56_65', 'Between 56 and 65 years': '56_65',
    'Más de 65 años': 'MAS_65', 'More than 65 years': 'MAS_65',
    'Prefiero no contestar': noAnswer, 'I prefer not to answer': noAnswer,
  };
  static const _legacyDisability = {
    'Ninguna': 'NINGUNA', 'None': 'NINGUNA',
    'Motriz': 'MOTRIZ', 'Motor': 'MOTRIZ',
    'Visual': 'VISUAL',
    'Auditiva': 'AUDITIVA', 'Hearing': 'AUDITIVA',
    'Cognitiva': 'COGNITIVA', 'Cognitive': 'COGNITIVA',
    'Otra': 'OTRA', 'Other': 'OTRA',
    'Prefiero no contestar': noAnswer, 'I prefer not to answer': noAnswer,
  };

  static String normalizeGender(String value) => _normalize(value, _genderCodes, _legacyGender);
  static String normalizeAge(String value) => _normalize(value, _ageCodes, _legacyAge);
  static String normalizeDisability(String value) => _normalize(value, _disabilityCodes, _legacyDisability);

  /// Valor de discapacidad que se envía al API. El API no tiene opción
  /// "prefiero no contestar" para discapacidad; desde siempre se envía como
  /// `OTRA`.
  static String disabilityForApi(String code) => code == noAnswer ? 'OTRA' : code;

  static String _normalize(String value, Set<String> codes, Map<String, String> legacy) {
    if (codes.contains(value)) return value;
    return legacy[value] ?? noAnswer;
  }
}
