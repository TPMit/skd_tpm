import '../model/checkout_model.dart';

abstract class CheckoutState {
  void onSuccess(String success);
  void onError(String error);
  void refreshData(CheckoutModel checkoutModel);
}
