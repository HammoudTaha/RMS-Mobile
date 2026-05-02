import 'package:hive/hive.dart';

import '../../errors/exceptions.dart';

class LocalStorage<T> {
  final Box<T> _box;
  const LocalStorage(this._box);

  void store(T t) async {
    await _box.add(t);
  }

  List<T> get() {
    return _box.values.toList();
  }

  Future<void> delete(int index) async {
    await _box.deleteAt(index);
  }

  void storeKayValue(T t, String key) {
    _box.put(key, t);
  }

  T getKeyValue(String key) {
    T? t = _box.get(key);
    if (t != null) {
      return t;
    } else {
      throw CachException(message: 'Something went wrong. Please try again');
    }
  }

  void deletKeyValue(String key) {
    _box.delete(key);
  }
}
