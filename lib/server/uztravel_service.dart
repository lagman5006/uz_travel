import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UzTravelService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // sign up
  Future<User> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      UserCredential credential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = credential.user;

      await FirebaseFirestore.instance.collection("users").doc(user!.uid).set({
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
      });
      return user;
    } catch (e) {
      throw Exception('Sign-up failed: $e');
    }
  }

  // sign in
  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return credential.user;
    } catch (e) {
      throw Exception('Sign-in failed: $e');
    }
  }

  // get products
  Future<List<Map<String, dynamic>>> fetchPlaces() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection("places")
          .get();
      final places = snapshot.docs
          .map((doc) => {...doc.data(), "id": doc.id})
          .toList();
      return places;
    } catch (e) {
      throw Exception('Failed to fetch places: $e');
    }
  }

  Future<void> addFavourite({
    required String userId,
    required String itemId,
  }) async {
    try {
      await FirebaseFirestore.instance.collection("favourites").add({
        "userId": userId,
        "itemId": itemId,
        "timestamp": FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to add favourite: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchFavouritePlaces(String userId) async {
    try {
      final favouriteSnapshot = await FirebaseFirestore.instance
          .collection("favourites")
          .where("userId", isEqualTo: userId)
          .get();

      final favouriteItemIds = favouriteSnapshot.docs
          .map((doc) => doc.data()["itemId"] as String)
          .toList();

      if (favouriteItemIds.isEmpty) return [];

      final placesSnapshot = await FirebaseFirestore.instance
          .collection("places")
          .where(FieldPath.documentId, whereIn: favouriteItemIds)
          .get();

      final favouritePlaces = placesSnapshot.docs
          .map((doc) => {...doc.data(), "id": doc.id})
          .toList();

      return favouritePlaces;
    } catch (e) {
      throw Exception('Failed to fetch favourite places: $e');
    }
  }

  Future<void> addPlace(Map<String, dynamic> place) async {
    try {
      await FirebaseFirestore.instance.collection("places").add({
        "name": place["name"],
        "location": place["location"],
        "imagePath": place["imagePath"],
        "rate": place["rate"],
        "price": place["price"],
        "description": place["description"],
        "timestamp": FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to add place: $e');
    }
  }

  // method to update a place
  Future<void> updatePlace(String id, Map<String, dynamic> place) async {
    try {
      await FirebaseFirestore.instance.collection("places").doc(id).update({
        "name": place["name"],
        "location": place["location"],
        "imagePath": place["imagePath"],
        "rate": place["rate"],
        "price": place["price"],
        "description": place["description"],
      });
    } catch (e) {
      throw Exception('Failed to update place: $e');
    }
  }

  Future<void> deletePlace(String id) async {
    try {
      await FirebaseFirestore.instance.collection("places").doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete place: $e');
    }
  }

  // method to fetch places by date
  Future<List<Map<String, dynamic>>> fetchPlacesByDate(DateTime date) async {
    try {
      final startOfDay = DateTime(date.year, date.month, date.day);
      final endOfDay = startOfDay.add(const Duration(days: 1)).subtract(Duration(seconds: 1));

      final snapshot = await FirebaseFirestore.instance
          .collection("places")
          .where("timestamp", isGreaterThanOrEqualTo: startOfDay)
          .where("timestamp", isLessThanOrEqualTo: endOfDay)
          .get();

      final places = snapshot.docs
          .map((doc) => {...doc.data(), "id": doc.id})
          .toList();
      return places;
    } catch (e) {
      throw Exception('Failed to fetch places by date: $e');
    }
  }
}