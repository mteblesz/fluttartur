import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

enum HttpVerb {
  get_,
  post,
  put,
  patch,
  delete,
}

/// A utility class for making HTTP requests using Dart's [HttpClient].
/// It replaces http.verb() calls from http library, but it does not check for server certificate on handshake
/// For certificate check simply replace HttpSender.verb() calls with http.verb() [import 'package:http/http.dart' as http;]
class HttpSender {
  HttpSender._();

  static Future<http.Response> get(Uri uri,
      {required Map<String, String>? headers, String? body}) async {
    return await _send(HttpVerb.get_, uri, headers, body);
  }

  static Future<http.Response> post(Uri uri,
      {required Map<String, String>? headers, String? body}) async {
    return await _send(HttpVerb.post, uri, headers, body);
  }

  static Future<http.Response> put(Uri uri,
      {required Map<String, String>? headers, String? body}) async {
    return await _send(HttpVerb.put, uri, headers, body);
  }

  static Future<http.Response> patch(Uri uri,
      {required Map<String, String>? headers, String? body}) async {
    return await _send(HttpVerb.patch, uri, headers, body);
  }

  static Future<http.Response> delete(Uri uri,
      {required Map<String, String>? headers, String? body}) async {
    return await _send(HttpVerb.delete, uri, headers, body);
  }

  static Future<http.Response> _send(
    HttpVerb httpMethod,
    Uri uri, [
    Map<String, String>? headers,
    String? body,
  ]) async {
    try {
      // Disable SSL verification for development purposes
      final httpClient = HttpClient()
        ..badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);

      late HttpClientRequest request;
      switch (httpMethod) {
        case HttpVerb.get_:
          request = await httpClient.getUrl(uri);
          break;
        case HttpVerb.post:
          request = await httpClient.postUrl(uri);
          break;
        case HttpVerb.put:
          request = await httpClient.putUrl(uri);
          break;
        case HttpVerb.patch:
          request = await httpClient.patchUrl(uri);
          break;
        case HttpVerb.delete:
          request = await httpClient.deleteUrl(uri);
          break;
      }
      headers?.forEach((key, value) {
        request.headers.set(key, value);
      });

      if (body != null) {
        request.write(body);
      }

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
