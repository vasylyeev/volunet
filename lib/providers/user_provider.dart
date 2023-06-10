import 'package:flutter/cupertino.dart';
import '../models/user.dart';
import '../resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods auth = AuthMethods();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await auth.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
