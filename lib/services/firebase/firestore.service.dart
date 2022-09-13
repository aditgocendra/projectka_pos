import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projectka_pos/app/models/detail_transaction.dart';
import 'package:projectka_pos/app/models/product.dart';
import 'package:projectka_pos/app/models/transaction.dart';
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

  static final refProduct = FirebaseFirestore.instance
      .collection('products')
      .withConverter(
          fromFirestore: ProductModel.fromFirestore,
          toFirestore: (ProductModel productModel, options) =>
              productModel.toFirestore());

  static final refTransaction = FirebaseFirestore.instance
      .collection('transactions')
      .withConverter<TransactionModel>(
          fromFirestore: (snapshot, _) =>
              TransactionModel.fromJson(snapshot.data()!),
          toFirestore: (transaction, _) => transaction.toJson());

  static CollectionReference<DetailTransactionModel>
      refSubCollectionDetailTransaction({
    required String idDoc,
    required String collection,
    required String subCollectionPath,
  }) {
    return FirebaseFirestore.instance
        .collection(collection)
        .doc(idDoc)
        .collection(subCollectionPath)
        .withConverter<DetailTransactionModel>(
            fromFirestore: (snapshot, _) =>
                DetailTransactionModel.fromJson(snapshot.data()!),
            toFirestore: (dTrans, _) => dTrans.toJson());
  }
}
