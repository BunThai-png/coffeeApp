import 'dart:convert';

import 'package:flutter/material.dart';

class Helpers {
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  static String encodeJson(Map<String, dynamic> data) =>
      jsonEncode(data); // ignore: avoid_json_encode

  static Map<String, dynamic> decodeJson(String source) =>
      jsonDecode(source) as Map<String, dynamic>;
}



