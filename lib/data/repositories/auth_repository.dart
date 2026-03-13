import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthRepository {
  AuthRepository(this._service);

  final AuthService _service;

  Future<String> sendVerificationCode(String emailOrPhone) {
    return _service.sendVerificationCode(emailOrPhone);
  }

  Future<UserModel> verifyCode({
    required String emailOrPhone,
    required String code,
  }) {
    return _service.verifyCode(emailOrPhone: emailOrPhone, code: code);
  }

  Future<UserModel> register({
    required String emailOrPhone,
    required String password,
  }) {
    return _service.register(emailOrPhone: emailOrPhone, password: password);
  }

  Future<UserModel?> getCurrentUser() {
    return _service.getCurrentUser();
  }

  Future<void> logout() {
    return _service.logout();
  }
}


