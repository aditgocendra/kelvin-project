import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kelvin_project/app/models/detail_transaction.dart';

class TransactionModel {
  int totalPay;
  String? idDocument;
  Timestamp createdAt;

  TransactionModel({required this.totalPay, required this.createdAt});

  TransactionModel.fromJson(Map<String, Object?> json)
      : this(
          totalPay: json['totalPay']! as int,
          createdAt: json['createdAt']! as Timestamp,
        );

  Map<String, Object?> toJson() {
    return {
      'totalPay': totalPay,
      'createdAt': createdAt,
    };
  }
}

class TransactionReport {
  String codeTransaction;
  List<DetailTransactionModel> detailTrans;
  Timestamp dateTransaction;
  int totalPay;

  TransactionReport({
    required this.codeTransaction,
    required this.detailTrans,
    required this.dateTransaction,
    required this.totalPay,
  });
}
