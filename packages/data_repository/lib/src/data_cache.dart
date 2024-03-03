import 'package:cache/cache.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:data_repository/models/models.dart';

class CacheNullException implements Exception {
  const CacheNullException([this.message = 'The cache is unexpectedly null.']);
  final String message;
}

class DataCache {
  DataCache(this._cacheClient);

  final CacheClient _cacheClient;

  //----------------------- token -----------------------
  static const _userCacheKey = '__user_cache_key__';
  String get authToken {
    User user = _cacheClient.read<User>(key: _userCacheKey) ?? User.empty;
    return user.token ?? "";
  }

  //----------------------- ids -----------------------
  static const invalidId = -1;

  static const currentRoomIdCacheKey = '__room_id_cache_key__';
  int get currentRoomId {
    return _cacheClient.read<int>(key: currentRoomIdCacheKey) ?? invalidId;
  }

  set currentRoomId(int id) {
    _cacheClient.write(key: currentRoomIdCacheKey, value: id);
  }

  static const currentPlayerIdCacheKey = '__player_id_cache_key__';
  int get currentPlayerId {
    return _cacheClient.read<int>(key: currentPlayerIdCacheKey) ?? invalidId;
  }

  set currentPlayerId(int id) {
    _cacheClient.write(key: currentPlayerIdCacheKey, value: id);
  }

  //----------------------- courtier data -----------------------
  static const currentCourtierCacheKey = '__Courtier_cache_key__';
  Courtier get currentCourtier {
    return _cacheClient.read<Courtier>(key: currentCourtierCacheKey) ??
        Courtier.empty;
  }

  set currentCourtier(Courtier courtier) {
    _cacheClient.write(key: currentCourtierCacheKey, value: courtier);
  }
}
