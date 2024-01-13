import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:cache/cache.dart';
import 'package:http/http.dart' as http;
import 'package:data_api_repository/api_config.dart';

part 'data_failures.dart';

// TODO make it an interface implementation, use DIP
class DataRepo {
  DataRepo({
    CacheClient? cache,
  }) : _cache = cache ?? CacheClient();

  final CacheClient _cache;

  //------------------------user------------------------
  static const userCacheKey = '__user_cache_key__';

  String get authToken {
    User user = _cache.read<User>(key: userCacheKey) ?? User.empty;
    return user.token ?? "";
  }

  Map<String, String> getHeaders() => <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      };

  Future<void> createRoom() async {
    final uri = Uri.parse(ApiConfig.createRoomUrl());

    try {
      final response = await http.post(uri, headers: getHeaders());

      if (response.statusCode == 201) {
        print('Room created successfully!');
      } else {
        print('Failed to create room. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error creating room: $e');
    }
  }
}
