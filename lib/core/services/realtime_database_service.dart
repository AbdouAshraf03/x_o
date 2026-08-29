import 'package:firebase_database/firebase_database.dart';

class RealtimeDatabaseService {
  final FirebaseDatabase _db;

  RealtimeDatabaseService(FirebaseDatabase database) : _db = database;

  DatabaseReference _ref(String path) => _db.ref(path);

  Future<void> set(String path, Map<String, dynamic> data) async {
    await _ref(path).set(data);
  }

  Future<void> update(String path, Map<String, dynamic> data) async {
    await _ref(path).update(data);
  }

  Future<String> push(String path, Map<String, dynamic> data) async {
    final newRef = _ref(path).push();
    await newRef.set(data);
    final key = newRef.key;
    if (key == null) {
      throw StateError('Failed to generate a push key at $path');
    }
    return key;
  }

  Future<void> remove(String path) async {
    await _ref(path).remove();
  }

  Future<void> setWithDisconnectCleanup(
    String path,
    Map<String, dynamic> data,
  ) async {
    final ref = _ref(path);
    await ref.onDisconnect().remove();
    await ref.set(data);
  }

  Future<TransactionResult> runTransaction(
    String path,
    TransactionHandler update,
  ) {
    return _ref(path).runTransaction(update);
  }

  Future<Map<String, dynamic>?> getOnce(String path) async {
    final snapshot = await _ref(path).get();
    if (!snapshot.exists) return null;
    return _castSnapshotValue(snapshot.value);
  }

  Stream<Map<String, dynamic>?> watch(String path) {
    return _ref(path).onValue.map((event) {
      final snapshot = event.snapshot;
      if (!snapshot.exists) return null;
      return _castSnapshotValue(snapshot.value);
    });
  }

  Stream<Map<String, Map<String, dynamic>>> watchChildren(
    String path, {
    Query Function(DatabaseReference ref)? queryBuilder,
  }) {
    final base = _ref(path);
    final query = queryBuilder != null ? queryBuilder(base) : base;

    return query.onValue.map((event) {
      final snapshot = event.snapshot;
      if (!snapshot.exists || snapshot.value == null) return {};

      final raw = _castSnapshotValue(snapshot.value) ?? {};
      return raw.map(
        (key, value) => MapEntry(key, Map<String, dynamic>.from(value as Map)),
      );
    });
  }

  Stream<Map<String, Map<String, dynamic>>> watchChildrenWhere(
    String path, {
    required String field,
    required Object value,
  }) {
    return watchChildren(
      path,
      queryBuilder: (ref) => ref.orderByChild(field).equalTo(value),
    );
  }

  Stream<bool> watchConnectionState() {
    return _db
        .ref('.info/connected')
        .onValue
        .map((event) => event.snapshot.value as bool? ?? false);
  }

  Map<String, dynamic>? _castSnapshotValue(Object? value) {
    if (value == null) return null;
    if (value is Map) {
      return value.map((key, val) => MapEntry(key.toString(), val));
    }

    return null;
  }
}
