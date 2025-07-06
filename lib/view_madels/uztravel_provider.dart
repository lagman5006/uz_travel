import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uz_travel/gen/assets.gen.dart';
import 'package:uz_travel/server/uztravel_service.dart';

class UzTravelProvider extends ChangeNotifier {
  final UzTravelService uzTravelService = UzTravelService();

  int currentIndex = 0;
  List<String> imagesPath = [
    Assets.images.pageImage1.path,
    Assets.images.pageImage2.path,
    Assets.images.pageImage3.path,
  ];

  void updateIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  bool isLoading = false;

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  // switch theme
  void toggleTheme(bool isOn) {
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

  Future<User?> signIn(String email, String password) async {
    isLoading = true;
    notifyListeners();

    final user = await uzTravelService.signIn(email: email, password: password);

    isLoading = false;
    notifyListeners();
    return user;
  }

  Future<void> addFavourite(String itemId) async {
    isLoading = true;
    notifyListeners();
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      await uzTravelService.addFavourite(userId: userId, itemId: itemId);
      isLoading = false;
      notifyListeners();
    }
  }

  List<Map<String, dynamic>> places = [];

  Future<void> fetchPlaces() async {
    places = await uzTravelService.fetchPlaces();
    isLoading = false;
    notifyListeners();
  }

  List<Map<String, dynamic>> favouritePlaces = [];

  Future<void> fetchFavouritePlaces() async {
    isLoading = true;
    try {
      String? userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        favouritePlaces = await uzTravelService.fetchFavouritePlaces(userId);
      } else {
        favouritePlaces = [];
      }
    } catch (e) {
      favouritePlaces = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // By time
  List<Map<String, dynamic>> scheduledPlaces = [];

  Future<void> fetchPlacesByDate(DateTime date) async {
    isLoading = true;
    scheduledPlaces = await uzTravelService.fetchPlacesByDate(date);
    isLoading = false;
    notifyListeners();
  }

  // method to add a place

  Future<void> addPlace(Map<String, dynamic> place) async {
    isLoading = true;
    await uzTravelService.addPlace(place);
    await fetchPlaces();
    isLoading = false;
    notifyListeners();
  }

  Future<void> updatePlace(String id, Map<String, dynamic> place) async {
    isLoading = true;
    await uzTravelService.updatePlace(id, place);
    await fetchPlaces();
    isLoading = false;
    notifyListeners();
  }

  Future<void> deletePlase(String id) async {
    isLoading = true;
    notifyListeners();
    await uzTravelService.deletePlace(id);
    await fetchPlaces();
    isLoading = false;
    notifyListeners();
  }

  // user profile data
  Map<String, dynamic>? _userProfile;

  Map<String, dynamic>? get userProfile => _userProfile;

  Future<void> fetchUserProfile() async {
    isLoading = true;
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    final snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .get();
    _userProfile = snapshot.data();
  }
}
