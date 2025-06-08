import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NetworkNotifier extends StateNotifier<bool> {
  NetworkNotifier() : super(false) {
    isNetworkAvailable();
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      isNetworkAvailable();
    });
  }

  Future<void> _checkNetworkStatus() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        state = true;
      } else {
        state = false;
      }
    } on SocketException catch (_) {
      state = false;
    }
  }

  Future<bool> isNetworkAvailable() async {
    await _checkNetworkStatus();
    return state;
  }
}

final networkProvider = StateNotifierProvider<NetworkNotifier, bool>((ref) {
  return NetworkNotifier();
});