import 'dart:async';
import 'dart:io';

enum HttpMethod {
  get,
  post,
  put,
  delete,
}

class HttpSender {
  HttpSender._();

  static Future<HttpClientResponse> get(String url,
      [Map<String, String>? headers]) async {
    return await _send(HttpMethod.get, url, headers);
  }

  static Future<HttpClientResponse> post(String url,
      [Map<String, String>? headers]) async {
    return await _send(HttpMethod.post, url, headers);
  }

  static Future<HttpClientResponse> put(String url,
      [Map<String, String>? headers]) async {
    return await _send(HttpMethod.put, url, headers);
  }

  static Future<HttpClientResponse> delete(String url,
      [Map<String, String>? headers]) async {
    return await _send(HttpMethod.delete, url, headers);
  }

  static Future<HttpClientResponse> _send(
    HttpMethod httpMethod,
    String url, [
    Map<String, String>? headers,
  ]) async {
    // Disable SSL verification for development purposes
    final httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);

    final uri = Uri.parse(url);

    late HttpClientRequest request;
    switch (httpMethod) {
      case HttpMethod.get:
        request = await httpClient.getUrl(uri);
        break;
      case HttpMethod.post:
        request = await httpClient.postUrl(uri);
        break;
      case HttpMethod.put:
        request = await httpClient.putUrl(uri);
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
    return response;
  }
}
