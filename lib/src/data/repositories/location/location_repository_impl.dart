import 'package:flutter/material.dart';
import 'package:location/location.dart';

import 'location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  static final Location _location = Location();

  @override
  Future<bool> checkLocationPermission() async {
    bool granted = true;

    var serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        debugPrint('Location is not enabled');
        granted = false;
      }
    }

    var permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        debugPrint('Location permission not granted');
        granted = false;
      }
    }

    return granted;
  }

  @override
  Future<LocationData> getLocation() async {
    return await _location.getLocation();
  }
}