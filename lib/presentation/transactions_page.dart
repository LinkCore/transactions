import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_transaction/common/app_constants/app_strings.dart';
import 'package:test_transaction/domain/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:test_transaction/presentation/widgets/transaction.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({Key? key}) : super(key: key);

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<TransactionBloc, TransactionState>(
            builder: (context, state) {
          if (state is LoadingTransactionState) {
            return const CircularProgressIndicator();
          } else if (state is HasDataTransactionState) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      '${AppStrings.activeTransactions} ${state.transactionList.length.toString()}'),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: state.transactionList.map((e) {
                        return TransactionWidget(transaction: e);
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        }),
      ),
    );
  }
}
