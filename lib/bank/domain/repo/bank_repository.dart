import 'dart:async';

import 'package:forex_290/bank/domain/models/bank_model.dart';
import 'package:forex_290/loading/domain/model/loading_model.dart';
import 'package:isar/isar.dart';

class BankRepository {
  final Isar isar;
  BankModel? bank;
  BankRepository({required this.isar});
  Future<void> saveBank({required BankModel bank}) async {
    await isar.writeTxn(() async {
      await isar.bankModels.put(bank);
    });
  }

  Future<BankModel?> getBank({StreamController<VLoading>? controller}) async {
    bank = await isar.bankModels.where().findFirst();
    if (bank == null) {
      controller?.add(VLoading.bankFalse);
    } else {
      controller?.add(VLoading.bankTrue);
    }

    return bank;
  }

  Future<void> reseteHistory() async {
    await isar.writeTxn(() async {
      await isar.bankModels.clear();
    });
  }

  Future<void> update(BankModel bank) async {
    await isar.writeTxn(() async {
      await isar.bankModels.put(bank);
    });
  }

  static String overpayment(
      {required double? price, required double? persent}) {
    if (price == null || persent == null) return '0';
    return (price * persent / 100).toStringAsFixed(2);
  }

  static double overpaymentDouble(
      {required double? price, required double? persent}) {
    if (price == null || persent == null) return 0;
    return price * persent / 100;
  }

  static String painmant(
      {required double? price,
      required double? persent,
      required int? period}) {
    if (price == null || persent == null || period == null) return '0';
    return (((price * persent / 100) + price) / (period * 12))
        .toStringAsFixed(2);
  }
}
