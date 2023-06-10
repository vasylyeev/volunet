import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String authorID, category, date, text, time, imageURL, likes;

  Post({
    required this.authorID,
    required this.category,
    required this.date,
    required this.imageURL,
    required this.text,
    required this.time,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
        'author_id': authorID,
        'category': category,
        'date': date,
        'image_url': imageURL,
        'text': text,
        'time': time,
        'likes': likes,
      };

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      authorID: json['author_id'],
      category: json['category'],
      date: json['date'],
      imageURL: json['image_url'],
      text: json['text'],
      time: json['time'],
      likes: json['likes'],
    );
  }

  static Post fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return Post(
      authorID: snapshot.data()!['author_id'],
      category: snapshot.data()!['category'],
      date: snapshot.data()!['date'],
      imageURL: snapshot.data()!['image_url'],
      text: snapshot.data()!['text'],
      time: snapshot.data()!['time'],
      likes: snapshot.data()!['likes'],
    );
  }
}
