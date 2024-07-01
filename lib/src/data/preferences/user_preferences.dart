import 'dart:convert';

import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/mapaton_post_model.dart';

class UserPreferences {
  static late SharedPreferences _prefs;

  static Future initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  final tokenKey = 'token';
  final mapperKey = 'mapper';
  final activityLocationKey = 'activity_location';
  final mapatonDbIdKey = 'mapaton_id';
  final onboardingTextShownIdsKey = 'onboarding_text_shown_ids';

  String? get getToken {
    return _prefs.getString(tokenKey);
  }

  set setToken(String? token) {
    if (token != null) {
      _prefs.setString(tokenKey, token);
    } else {
      _prefs.remove(tokenKey);
    }
  }

  Mapper? get getMapper {
    if (_prefs.containsKey(mapperKey) && _prefs.getString(mapperKey) != null) {
      return Mapper.fromJson(json.decode(_prefs.getString(mapperKey)!));
    } else {
      return null;
    }
  }

  set setMapper(Mapper? mapper) {
    if (mapper != null) {
      _prefs.setString(mapperKey, json.encode(mapper.toJson()));
    } else {
      _prefs.remove(mapperKey);
    }
  }

  LatLng? get getActivityLocation {
    if (_prefs.containsKey(activityLocationKey) && _prefs.getString(activityLocationKey) != null) {
      final latLng = json.decode(_prefs.getString(activityLocationKey)!);
      return LatLng(latLng[0], latLng[1]);
    } else {
      return null;
    }
  }

  set setActivityLocation(LatLng? location) {
    if (location != null) {
      _prefs.setString(activityLocationKey, json.encode(location.toJson()));
    } else {
      _prefs.remove(activityLocationKey);
    }
  }

  int? get getMapatonDbId {
    if (_prefs.containsKey(mapatonDbIdKey) && _prefs.getInt(mapatonDbIdKey) != null) {
      return _prefs.getInt(mapatonDbIdKey);
    } else {
      return null;
    }
  }

  set setMapatonDbId(int? mapatonId) {
    if (mapatonId != null) {
      _prefs.setInt(mapatonDbIdKey, mapatonId);
    } else {
      _prefs.remove(mapatonDbIdKey);
    }
  }

  String? get getOnboardingTextShownIds {
    if (_prefs.containsKey(onboardingTextShownIdsKey)) {
      return _prefs.getString(onboardingTextShownIdsKey)!;
    } else {
      return null;
    }
  }

  set setOnboardingTextShownIds(String onboardingTextShownIds) {
    _prefs.setString(onboardingTextShownIdsKey, onboardingTextShownIds);
  }
}