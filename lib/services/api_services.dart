import 'package:chowchek/endpoints/end_points.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  final apiKey = dotenv.env['API_KEY'];

  Future<http.Response> fetchDataFromApi(String query) {
    final client = http.Client();
    return client.get(
      Uri.parse("${EndPoints.nutrientsURL}query=$query"),
      headers: {"X-Api-Key": apiKey ?? ""},
    );
  }
}
