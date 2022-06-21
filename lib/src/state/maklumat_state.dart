import 'package:siakad_tpm/src/model/maklumat_model.dart';

abstract class MaklumatListState {
  void onSuccess(String success);
  void onError(String error);
  void refreshData(MaklumatListModel maklumatListModel);
}
