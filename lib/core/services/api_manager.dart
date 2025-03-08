import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:linkai/core/utils/api_constants.dart';

class ApiManager {
  const ApiManager();

  Future<Map<String, dynamic>> post(Map<String, dynamic> data, String endPoint) async {
    final http.Request request = http.Request('POST', Uri.parse('${ApiConstants.baseURL}$endPoint'));

    request.headers.addAll({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    request.body = json.encode(data);

    final http.StreamedResponse response = await request.send();

    return json.decode(await response.stream.bytesToString());
  }
}
