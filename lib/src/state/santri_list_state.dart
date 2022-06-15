import '../model/santri_list_model.dart';

abstract class SantriListState {
  void onSuccess(String success);
  void onError(String error);
  void refreshData(SantriListModel santriListModel);
}