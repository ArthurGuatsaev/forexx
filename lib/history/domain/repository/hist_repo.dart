import 'package:forex_290/history/domain/model/history_model.dart';
import 'package:isar/isar.dart';

class HistoryRepository {
  final Isar isar;
  HistoryRepository({required this.isar});
  Future<List<HistoryModel>> getHistoryRepo() async {
    return await isar.historyModels.where().findAll();
  }

  Future<void> saveHistory({required HistoryModel hist}) async {
    await isar.writeTxn(() async {
      await isar.historyModels.put(hist);
    });
  }

  Future<void> reseteHistory() async {
    await isar.writeTxn(() async {
      await isar.historyModels.clear();
    });
  }
}
