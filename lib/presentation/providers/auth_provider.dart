import 'package:flutter/material.dart';

import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repository.dart';

enum AuthStatus { unknown, authenticated, unauthenticated, loading }

class AuthProvider extends ChangeNotifier {
  AuthProvider(this._repository) {
    _init();
  }

  final AuthRepository _repository;

  AuthStatus _status = AuthStatus.unknown;
  UserModel? _user;
  String? _sentCode;

  AuthStatus get status => _status;
  UserModel? get user => _user;
  String? get sentCode => _sentCode;

  Future<void> _init() async {
    _status = AuthStatus.loading;
    notifyListeners();
    final existing = await _repository.getCurrentUser();
    if (existing != null) {
      _user = existing;
      _status = AuthStatus.authenticated;
    } else {
      _status = AuthStatus.unauthenticated;
    }
    notifyListeners();
  }

  Future<void> sendCode(String emailOrPhone) async {
    _status = AuthStatus.loading;
    notifyListeners();
    _sentCode = await _repository.sendVerificationCode(emailOrPhone);
    _status = AuthStatus.unauthenticated;
    notifyListeners();
  }

  Future<void> loginWithCode({
    required String emailOrPhone,
    required String code,
  }) async {
    _status = AuthStatus.loading;
    notifyListeners();
    try {
      _user = await _repository.verifyCode(
        emailOrPhone: emailOrPhone,
        code: code,
      );
      _status = AuthStatus.authenticated;
    } catch (_) {
      _status = AuthStatus.unauthenticated;
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<void> register({
    required String emailOrPhone,
    required String password,
  }) async {
    _status = AuthStatus.loading;
    notifyListeners();
    try {
      _user = await _repository.register(
        emailOrPhone: emailOrPhone,
        password: password,
      );
      _status = AuthStatus.authenticated;
    } finally {
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    _user = null;
    _status = AuthStatus.unauthenticated;
    notifyListeners();
  }
}


