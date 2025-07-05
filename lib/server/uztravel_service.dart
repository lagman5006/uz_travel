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
    UserCredential credential = await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    User? user = credential.user;

    await FirebaseFirestore.instance.collection("users").doc(user!.uid).set({
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password,
    });
    return user;
  }

  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    UserCredential credential = await firebaseAuth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
    return credential.user;
  }

  // get products
  Future<List<Map<String, dynamic>>> fetchPlaces() async {
    final snapshot = await FirebaseFirestore.instance
        .collection("places")
        .get();
    final places = snapshot.docs
        .map((doc) => {...doc.data(), "id": doc.id})
        .toList();

    return places;
  }

  Future<void> addFavourite({
    required String userId,
    required String itemId,
  }) async {
    await FirebaseFirestore.instance.collection("favourites").add({
      "userId": userId,
      "itemId": itemId,
      "timestamp": FieldValue.serverTimestamp(),
    });
  }

  Future<List<Map<String, dynamic>>> fetchFavouritePlaces(String userId) async {
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
  }

  Future<void> addPlace(Map<String, dynamic> place) async {
    await FirebaseFirestore.instance.collection("places").add({
      "name": place["name"],
      "location": place["location"],
      "imagePath": place["imagePath"], // Corrected
      "rate": place["rate"],
      "price": place["price"],
      "description": place["description"],
      "timestamp": FieldValue.serverTimestamp(),
    });
  }
  
  // method to update a place
  Future<void> updatePlace(String id, Map<String, dynamic> place)async{
    await FirebaseFirestore.instance.collection("places").doc(id).update({
      "name": place["name"],
      "location": place["location"],
      "imagePath": place["imagePath"],
      "rate": place["rate"],
      "price": place["price"],
      "description": place["description"],
    });
  }
  Future<void> deletePlace(String id)async{
    await FirebaseFirestore.instance.collection("places").doc(id).delete();
  }
}

