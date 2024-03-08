import 'package:cache/cache.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:data_repository/model/model.dart';

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

  static const currentTeamRoleCacheKey = '__team_role_cache_key__';
  TeamRole get currentTeamRole {
    return _cacheClient.read<TeamRole>(key: currentTeamRoleCacheKey) ??
        TeamRole.empty;
  }

  set currentTeamRole(TeamRole teamRole) {
    _cacheClient.write(key: currentTeamRoleCacheKey, value: teamRole);
  }
}
