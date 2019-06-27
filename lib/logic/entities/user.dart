import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:my_flutter_course/logic/logic.dart';

class User extends Equatable {
  User({
    @required this.userEmail,
    @required this.id,
  }) : super([id]);

  final String id;
  final Email userEmail;

  @override
  String toString() {
    return 'id: $id, userEmail: $userEmail';
  }
}

class Me extends User {
  Me({
    @required this.userEmail,
    @required this.token,
    @required this.id,
  }) : super(userEmail: userEmail, id:id);

  final String token, id;
  final Email userEmail;

  @override
  String toString() {
    return 'id: $id, userEmail: $userEmail, token: $token';
  }
}
