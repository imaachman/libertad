import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/data/repositories/database_repository.dart';

import 'navigation/route_generator.dart';

Future<void> main() async {
  // Make sure that an instance of [WidgetsBinding] is available to call native
  // code through platform channels.
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize database repository.
  await DatabaseRepository.instance.initialize();
  runApp(const ProviderScope(child: Libertad()));
}

/// Entry point of the application.
class Libertad extends StatelessWidget {
  const Libertad({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Libertad',
      onGenerateRoute: RouteGenerator.generate,
    );
  }
}
