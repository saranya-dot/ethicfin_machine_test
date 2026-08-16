import 'package:hive_ce/hive.dart';

import '../domain/search_request_model.dart';

class RecentSearchesStorage {
  static const boxName = 'recent_searches';
  static const maxEntries = 5;

  Box<SearchRequestModel> get _box =>
      Hive.box<SearchRequestModel>(boxName);

  List<String> getRecent() {
    return _box.values.map((e) => e.username).toList().reversed.toList();
  }

  Future<void> add(String username) async {
    final normalized = username.trim();
    if (normalized.isEmpty) return;

    final duplicateKeys = _box.keys.where(
      (key) =>
          _box.get(key)?.username.toLowerCase() == normalized.toLowerCase(),
    );
    await _box.deleteAll(duplicateKeys);

    await _box.add(SearchRequestModel(username: normalized));

    while (_box.length > maxEntries) {
      await _box.deleteAt(0);
    }
  }

  Future<void> remove(String username) async {
    final normalized = username.trim().toLowerCase();
    final keys = _box.keys.where(
      (key) => _box.get(key)?.username.toLowerCase() == normalized,
    );
    await _box.deleteAll(keys);
  }

  Future<void> clear() async {
    await _box.clear();
  }
}
