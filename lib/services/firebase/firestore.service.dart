import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projectka_pos/app/models/users.dart';

abstract class FirestoreService {
  static var timeStamp = Timestamp.now();

  // Reference Collection Path Data
  static final refUsers = FirebaseFirestore.instance
      .collection('users')
      .withConverter(
        fromFirestore: UserModel.fromFirestore,
        toFirestore: (UserModel userModel, options) => userModel.toFirestore(),
      );
}
