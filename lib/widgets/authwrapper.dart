import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uz_travel/views/home_page/home_page.dart';
import 'package:uz_travel/views/onboarding_page.dart';

class Authwrapper extends StatelessWidget {
  const Authwrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null){
      return HomePage();
    }else{
      return OnboardingPage();
    }
  }
}
