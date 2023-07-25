part of 'transaction_bloc.dart';

@immutable
abstract class TransactionState {}

class TransactionInitial extends TransactionState {}

class HasDataTransactionState extends TransactionState {
  final List<TransactionModel> transactionList;

  HasDataTransactionState(this.transactionList);
}

class LoadingTransactionState extends TransactionState {}

class ErrorTransactionState extends TransactionState {
  final String errorText;

  ErrorTransactionState(this.errorText);
}
