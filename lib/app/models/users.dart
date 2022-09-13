import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String username;
  String email;
  String password;
  String role;
  Timestamp createdAt;
  List<String>? searchKeyword;
  String? idDocument;

  UserModel({
    required this.username,
    required this.email,
    required this.role,
    required this.password,
    required this.createdAt,
    this.searchKeyword,
  });

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserModel(
      username: data?['username'],
      email: data?['email'],
      password: data?['password'],
      role: data?['role'],
      createdAt: data?['createdAt'],
      searchKeyword: data?['searchKeyword'] is Iterable
          ? List.from(data?['searchKeyword'])
          : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "username": username,
      "email": email,
      "password": password,
      "role": role,
      "createdAt": createdAt,
      if (searchKeyword != null) "searchKeyword": searchKeyword,
    };
  }
}
