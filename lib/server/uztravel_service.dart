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
    final places = snapshot.docs.map((doc) =>
    {
      ...doc.data(),
      "id": doc.id,
    }).toList();

    return places;
  }

  Future<void> addFavourite(
      {required String userId, required String itemId}) async {
    await FirebaseFirestore.instance.collection("favourites").add({

      "userId": userId,
      "itemId": itemId,
      "timestamp": FieldValue.serverTimestamp(),
    });
  }
}