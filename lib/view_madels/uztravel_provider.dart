import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uz_travel/server/uztravel_service.dart';

class UzTravelProvider extends ChangeNotifier {
  UzTravelService uzTravelService = UzTravelService();
  int currentIndex = 0;
  bool isLoading = false;

  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  // switch theme
  void toggleTheme(bool isOn){
    _themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  //sign Up
  Future<User?> signUp(
    String email,
    String password,
    String firstName,
    String lastName,
  ) async {
    isLoading = true;
    notifyListeners();
    final user = await uzTravelService.signUp(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
    );
    isLoading = false;
    notifyListeners();
    return user;
  }

  // sign In

  Future<User?> signIn(String email, String password) async {
    isLoading = true;
    notifyListeners();
    final user = await uzTravelService.signIn(email: email, password: password);
    isLoading = false;
    notifyListeners();
    return user;
  }

  void updateIndex(int index){
    currentIndex = index;
    notifyListeners();
  }
}
