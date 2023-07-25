import 'package:flutter/material.dart';

enum TypeTransaction {
  transfer,
  income,
  withdrawal,
}

extension TypeTransactionExtension on TypeTransaction {
  String get typeToString {
    switch (this) {
      case TypeTransaction.transfer:
        return 'transfer';
      case TypeTransaction.income:
        return 'income';
      case TypeTransaction.withdrawal:
        return 'withdrawal';
      default:
        return 'others';
    }
  }

  Color get typeToColor {
    switch (this) {
      case TypeTransaction.transfer:
        return Colors.blue;
      case TypeTransaction.income:
        return Colors.yellow;
      case TypeTransaction.withdrawal:
        return Colors.pink;
      default:
        return Colors.orange;
    }
  }
}
