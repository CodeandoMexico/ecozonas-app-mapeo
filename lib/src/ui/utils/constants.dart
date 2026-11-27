
class ItemModel {
  ItemModel({
    required this.label,
    required this.value,
  });

  String label;
  String value;
}

class Constants {
  /*
   * MAP
   */
  /// Estilo del mapa (OpenFreeMap: mapas de OpenStreetMap, gratis y sin token).
  /// También se usa para descargar regiones sin conexión.
  static const mapStyleUrl = 'https://tiles.openfreemap.org/styles/liberty';
}
