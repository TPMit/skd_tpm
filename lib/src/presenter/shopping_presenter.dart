// ignore_for_file: avoid_print

import 'package:siakad_tpm/src/model/shopping_model.dart';
import 'package:siakad_tpm/src/resources/shoppingApi.dart';
import 'package:siakad_tpm/src/state/shopping_state.dart';

abstract class ShoppingPresenterAbstract {
  set view(ShoppingState view) {}
  void getData(String userId) {}
  void addCart(String userId, String productId) {}
  void getCart(String userId) {}
}

class ShoppingPresenter implements ShoppingPresenterAbstract {
  final ShoppingModel _shoppingModel = ShoppingModel();
  late ShoppingState _shoppingState;
  final ShoppingServices _shoppingServices = ShoppingServices();
  
  @override
  set view(ShoppingState view) {
    _shoppingState = view;
    _shoppingState.refreshData(_shoppingModel);
  }

  @override
  void getData(String userId) {
    _shoppingModel.isloading = true;
    _shoppingState.refreshData(_shoppingModel);
    _shoppingServices.getDataProduct().then((value) {
        _shoppingModel.productResponse = value;
        _shoppingModel.isloading = false;
        _shoppingState.refreshData(_shoppingModel);
    }).catchError((error){
      print(error.toString());
      _shoppingState.onError(error.toString());
      _shoppingModel.isloading = false;
      _shoppingState.refreshData(_shoppingModel);
    });
  }

  @override
  void addCart(String userId, String productId) {
    print('userId: '+userId);
    print('productId: ' + productId);
    _shoppingModel.isloading = true;
    _shoppingState.refreshData(_shoppingModel);
    _shoppingServices.addCart(userId, productId).then((value) {
      _shoppingState.onSuccess(value);
      _shoppingModel.isloading = false;
      _shoppingState.refreshData(_shoppingModel);
  }).catchError((error){
    print(error.toString());
    _shoppingState.onError(error.toString());
    _shoppingModel.isloading = false;
    _shoppingState.refreshData(_shoppingModel);
  });
  }

  @override
  void getCart(String userId) {
    _shoppingModel.isloading = true;
    _shoppingState.refreshData(_shoppingModel);
    _shoppingServices.getcart(userId).then((c) {
      _shoppingModel.getCartResponse = c;
      _shoppingModel.isloading = false;
      _shoppingState.refreshData(_shoppingModel);
    }).catchError((error) {
      print(error.toString());
      _shoppingState.onError(error.toString());
      _shoppingModel.isloading = false;
      _shoppingState.refreshData(_shoppingModel);
    });
  }
  
}