// ignore_for_file: file_names

import 'package:siakad_tpm/src/model/transaksi_history_model.dart';
import 'package:siakad_tpm/src/state/transaksi_history_state.dart';



import '../resources/shoppingApi.dart';

abstract class TransaksiHistoryPresenterAbstract {
  set view(TransaksiHistoryState view) {}
  void getData(String idUser) {}
}

class TransaksiHistoryPresenter implements TransaksiHistoryPresenterAbstract {
  final TransaksiHistoryModel _transaksiHistoryModel = TransaksiHistoryModel();
  late TransaksiHistoryState _transaksiHistoryState;
  final ShoppingServices _shoppingServices = ShoppingServices();
  
  @override
  void getData(String idUser) {
    _transaksiHistoryModel.isloading = true;
    _transaksiHistoryState.refreshData(_transaksiHistoryModel);
    _shoppingServices.getTransaksiHistory(idUser).then((value) {
      for (var element in value.dataTransaction!) {
        _transaksiHistoryModel.transaksi.add( Transaksi(
          harga: element.grossAmount.toString(),
          id: element.id.toString(),
          statusPaid: element.statusPaid.toString(),
          totalItem: element.totalItem.toString(),
          createdAt: element.createdAt.toString()
        ));
      }
      _transaksiHistoryModel.isloading = false;
      _transaksiHistoryState.refreshData(_transaksiHistoryModel);
    }).catchError((error){
      _transaksiHistoryState.onError(error);
      _transaksiHistoryModel.isloading = false;
      _transaksiHistoryState.refreshData(_transaksiHistoryModel);
    });
  }

  @override
  set view(TransaksiHistoryState view) {
    _transaksiHistoryState = view;
    _transaksiHistoryState.refreshData(_transaksiHistoryModel);
  }
  
}