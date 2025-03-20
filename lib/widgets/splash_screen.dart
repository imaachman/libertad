import 'package:flutter/material.dart';
import 'package:libertad/navigation/routes.dart';

/// Splash screen is displayed on app launch to show the logo, and then
/// immediately navigates to the home page.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  /// Used to control the opacity of the logo.
  double _opacity = 0;

  @override
  void initState() {
    super.initState();
    // Animate opacity to show the logo fading in.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _opacity = 1);
    });
  }

  /// Navigate to home page and remove the splash screen from navigation stack.
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
