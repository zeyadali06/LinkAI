import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:linkai/core/utils/api_constants.dart';

@injectable
class ApiManager {
  const ApiManager();

  Future<Map<String, dynamic>> delete(String endPoint, {String? token}) async {
    final http.Request request = http.Request('DELETE', Uri.parse('${ApiConstants.baseURL}$endPoint'));

    request.headers.addAll({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'authorization': 'Bearer $token',
    });

    final http.StreamedResponse response = await request.send();

    return json.decode(await response.stream.bytesToString());
  }

  Future<Map<String, dynamic>> patch(Map<String, dynamic> data, String endPoint, {String? token}) async {
    final http.Request request = http.Request('PATCH', Uri.parse('${ApiConstants.baseURL}$endPoint'));

    request.headers.addAll({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'authorization': 'Bearer $token',
    });

    request.body = json.encode(data);

    final http.StreamedResponse response = await request.send();

    return json.decode(await response.stream.bytesToString());
  }

  Future<Map<String, dynamic>> post(Map<String, dynamic>? data, String endPoint, {String? baseUrl, String? token}) async {
    final String baseURL = baseUrl ?? ApiConstants.baseURL;

    final http.Request request = http.Request('POST', Uri.parse('$baseURL$endPoint'));

    request.headers.addAll({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'authorization': 'Bearer $token',
    });

    if (data != null) {
      request.body = json.encode(data);
    }

    final http.StreamedResponse response = await request.send();

    String res = await response.stream.bytesToString();

    return json.decode(res);
  }

  Future<Map<String, dynamic>> get(String endPoint, {String? token}) async {
    final http.Request request = http.Request('GET', Uri.parse('${ApiConstants.baseURL}$endPoint'));

    request.headers.addAll({
      'authorization': 'Bearer $token',
    });

    final http.StreamedResponse response = await request.send();

    return json.decode(await response.stream.bytesToString());
  }

  Future<Map<String, dynamic>> uploadFile(String endPoint, String filePath, {String? token}) async {
    var request = http.MultipartRequest('PATCH', Uri.parse('${ApiConstants.baseURL}$endPoint'));
    request.files.add(await http.MultipartFile.fromPath('image', filePath));
    request.headers.addAll({
      'authorization': 'Bearer $token',
    });
    final http.StreamedResponse response = await request.send();

    return json.decode(await response.stream.bytesToString());
  }

  Future<Map<String, dynamic>> uploadCv(String endPoint, String filePath, {String? token}) async {
    var request = http.MultipartRequest('POST', Uri.parse('${ApiConstants.baseURL}$endPoint'));
    request.files.add(await http.MultipartFile.fromPath('CV', filePath));
    request.headers.addAll({
      'authorization': 'Bearer $token',
    });
    final http.StreamedResponse response = await request.send();

    return json.decode(await response.stream.bytesToString());
  }
}
