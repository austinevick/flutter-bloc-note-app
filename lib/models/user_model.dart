import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_note_app/entity/user_entity.dart';

class User extends Equatable {
  final String id;
  final String email;
  const User({this.id, this.email});
  @override
  List<Object> get props => [id, email];

  @override
  String toString() => '''UserEntity {id: $id, email: $email }''';

  UserEntity toEntity() {
    return UserEntity(id: id, email: email);
  }

  factory User.fromEntity(UserEntity entity) {
    return User(id: entity.id, email: entity.email);
  }
}
