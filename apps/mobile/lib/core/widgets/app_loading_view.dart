import 'package:flutter/material.dart';

import '../l10n/app_strings.dart';

class AppLoadingView extends StatelessWidget {
  const AppLoadingView({super.key, this.label = AppStrings.loading});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
