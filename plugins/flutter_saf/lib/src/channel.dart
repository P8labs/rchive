import 'package:flutter/services.dart';

import 'document_entry.dart';
import 'exceptions.dart';

class FlutterSafChannel {
  FlutterSafChannel._();

  static const MethodChannel _channel = MethodChannel(
    'dev.priyanshu/flutter_saf',
  );

  static Future<String?> pickDirectory() async {
    return _invoke<String>('pickDirectory');
  }

  static Future<bool> exists({
    required String treeUri,
    required String path,
  }) async {
    return (await _invoke<bool>('exists', {
          'treeUri': treeUri,
          'path': path,
        })) ??
        false;
  }

  static Future<List<DocumentEntry>> list({
    required String treeUri,
    required String path,
  }) async {
    final result = await _invoke<List<dynamic>>('list', {
      'treeUri': treeUri,
      'path': path,
    });

    if (result == null) {
      return const [];
    }

    return result
        .cast<Map<Object?, Object?>>()
        .map(DocumentEntry.fromMap)
        .toList();
  }

  static Future<Uint8List> read({
    required String treeUri,
    required String path,
  }) async {
    return (await _invoke<Uint8List>('read', {
      'treeUri': treeUri,
      'path': path,
    }))!;
  }

  static Future<void> write({
    required String treeUri,
    required String path,
    required Uint8List bytes,
  }) {
    return _invoke<void>('write', {
      'treeUri': treeUri,
      'path': path,
      'bytes': bytes,
    });
  }

  static Future<String> createDirectory({
    required String treeUri,
    required String path,
  }) async {
    return (await _invoke<String>('createDirectory', {
      'treeUri': treeUri,
      'path': path,
    }))!;
  }

  static Future<void> delete({
    required String treeUri,
    required String path,
    bool recursive = false,
  }) {
    return _invoke<void>('delete', {
      'treeUri': treeUri,
      'path': path,
      'recursive': recursive,
    });
  }

  static Future<void> rename({
    required String treeUri,
    required String path,
    required String newName,
  }) {
    return _invoke<void>('rename', {
      'treeUri': treeUri,
      'path': path,
      'newName': newName,
    });
  }

  static Future<T?> _invoke<T>(String method, [Object? arguments]) async {
    try {
      return await _channel.invokeMethod<T>(method, arguments);
    } on PlatformException catch (e) {
      throw FlutterSafException(
        code: e.code,
        message: e.message,
        details: e.details,
      );
    }
  }
}
