import 'package:material_ui/material_ui.dart';
import 'package:location/location.dart';

import 'location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final Location _location;

  LocationRepositoryImpl(this._location);

  @override
  Future<bool> checkLocationPermission() async {
    final serviceEnabled = await _location.serviceEnabled() || await _location.requestService();
    if (!serviceEnabled) {
      debugPrint('Location is not enabled');
      return false;
    }

    var status = await _location.hasPermission();
    if (status == PermissionStatus.denied) {
      status = await _location.requestPermission();
    }

    // grantedLimited: el usuario solo permitió la ubicación aproximada.
    // deniedForever: el sistema ya no muestra el diálogo; el usuario tiene
    // que activarlo en Ajustes.
    final granted = status == PermissionStatus.granted || status == PermissionStatus.grantedLimited;
    if (!granted) {
      debugPrint('Location permission not granted: $status');
    }
    return granted;
  }

  @override
  Future<LocationData> getLocation() async {
    return await _location.getLocation();
  }
}