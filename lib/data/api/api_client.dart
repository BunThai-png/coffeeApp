import 'dart:async';

/// Simple fake API client that simulates network delay.
class ApiClient {
  Future<T> simulateRequest<T>(T Function() body) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return body();
  }
}
 