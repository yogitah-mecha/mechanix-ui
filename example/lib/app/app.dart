import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

import '../layout/app_shell.dart';

/// The root application widget configured with [MechanixTheme].
class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MechanixTheme(
      builder: (context, theme, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Mechanix UI Example',
          theme: theme.light,
          darkTheme: theme.dark,
          themeMode: theme.mode,
          home: child,
        );
      },
      child: const AppShell(),
    );
  }
}
