import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_generator/view/home.dart';
import 'package:qr_generator/view/onboarding/onboarding_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashService {
  void checkUserToken(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var checkUserToken = prefs.getBool("userToken");
    if (checkUserToken == true) {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomeView()));
      });
    } else {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const OnboardingView()));
      });
    }
  }
}
