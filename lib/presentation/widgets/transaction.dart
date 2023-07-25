import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_transaction/data/models/transaction.dart';
import 'package:test_transaction/data/models/type_transaction.dart';
import 'package:test_transaction/domain/blocs/transaction_bloc/transaction_bloc.dart';

class TransactionWidget extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionWidget({Key? key, required this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void onDelete(TransactionModel transaction) {
      context.read<TransactionBloc>().add(DeleteTransactionEvent(transaction));
      Navigator.of(context).pop();
    }

    return InkWell(
        onTap: () {
          showDialog(
              barrierDismissible: true,
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(
                    'Номер: ${transaction.number!}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Дата: ${transaction.date.toString()}'),
                      Text('Сумма: ${transaction.sum.toString()}'),
                      Text('Коммиссия: ${transaction.commission.toString()}'),
                      Text('Итого: ${transaction.amount.toString()}'),
                      Text('Тип: ${transaction.type.typeToString}')
                    ],
                  ),
                  actions: [
                    IconButton(
                        onPressed: () => onDelete(transaction),
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ))
                  ],
                );
              });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(transaction.number!),
                  const SizedBox(height: 5),
                  Text(transaction.type.typeToString),
                ],
              ),
              const Spacer(),
              Text(
                transaction.sum.toString(),
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ],
          ),
        ));
  }
}
