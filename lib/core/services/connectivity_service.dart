import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  late final _connectivity = Connectivity();

  /// for getting stream internet status of the user
  Stream<bool> streamInternetStatus() async* {
    final state = _connectivity.onConnectivityChanged;

    await for (final s in state) {
      switch (s) {
        case ConnectivityResult.wifi:
        case ConnectivityResult.ethernet:
        case ConnectivityResult.mobile:
        case ConnectivityResult.vpn:
          yield true;
          break;
        case ConnectivityResult.bluetooth:
        case ConnectivityResult.none:
        case ConnectivityResult.other:
          yield false;
          break;
      }
    }
  }
}

/// for managing internet connection related services
final connectivity = ConnectivityService();
