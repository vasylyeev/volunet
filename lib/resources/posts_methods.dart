import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:volunet/resources/storage_methods.dart';
import '../models/post.dart';

class PostsMethods {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<String> addPost(
      {required String authorID,
      required String category,
      required String date,
      required Uint8List image,
      required String text,
      required String time}) async {
    String response = 'Some error occurred';
    try {

      String imageURL = await StorageMethods().uploadImageToStorage('postsPics', image);

      await _firebaseFirestore.collection('posts').add({
        'author_id': authorID,
        'category': category,
        'date': date,
        'image_url': imageURL,
        'text': text,
        'time': time,
        'likes': '0',
      });

      response = 'success';
    } catch (error) {
      response = error.toString();
    }
    return response;
  }
}
