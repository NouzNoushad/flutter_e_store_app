import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_e_store/screens/home_screen.dart';

import '../core/colors.dart';
import 'widgets/text_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Animate(
        effects: const [
          ScaleEffect(
              curve: Curves.easeIn,
              delay: Duration(milliseconds: 800),
              duration: Duration(milliseconds: 1000))
        ],
        child: Center(
          child: CircleAvatar(
            radius: 150,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 140,
              backgroundColor: primaryColor,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 120,
                      color: whiteColor,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    LogoText(
                      fontSize: 35,
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
