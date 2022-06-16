import '../model/shopping_model.dart';

abstract class ShoppingState {
  void onSuccess(String success);
  void onError(String error);
  void refreshData(ShoppingModel shoppingModel);
}
