import '../model/shopping_cart_model.dart';

abstract class ShoppingCartState {
  void onSuccess(String success);
  void onError(String error);
  void refreshData(ShoppingCartModel shoppingModel);
}
