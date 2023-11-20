import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  Future<http.Response> post(String url, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    return response;
  }
}
