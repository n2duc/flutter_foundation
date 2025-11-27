import 'dart:async';

abstract class ApiCollection {
  String get name;

  Future<T> query<T>(String apiName, {Map<String, dynamic>? params});
  Future<T> queryItem<T>(
    String apiName,
    String itemId, {
    Map<String, dynamic>? params,
  });
  Future<T> queryMeta<T>(String apiName, {Map<String, dynamic>? params});
  Future<T> commandMeta<T>(String apiName, {Map<String, dynamic>? params});
  Future<T> send<T>(
    String apiName,
    dynamic data, {
    Map<String, dynamic>? params,
  });
  Future<T> request<T>(
    String apiName,
    dynamic data, {
    Map<String, dynamic>? params,
  });
  Stream<T> subscribe<T>(
    String apiName, {
    String? channel,
    Map<String, dynamic>? params,
  });
  Future<void> publish<T>(
    String apiName, {
    String? channel,
    Map<String, dynamic>? params,
  });
}

class APIManager {
  APIManager._();

  static final Map<String, ApiCollection> _registry = {};

  // register api collection
  static ApiCollection register(ApiCollection collection) {
    final collectionName = collection.name;
    if (_registry.containsKey(collectionName)) {
      // keep exists collection
      return _registry[collectionName]!;
    }
    _registry[collectionName] = collection;
    return collection;
  }

  // get collection by name
  static ApiCollection getCollection(String name) {
    final collection = _registry[name];
    if (collection == null) {
      throw StateError("API collection '$name' is not registered");
    }
    return collection;
  }

  // list all collections registered
  static List<String> listCollections() => List.unmodifiable(_registry.keys);

  // clean registy
  static void clear() => _registry.clear();

  // split the "collection:api" string
  static ({ApiCollection collection, String apiName}) _parse(String fullName) {
    final parts = fullName.split(RegExp(r':(.+)'));
    if (parts.length < 2) {
      throw ArgumentError(
        "API name must follow 'collection:api', received '$fullName'",
      );
    }
    final collectionName = parts.first;
    final apiShortName = parts.last;
    final collection = getCollection(collectionName);
    return (collection: collection, apiName: apiShortName);
  }

  static Future<T> query<T>(String fullName, {Map<String, dynamic>? params}) {
    final parsed = _parse(fullName);
    return parsed.collection.query<T>(parsed.apiName, params: params);
  }

  static Future<T> queryItem<T>(
    String fullName,
    String itemId, {
    Map<String, dynamic>? params,
  }) {
    final parsed = _parse(fullName);
    return parsed.collection.queryItem(parsed.apiName, itemId, params: params);
  }

  static Future<T> queryMeta<T>(
    String fullName, {
    Map<String, dynamic>? params,
  }) {
    final parsed = _parse(fullName);
    return parsed.collection.queryMeta(parsed.apiName, params: params);
  }

  static Future<T> commandMeta<T>(
    String fullName, {
    Map<String, dynamic>? params,
  }) {
    final parsed = _parse(fullName);
    return parsed.collection.commandMeta(parsed.apiName, params: params);
  }

  static Future<T> send<T>(
    String fullName,
    dynamic data, {
    Map<String, dynamic>? params,
  }) {
    final parsed = _parse(fullName);
    return parsed.collection.send(parsed.apiName, data, params: params);
  }

  static Future<T> request<T>(
    String fullName,
    dynamic data, {
    Map<String, dynamic>? params,
  }) {
    final parsed = _parse(fullName);
    return parsed.collection.request(parsed.apiName, data, params: params);
  }

  static Stream<T> subscribe<T>(
    String fullName, {
    String? channel,
    Map<String, dynamic>? params,
  }) {
    final parsed = _parse(fullName);
    return parsed.collection.subscribe(
      parsed.apiName,
      channel: channel,
      params: params,
    );
  }

  static Future<void> publish<T>(
    String fullName, {
    String? channel,
    Map<String, dynamic>? params,
  }) {
    final parsed = _parse(fullName);
    return parsed.collection.publish(
      parsed.apiName,
      channel: channel,
      params: params,
    );
  }
}
