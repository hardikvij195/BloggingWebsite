// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MainStore on _MainStore, Store {
  late final _$isInternetOnAtom =
      Atom(name: '_MainStore.isInternetOn', context: context);

  @override
  bool get isInternetOn {
    _$isInternetOnAtom.reportRead();
    return super.isInternetOn;
  }

  @override
  set isInternetOn(bool value) {
    _$isInternetOnAtom.reportWrite(value, super.isInternetOn, () {
      super.isInternetOn = value;
    });
  }

  late final _$_MainStoreActionController =
      ActionController(name: '_MainStore', context: context);

  @override
  void initInternetStream() {
    final _$actionInfo = _$_MainStoreActionController.startAction(
        name: '_MainStore.initInternetStream');
    try {
      return super.initInternetStream();
    } finally {
      _$_MainStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isInternetOn: ${isInternetOn}
    ''';
  }
}
