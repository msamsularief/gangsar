import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  FirebaseApiResource public() => FirebaseApiResource(
        dotenv.env['REALTIME_DATABASE_BASE_URL'].toString(),
      );
}

class FirebaseApiResource {
  final String baseUrl;

  FirebaseApiResource(this.baseUrl);

  Future<Map<String, dynamic>> get(String path) async {
    print("BASE_URL : $baseUrl");
    Uri uri = Uri.parse(baseUrl + path);

    try {
      final response = await http.get(uri);
      print(response.statusCode);

      if (response.statusCode < 200 && response.statusCode >= 300) {
        throw (response.statusCode);
      } else {
        print("RESPONSE BODY : ${response.body}");
        var data = json.decode(response.body) as Map<String, dynamic>;
        print('DATA : $data');
        return data;
      }
    } catch (error) {
      throw '$error';
    }
  }

  Future<dynamic> post(String path, {Map<String, dynamic>? body}) async {
    print("BASE_URL : $baseUrl");
    Uri uri = Uri.parse(baseUrl + path);

    try {
      final response = await http.post(uri, body: json.encode(body));
      print(response.statusCode);

      if (response.statusCode < 200 && response.statusCode >= 300) {
        throw (response.statusCode);
      } else {
        var data = json.decode(response.body) as Map<String, dynamic>;
        print('DATA : $data');
      }
    } catch (error) {
      throw '$error';
    }
  }
}
