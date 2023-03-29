// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginStore on LoginStoreBase, Store {
  late final _$isLoginLoadingAtom =
      Atom(name: 'LoginStoreBase.isLoginLoading', context: context);

  @override
  bool get isLoginLoading {
    _$isLoginLoadingAtom.reportRead();
    return super.isLoginLoading;
  }

  @override
  set isLoginLoading(bool value) {
    _$isLoginLoadingAtom.reportWrite(value, super.isLoginLoading, () {
      super.isLoginLoading = value;
    });
  }

  late final _$isGoogleSignInLoadingAtom =
      Atom(name: 'LoginStoreBase.isGoogleSignInLoading', context: context);

  @override
  bool get isGoogleSignInLoading {
    _$isGoogleSignInLoadingAtom.reportRead();
    return super.isGoogleSignInLoading;
  }

  @override
  set isGoogleSignInLoading(bool value) {
    _$isGoogleSignInLoadingAtom.reportWrite(value, super.isGoogleSignInLoading,
        () {
      super.isGoogleSignInLoading = value;
    });
  }

  late final _$isAlreadyAuthenticatedAsyncAction =
      AsyncAction('LoginStoreBase.isAlreadyAuthenticated', context: context);

  @override
  Future<bool> isAlreadyAuthenticated(BuildContext context) {
    return _$isAlreadyAuthenticatedAsyncAction
        .run(() => super.isAlreadyAuthenticated(context));
  }

  late final _$signInWithEmailPassAsyncAction =
      AsyncAction('LoginStoreBase.signInWithEmailPass', context: context);

  @override
  Future<void> signInWithEmailPass(
      BuildContext context, String email, String pass) {
    return _$signInWithEmailPassAsyncAction
        .run(() => super.signInWithEmailPass(context, email, pass));
  }

  late final _$googleAsyncAction =
      AsyncAction('LoginStoreBase.google', context: context);

  @override
  Future<void> google(BuildContext context) {
    return _$googleAsyncAction.run(() => super.google(context));
  }

  late final _$signOutAsyncAction =
      AsyncAction('LoginStoreBase.signOut', context: context);

  @override
  Future<void> signOut(BuildContext context) {
    return _$signOutAsyncAction.run(() => super.signOut(context));
  }

  @override
  String toString() {
    return '''
isLoginLoading: ${isLoginLoading},
isGoogleSignInLoading: ${isGoogleSignInLoading}
    ''';
  }
}
