import 'package:flutter/material.dart';
import 'package:libertad/navigation/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _opacity = 1);
    });
  }

  void _launchHomePage() =>
      Navigator.of(context).pushReplacementNamed(Routes.home);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedOpacity(
        duration: Duration(seconds: 3),
        curve: Curves.easeInOut,
        opacity: _opacity,
        onEnd: _launchHomePage,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 200,
                child: Image.asset('assets/Libertad Logo.png'),
              ),
              Text(
                'Libertad',
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                'A modern library management system',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
