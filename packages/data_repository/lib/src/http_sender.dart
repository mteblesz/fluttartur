import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

enum HttpMethod {
  get_,
  post,
  put,
  patch,
  delete,
}

class HttpSender {
  HttpSender._();

  static Future<http.Response> get(Uri uri,
      {required Map<String, String>? headers}) async {
    return await _send(HttpMethod.get_, uri, headers);
  }

  static Future<http.Response> post(Uri uri,
      {required Map<String, String>? headers}) async {
    return await _send(HttpMethod.post, uri, headers);
  }

  static Future<http.Response> put(Uri uri,
      {required Map<String, String>? headers}) async {
    return await _send(HttpMethod.put, uri, headers);
  }

  static Future<http.Response> patch(Uri uri,
      {required Map<String, String>? headers}) async {
    return await _send(HttpMethod.patch, uri, headers);
  }

  static Future<http.Response> delete(Uri uri,
      {required Map<String, String>? headers}) async {
    return await _send(HttpMethod.delete, uri, headers);
  }

  static Future<http.Response> _send(
    HttpMethod httpMethod,
    Uri uri, [
    Map<String, String>? headers,
  ]) async {
    try {
      // Disable SSL verification for development purposes
      final httpClient = HttpClient()
        ..badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);

      late HttpClientRequest request;
      switch (httpMethod) {
        case HttpMethod.get_:
          request = await httpClient.getUrl(uri);
          break;
        case HttpMethod.post:
          request = await httpClient.postUrl(uri);
          break;
        case HttpMethod.put:
          request = await httpClient.putUrl(uri);
          break;
        case HttpMethod.patch:
          request = await httpClient.patchUrl(uri);
          break;
        case HttpMethod.delete:
          request = await httpClient.deleteUrl(uri);
          break;
      }
      headers?.forEach((key, value) {
        request.headers.set(key, value);
      });

      final response = await request.close();
      httpClient.close();
      return await convertHttpClientResponse(response);
    } on HandshakeException catch (_) {
      print("Certificate error");
      rethrow;
    } on Exception catch (_) {
      rethrow;
    }
  }

  static Future<http.Response> convertHttpClientResponse(
      HttpClientResponse httpClientResponse) async {
    final statusCode = httpClientResponse.statusCode;
    final Map<String, String> headersMap = {};
    httpClientResponse.headers.forEach((String name, List<String> values) {
      final value = values.join(', ');
      headersMap[name] = value;
    });
    final bodyBytes = await httpClientResponse.toList();
    final body = bodyBytes.isNotEmpty
        ? bodyBytes.reduce((a, b) => [...a, ...b])
        : Uint8List(0);

    return http.Response.bytes(
      body,
      statusCode,
      headers: headersMap,
    );
  }
}
