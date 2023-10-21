import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/mapaton_post_model.dart';

class UserPreferences {
  static late SharedPreferences _prefs;

  static Future initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  String? get getToken {
    return _prefs.getString('token');
  }

  set setToken(String? token) {
    if (token != null) {
      _prefs.setString('token', token);
    } else {
      _prefs.remove('token');
    }
  }

  Mapper? get getMapper {
    if (_prefs.containsKey('mapper') && _prefs.getString('mapper') != null) {
      return Mapper.fromJson(json.decode(_prefs.getString('mapper')!));
    } else {
      return null;
    }
  }

  set setMapper(Mapper? mapper) {
    if (mapper != null) {
      _prefs.setString('mapper', json.encode(mapper.toJson()));
    } else {
      _prefs.remove('mapper');
    }
  }

  LatLng? get getActivityLocation {
    if (_prefs.containsKey('activity_location') && _prefs.getString('activity_location') != null) {
      final latLng = json.decode(_prefs.getString('activity_location')!);
      return LatLng(latLng[0], latLng[1]);
    } else {
      return null;
    }
  }

  set setActivityLocation(LatLng? location) {
    if (location != null) {
      _prefs.setString('activity_location', json.encode(location.toJson()));
    } else {
      _prefs.remove('activity_location');
    }
  }

  int? get getMapatonId {
    if (_prefs.containsKey('mapaton_id') && _prefs.getInt('mapaton_id') != null) {
      return _prefs.getInt('mapaton_id');
    } else {
      return null;
    }
  }

  set setMapatonId(int? mapatonId) {
    if (mapatonId != null) {
      _prefs.setInt('mapaton_id', mapatonId);
    } else {
      _prefs.remove('mapaton_id');
    }
  }
}