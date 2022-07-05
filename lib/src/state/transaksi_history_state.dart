import '../model/transaksi_history_model.dart';

abstract class TransaksiHistoryState {
  void onSuccess(String success);
  void onError(String error);
  void refreshData(TransaksiHistoryModel transaksiHistoryModel);
}
