import 'package:BuMo/screens/on-boarding_screen.dart';
import 'package:BuMo/utils/effects/fade_page_route.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key, required String passengerID});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(FadePageRoute(page: OnBoarding()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/BuMo.png',
          width: 200, // Set a specific width
          height: 200, // Set a specific height
          fit: BoxFit.contain, // Ensure the whole image is visible
        ),
      ),
    );
  }
}
