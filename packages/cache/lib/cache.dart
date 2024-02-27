library cache;

/// {@template cache_client}
/// An in-memory cache client.
/// {@endtemplate}
class CacheClient {
  /// {@macro cache_client}
  CacheClient() : _cache = <String, Object>{};

  final Map<String, Object> _cache;

  /// Writes the provide [key], [value] pair to the in-memory cache.
  void write<T extends Object>({required String key, required T value}) {
    _cache[key] = value;
  }

  /// Looks up the value for the provided [key].
  /// Defaults to `null` if no value exists for the provided key.
  T? read<T extends Object>({required String key}) {
    final value = _cache[key];
    if (value is T) return value;
    return null;
  }

  /// Removes cache entry for the provided [key].
  /// If no entry exists it does nothing as Map.remove is safe.
  void remove({required String key}) {
    _cache.remove(key);
  }
}
