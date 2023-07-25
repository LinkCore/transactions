// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    TransactionModel(
      TransactionModel._dateFromJson(json['date'] as Timestamp),
      (json['sum'] as num).toDouble(),
      (json['amount'] as num).toDouble(),
      (json['commission'] as num).toDouble(),
      $enumDecode(_$TypeTransactionEnumMap, json['type']),
      json['number'] as String?,
    );

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'date': TransactionModel._dateToJson(instance.date),
      'sum': instance.sum,
      'amount': instance.amount,
      'commission': instance.commission,
      'type': _$TypeTransactionEnumMap[instance.type]!,
      'number': instance.number,
    };

const _$TypeTransactionEnumMap = {
  TypeTransaction.transfer: 'transfer',
  TypeTransaction.income: 'income',
  TypeTransaction.withdrawal: 'withdrawal',
};
