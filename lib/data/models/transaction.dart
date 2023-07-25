import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:test_transaction/data/models/type_transaction.dart';

part 'transaction.g.dart';

@JsonSerializable()
class TransactionModel {
  @JsonKey(fromJson: _dateFromJson, toJson: _dateToJson)
  final DateTime date;
  final double sum;
  final double amount;
  final double commission;
  final TypeTransaction type;
  String? number;

  TransactionModel(this.date, this.sum, this.amount, this.commission, this.type,
      this.number);

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);

  static DateTime _dateFromJson(Timestamp date) =>
      DateTime.fromMillisecondsSinceEpoch(date.millisecondsSinceEpoch);

  static Timestamp _dateToJson(DateTime time) => Timestamp.fromDate(time);
}
