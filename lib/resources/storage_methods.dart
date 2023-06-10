import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  final FirebaseStorage _firebaseStorage  = FirebaseStorage.instance;

  Future<String> uploadImageToStorage(String childName, Uint8List image) async {
    Reference reference = _firebaseStorage.ref().child(childName);

    UploadTask uploadTask = reference.putData(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }
}