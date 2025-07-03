import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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

  void updateIndex(int indexcha) {
    currentIndex = indexcha;
    notifyListeners();
  }

  bool isLoading = false;

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
}
