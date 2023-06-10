import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:volunet/models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await _firebaseFirestore
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .get();

    return model.User.fromSnapshot(snapshot);
  }

  Future<String> signUpUser(
      {required String name,
      required String surname,
      required String email,
      required String city,
      required String phoneNumber,
      required String password,}) async {
    String response = 'Some error occured';
    try {
      model.User user = model.User(
        avatarURL: '',
        name: name,
        surname: surname,
        email: email,
        city: city,
        phoneNumber: phoneNumber,
        password: password,
      );

      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await _firebaseFirestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(user.toJson());
      response = 'success';
    } catch (error) {
      response = error.toString();
    }
    return response;
  }

  Future<String> logInUser(
      {required String email, required String password}) async {
    String response = 'Some error occured';
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      response = 'success';
    } catch (error) {
      response = error.toString();
    }
    return response;
  }
}
