// ignore_for_file: avoid_print

import 'package:siakad_tpm/src/model/santri_list_model.dart';
import 'package:siakad_tpm/src/model/shopping_cart_model.dart';
import 'package:siakad_tpm/src/resources/santriApi.dart';
import 'package:siakad_tpm/src/state/shopping_cart_state.dart';
import 'package:get_storage/get_storage.dart';
import 'package:siakad_tpm/helper/getStorage.dart' as constant;

import '../resources/shoppingApi.dart';

abstract class ShoppingCartPresenterAbstract {
  set view(ShoppingCartState view) {}
  void getCart(String userId) {}
  void qty(int status, int index, String idCart, String idUser) {}
  void addIdSantri(String idSantri, String namaSantri) {}
}

class ShoppingCartPresenter implements ShoppingCartPresenterAbstract {
  final ShoppingCartModel _shoppingCartModel = ShoppingCartModel();
  late ShoppingCartState _shoppingCartState;
  final ShoppingServices _shoppingServices = ShoppingServices();
  final SantriServices _santriServices = SantriServices();

  @override
  set view(ShoppingCartState view) {
    _shoppingCartState = view;
    _shoppingCartState.refreshData(_shoppingCartModel);
  }

  @override
  void getCart(String userId) {
    _shoppingCartModel.isloading = true;
    _shoppingCartState.refreshData(_shoppingCartModel);
    _shoppingServices.getcart(userId).then((c) {
      _shoppingCartModel.getCartResponse = c;

      //get santri
      _santriServices.getData(GetStorage().read(constant.idUser)).then((value) {
        for (var element in value.dataSantri!) {
          _shoppingCartModel.santri.add(Santri(
            email: element.email.toString(),
            idSantri: element.idSantri.toString(),
            images: element.images.toString(),
            jenisKelamin: element.jenisKelamin.toString(),
            name: element.name.toString(),
            nis: element.nis.toString(),
            roleId: element.roleId.toString(),
            saldo: element.saldo.toString(),
            tanggalLahir: element.tanggalLahir.toString(),
            tempatLahir: element.tempatLahir.toString(),
            status: element.status.toString(),
          ));
        }
        _shoppingCartModel.isloading = false;
        _shoppingCartState.refreshData(_shoppingCartModel);
      }).catchError((error) {
        _shoppingCartState.onError(error);
        _shoppingCartModel.isloading = false;
        _shoppingCartState.refreshData(_shoppingCartModel);
      });
    }).catchError((error) {
      print(error.toString());
      _shoppingCartState.onError(error.toString());
      _shoppingCartModel.isloading = false;
      _shoppingCartState.refreshData(_shoppingCartModel);
    });
  }

  @override
  void qty(int status, int index, String idCart, String idUser) {
    print(status);
    if (status == 1) {
      // print(1);
      _shoppingCartModel.isloading = true;
      _shoppingCartState.refreshData(_shoppingCartModel);
      _shoppingCartModel.getCartResponse.dataCart![index].qty++;
      _shoppingCartModel.isloading = false;
      _shoppingCartState.refreshData(_shoppingCartModel);
    } else {
      // print(0);
      _shoppingCartModel.isloading = true;
      _shoppingCartState.refreshData(_shoppingCartModel);
      if (_shoppingCartModel.getCartResponse.dataCart![index].qty == 1) {
        print('otw delete cart');
        _shoppingServices.deleteCart(idCart).then((value) {
          _shoppingCartState.onSuccess(value);
          getCart(idUser);
        }).catchError((error) {
          _shoppingCartState.onError(error);
          _shoppingCartModel.isloading = false;
          _shoppingCartState.refreshData(_shoppingCartModel);
        });
      } else {
        _shoppingCartModel.getCartResponse.dataCart![index].qty--;
        _shoppingCartModel.isloading = false;
        _shoppingCartState.refreshData(_shoppingCartModel);
      }
    }
  }

  @override
  void addIdSantri(String idSantri, namaSantri) {
    _shoppingCartModel.totalHarga = 0;
    _shoppingCartModel.isloading = true;
    _shoppingCartState.refreshData(_shoppingCartModel);
    print('===' + idSantri);
    print('===' + namaSantri);
    _shoppingCartModel.idSantri = idSantri;
    _shoppingCartModel.namaSantri = namaSantri;
    for (var element in _shoppingCartModel.getCartResponse.dataCart!) {
      _shoppingCartModel.totalHarga += int.parse(element.price.toString());
    }
    print('id santri berhasil ditambah ');
    _shoppingCartModel.isloading = false;
    _shoppingCartState.refreshData(_shoppingCartModel);
  }
}
