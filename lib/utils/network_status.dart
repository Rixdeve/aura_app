import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:io';

class NetworkStatusNotifier extends ValueNotifier<String> {
  NetworkStatusNotifier() : super("Checking...") {
    _init();
  }

  void _init() async {
    value = await _checkStatus();

    Connectivity().onConnectivityChanged.listen((_) async {
      value = await _checkStatus();
    });
  }

  Future<String> _checkStatus() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return "No Internet";
    }

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return connectivityResult == ConnectivityResult.mobile
            ? "Connected via Mobile Data"
            : "Connected via Wi-Fi";
      }
    } catch (_) {
      return "No Internet";
    }

    return "No Internet";
  }
}
