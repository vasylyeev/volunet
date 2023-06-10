import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/post.dart';

class PostsProvider with ChangeNotifier{

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<List<Post>> getAllPosts() async {
    QuerySnapshot snapshot = await _firebaseFirestore.collection('posts').get();
    List<Post> posts = snapshot.docs.map((d) => Post.fromJson(d.data()! as Map<String, dynamic>)).toList();
    return posts;
  }

  Future<List<Post>> getPostsFromCategory(String category) async {
    QuerySnapshot snapshot = await _firebaseFirestore.collection('posts').where('category', isEqualTo: category).get();
    List<Post> posts = snapshot.docs.map((d) => Post.fromJson(d.data()! as Map<String, dynamic>)).toList();
    posts.forEach((element) {print(element.imageURL);});
    return posts;
  }

  Future<List<Post>> getPostsByUser(String userUID) async {
    QuerySnapshot snapshot = await _firebaseFirestore.collection('posts').where('author_id', isEqualTo: userUID).get();
    List<Post> posts = snapshot.docs.map((d) => Post.fromJson(d.data()! as Map<String, dynamic>)).toList();
    return posts;
  }
}