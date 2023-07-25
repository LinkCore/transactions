import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_transaction/data/models/transaction.dart';
import 'package:test_transaction/data/repositories/transaction_repository.dart';

part 'transaction_event.dart';

part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionInitial()) {
    on<FetchDataTransactionEvent>(_onFetchDataTransactionEvent);
    on<DeleteTransactionEvent>(_onDeleteTransactionEvent);
  }

  final TransactionRepository _transactionRepository = TransactionRepository();

  Future<void> _onFetchDataTransactionEvent(
      FetchDataTransactionEvent event, Emitter<TransactionState> emit) async {
    emit(LoadingTransactionState());
    List<TransactionModel> listTransactions =
        await _transactionRepository.fetchTransactions();
    emit(HasDataTransactionState(listTransactions));
  }

  Future<void> _onDeleteTransactionEvent(
      DeleteTransactionEvent event, Emitter<TransactionState> emit) async {
    emit(LoadingTransactionState());
    await _transactionRepository.deleteTransaction(event.model);
    add(FetchDataTransactionEvent());
  }
}
