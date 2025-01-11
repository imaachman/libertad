import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/home/home_screen.dart';
import 'navigation/route_generator.dart';

void main() {
  runApp(const ProviderScope(child: Libertad()));
}

class Libertad extends StatelessWidget {
  const Libertad({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Libertad',
      home: HomePage(),
      onGenerateRoute: RouteGenerator.generate,
    );
  }
}
