import '../database/local_storage.dart';
import '../models/user_model.dart';
import '../api/api_client.dart';
import '../../core/utils/helpers.dart';

class AuthService {
  AuthService({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  final ApiClient _apiClient;

  String? _lastCode;

  Future<String> sendVerificationCode(String emailOrPhone) async {
    return _apiClient.simulateRequest(() {
      _lastCode = '3112';
      // In a real app I would send SMS/Email. Here we just log.
      // ignore: avoid_print
      print('Mock verification code for $emailOrPhone: $_lastCode');
      return _lastCode!;
    });
  }

  Future<UserModel> verifyCode({
    required String emailOrPhone,
    required String code,
  }) async {
    return _apiClient.simulateRequest(() {
      if (code != '3112') {
        throw Exception('Invalid verification code');
      }
      final user = UserModel(
        id: emailOrPhone,
        emailOrPhone: emailOrPhone,
      );
      // fire and forget persistence
      LocalStorage.setString(
        LocalStorage.keyUser,
        Helpers.encodeJson(user.toJson()),
      );
      return user;
    });
  }

  Future<UserModel> register({
    required String emailOrPhone,
    required String password,
  }) async {
    return _apiClient.simulateRequest(() {
      final user = UserModel(
        id: emailOrPhone,
        emailOrPhone: emailOrPhone,
      );
      LocalStorage.setString(
        LocalStorage.keyUser,
        Helpers.encodeJson(user.toJson()),
      );
      // password is ignored in this mock implementation.
      return user;
    });
  }

  Future<UserModel?> getCurrentUser() async {
    final raw = await LocalStorage.getString(LocalStorage.keyUser);
    if (raw == null) return null;
    return UserModel.fromJson(Helpers.decodeJson(raw));
  }

  Future<void> logout() async {
    await LocalStorage.remove(LocalStorage.keyUser);
  }
}