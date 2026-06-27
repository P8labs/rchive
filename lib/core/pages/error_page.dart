import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rchive/core/theme/app_pallet.dart';

class ErrorPage extends StatelessWidget {
  final String message;

  const ErrorPage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("ERROR: $message");
    }
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: .start,
              crossAxisAlignment: .start,
              children: [
                Text("App Crashed", style: TextStyle(fontSize: 20)),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      message,
                      style: TextStyle(
                        fontFeatures: [FontFeature.tabularFigures()],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                RichText(
                  text: TextSpan(
                    text: 'Contact Support: ',
                    style: Theme.of(context).textTheme.titleMedium,
                    children: [
                      TextSpan(
                        text: 'apps-help@p8labs.in',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: AppPallete.textSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
