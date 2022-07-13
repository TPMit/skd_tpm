// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:siakad_tpm/src/model/checkout_model.dart';
import 'package:siakad_tpm/src/model/shopping_cart_model.dart';
import 'package:siakad_tpm/src/state/checkout_state.dart';
import 'package:get_storage/get_storage.dart';
import 'package:siakad_tpm/helper/getStorage.dart' as constant;

import '../resources/checkoutApi.dart';

abstract class CheckoutPresenterAbstract {
  set view(CheckoutState view) {}
  void checkout(ShoppingCartModel shoppingCartModel) {}
}

class CheckoutPresenter implements CheckoutPresenterAbstract {
  final CheckoutModel _checkoutModel = CheckoutModel();
  late CheckoutState _checkoutState;
  final CheckoutServices _checkoutServices = CheckoutServices();

  @override
  void checkout(ShoppingCartModel shoppingCartModel) {
    print('===');
    print(_checkoutModel.selectedBank);
    for (var element in shoppingCartModel.getCartResponse.dataCart!) {
      _checkoutModel.productId.add(element.id);
      _checkoutModel.price.add(element.price);
      _checkoutModel.totalItem.add(element.qty.toString());
      _checkoutModel.idCart.add(element.idCart);
    }
    print('mulai post');
    // Map<String, dynamic> body = {
    //   "user_id": GetStorage().read(constant.idUser),
    //   "amount": shoppingCartModel.totalHarga.toString(),
    //   "payment_type": _checkoutModel.selectedBank,
    //   "product_id": _checkoutModel.productId,
    //   "price": _checkoutModel.price,
    //   "total_item": _checkoutModel.totalItem,
    //   "id_cart": _checkoutModel.idCart,
    //   "santri_id": shoppingCartModel.idSantri,
    // };
    // print(json.encode(body));
    _checkoutServices
        .bayarPost(
      GetStorage().read(constant.idUser),
      shoppingCartModel.totalHarga,
      _checkoutModel.selectedBank,
      _checkoutModel.productId,
      _checkoutModel.price,
      _checkoutModel.totalItem,
      _checkoutModel.idCart,
      shoppingCartModel.idSantri,
    )
        .then((value) {
      _checkoutState.onSuccess(value);
      _checkoutModel.isloading = false;
      _checkoutState.refreshData(_checkoutModel);
    }).catchError((error) {
      print(error.toString());
      _checkoutState.onError(error.toString());
      _checkoutModel.isloading = false;
      _checkoutState.refreshData(_checkoutModel);
    });
  }

  @override
  set view(CheckoutState view) {
    _checkoutState = view;
    _checkoutState.refreshData(_checkoutModel);
  }
}
