import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String name, surname, email, city, phoneNumber, password, avatarURL;

  User({
    required this.name,
    required this.surname,
    required this.email,
    required this.city,
    required this.phoneNumber,
    required this.password,
    required this.avatarURL,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'surname': surname,
        'email': email,
        'city': city,
        'phone_number': phoneNumber,
        'password': password,
        'avatar_url': '',
      };

  static User fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return User(
      name: snapshot.data()!['name'],
      surname: snapshot.data()!['surname'],
      email: snapshot.data()!['email'],
      city: snapshot.data()!['city'],
      phoneNumber: snapshot.data()!['phone_number'],
      password: snapshot.data()!['password'],
      avatarURL: snapshot.data()!['avatar_url'],
    );
  }
}
