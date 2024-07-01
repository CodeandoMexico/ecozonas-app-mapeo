import 'package:location/location.dart';

abstract class LocationRepository {
  Future<bool> checkLocationPermission();

  Future<LocationData> getLocation();
}