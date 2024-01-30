
import 'package:vector_db/src/collection.dart';
import 'package:vector_db/vector_db.dart';

class VectorDB {
  VectorDB._internal();

  static final VectorDB _shared = VectorDB._internal();

  // factory VectorDB() {
  //   return _shared;
  // }

  static VectorDB get shared => _shared;

  final Map<String, Collection> _collections = {};

  Collection collection(String name) {
    if (_collections.containsKey(name)) {
      return _collections[name]!;
    }

    final Collection collection = Collection(name);
    _collections[name] = collection;
    collection.load();
    return collection;
  }

  Collection? getCollection(String name) {
    return _collections[name];
  }

  void releaseCollection(String name) {
    _collections.remove(name);
  }

  void reset() {
    for (final Collection collection in _collections.values) {
      collection.clear();
    }
    _collections.clear();
  }
}
