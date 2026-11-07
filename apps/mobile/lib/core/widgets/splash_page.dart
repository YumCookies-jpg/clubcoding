import 'package:flutter/material.dart';

import '../l10n/app_strings.dart';
import 'app_loading_view.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: AppLoadingView(label: AppStrings.splashTitle));
  }
}
