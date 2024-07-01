import 'dart:io';

class Connectivity {
  static Future<bool> connectionAvailable() async {
    return await _checkConnection();
  }

  static Future<void> connectionAvailableCallback({
    required Function availableCallback,
    required Function unavailableCallback,
  }) async {
    bool connected = await _checkConnection();

    if (connected) {
      availableCallback();
    } else {
      unavailableCallback();
    }
  }

  static Future<bool> _checkConnection() async {
    bool connected = false;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        connected = true;
      }
    } on SocketException catch (_) {
      connected = false;
    }

    return connected;
  }
}