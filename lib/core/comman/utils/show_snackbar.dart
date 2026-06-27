import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String content) {
  if (kDebugMode) {
    print('SNACKBAR ERROR: $content');
  }
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(content)));
}
