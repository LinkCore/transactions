import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_transaction/common/app_constants/app_constants.dart';
import 'package:test_transaction/data/models/transaction.dart';

class TransactionRepository {
  static final TransactionRepository _userRepository =
      TransactionRepository._internal();

  factory TransactionRepository() {
    return _userRepository;
  }

  TransactionRepository._internal();

  final CollectionReference _transactionCollection = FirebaseFirestore.instance
      .collection(AppConstants.transactionsCollection);

  Future<List<TransactionModel>> fetchTransactions() async {
    QuerySnapshot collection = await _transactionCollection.get();
    List<TransactionModel> listTransactions = [];
    for (var document in collection.docs) {
      TransactionModel transaction =
          TransactionModel.fromJson(document.data() as Map<String, dynamic>);
      transaction.number = document.id;

      listTransactions.add(transaction);
    }
    return listTransactions;
  }

  Future<void> deleteTransaction(TransactionModel transaction) async {
    await _transactionCollection.doc(transaction.number).delete();
  }
}
