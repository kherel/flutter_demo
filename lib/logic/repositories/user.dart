import 'package:my_flutter_course/logic/logic.dart';

class UserRepository {
  final String email = 'test@domain.com';
  final String id = 'userId';
  final String password = 'password';
  final String token = 'token';

  Future<Me> signInWithCredentials(String email, String password) async {
    await Future<void>.delayed(Duration(microseconds: 50));

    if (email != this.email || password != this.password) {
      throw WrongCredentiaException();
    }

    return Me(token: token, userEmail: Email(email), id: id);
  }
}

class WrongCredentiaException implements Exception {
  String toString() => 'WrongCredentiaException: wrong email or password';
}
