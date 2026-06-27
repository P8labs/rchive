class FlutterSafException implements Exception {
  final String code;
  final String? message;
  final Object? details;

  const FlutterSafException({required this.code, this.message, this.details});

  @override
  String toString() {
    return 'FlutterSafException(code: $code, message: $message)';
  }
}
