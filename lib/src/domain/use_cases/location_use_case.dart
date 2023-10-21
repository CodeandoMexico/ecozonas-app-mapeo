import 'package:location/location.dart';

import '../../data/repositories/location/location_repository_impl.dart';

class LocationUseCase {
  final LocationRepositoryImpl _repository;

  LocationUseCase(this._repository);

  Future<bool> checkLocationPermission() async {
    return _repository.checkLocationPermission();
  }

  Future<LocationData> getLocation() async {
    return _repository.getLocation();
  }
}