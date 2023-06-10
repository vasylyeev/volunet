import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:volunet/models/user.dart';

class UsersMethods {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<User> getUserByUID(String usersUID) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await _firebaseFirestore.collection('users').doc(usersUID).get();
    return User.fromSnapshot(documentSnapshot);
  }

  Future<String> updateUsersProfilePicture(String usersUID, String newPictureURL) async {
    String response = 'Error';
    try {
      _firebaseFirestore.collection('users').doc(usersUID).update({
        'avatar_url': newPictureURL,
      });
      response = 'Success';
    } catch (error) {
      response = error.toString();
    }
    print(response);
    return response;
  }
}