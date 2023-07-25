part of 'transaction_bloc.dart';

@immutable
abstract class TransactionEvent {}

class FetchDataTransactionEvent extends TransactionEvent {}

class DeleteTransactionEvent extends TransactionEvent {
  final TransactionModel model;

  DeleteTransactionEvent(this.model);
}
