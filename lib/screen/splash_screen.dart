import 'package:esho_eman_shikhi/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import '../responcive/responsive_layout.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // 3 সেকেন্ড পরে ResponsiveLayout এ যাবে
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ResponsiveLayout(
          mobileBody: HomeScreen(), webBody: HomeScreen(), tabletBody: HomeScreen(), desktopBody: HomeScreen(),)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Splash Screen',
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
