import 'package:siakad_tpm/src/model/checkout_model.dart';
import 'package:siakad_tpm/src/state/checkout_state.dart';

import '../resources/checkoutApi.dart';

abstract class CheckoutPresenterAbstract {
  set view(CheckoutState view){}
  void checkout(){}
}

class CheckoutPresenter implements CheckoutPresenterAbstract {
  final CheckoutModel _checkoutModel = CheckoutModel();
  late CheckoutState _checkoutState;
  final CheckoutServices _checkoutServices = CheckoutServices();

  @override
  void checkout() {
    
  }

  @override
  set view(CheckoutState view) {
    _checkoutState = view;
    _checkoutState.refreshData(_checkoutModel);
  }
  
}