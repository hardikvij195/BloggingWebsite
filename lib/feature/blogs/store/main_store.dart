// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:mobx/mobx.dart';

import '../../../core/services/connectivity_service.dart';

part 'main_store.g.dart';

class MainStore = _MainStore with _$MainStore;

abstract class _MainStore with Store {
  /// for getting internet connection status
  @observable
  bool isInternetOn = true;

  StreamSubscription<bool>? _internetSub;

  /// for subscribing stream status of internet
  @action
  void initInternetStream() {
    _internetSub?.cancel();
    _internetSub = connectivity.streamInternetStatus().listen((event) {
      isInternetOn = event;
    });
  }
}
