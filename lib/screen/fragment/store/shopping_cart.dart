// ignore_for_file: avoid_unnecessary_containers

import 'package:dropdown_search/dropdown_search.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:siakad_tpm/screen/fragment/store/checkout_screen.dart';
import 'package:siakad_tpm/screen/fragment/loading.dart';
import 'package:siakad_tpm/screen/fragment/store/custom_text.dart';
import 'package:siakad_tpm/src/model/santri_list_model.dart';
import 'package:siakad_tpm/src/state/shopping_cart_state.dart';

import '../../../src/model/shopping_cart_model.dart';
import '../../../src/presenter/shopping_cart_presenter.dart';
import 'package:siakad_tpm/helper/getStorage.dart' as constant;

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart>
    implements ShoppingCartState {
  late ShoppingCartModel _shoppingCartModel;
  late ShoppingCartPresenter _shoppingCartPresenter;
  late String selectedBank = '';
  late int admin = 0;
  final currencyFormatter = NumberFormat.currency(locale: 'ID');

  _ShoppingCartState() {
    _shoppingCartPresenter = ShoppingCartPresenter();
  }

  @override
  void initState() {
    _shoppingCartPresenter.view = this;
    super.initState();
    _shoppingCartPresenter.getCart(GetStorage().read(constant.idUser));
  }

  @override
  void dispose() {
    super.dispose();
    _shoppingCartModel.getCartResponse.dataCart!.clear();
    _shoppingCartModel.namaSantri = "";
    _shoppingCartModel.idSantri = "";
    _shoppingCartModel.selectedBank = "";
    _shoppingCartModel.totalHarga = 0;
  }

  @override
  Widget build(BuildContext context) {
    return _shoppingCartModel.isloading
        ? const Loading()
        : SafeArea(
            child: Scaffold(
              body: Stack(
                children: [
                  ListView(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Center(
                        child: CustomText(
                          text: "Shopping Cart",
                          size: 24,
                          weight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      _shoppingCartModel.getCartResponse.dataCart!.isEmpty
                          ? Container(
                              padding: const EdgeInsets.only(top: 25.0),
                              child: Center(
                                child: Text('Belum Ada data',
                                    style: GoogleFonts.poppins(
                                      fontStyle: FontStyle.italic,
                                      textStyle: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff1f1f1f)),
                                    )),
                              ))
                          : ListView.builder(
                              itemCount: _shoppingCartModel
                                  .getCartResponse.dataCart!.length,
                              scrollDirection: Axis.vertical,
                              primary: false,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, index) => Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.network(
                                          'https://sis.mindotek.com/assets/images/products/' +
                                              _shoppingCartModel
                                                  .getCartResponse
                                                  .dataCart![index]
                                                  .images![0]
                                                  .fileName
                                                  .toString(),
                                          width: 50,
                                          height: 50,
                                        ),
                                      ),
                                      Expanded(
                                          child: Wrap(
                                        direction: Axis.vertical,
                                        children: [
                                          Container(
                                              padding: const EdgeInsets.only(
                                                  left: 14),
                                              child: CustomText(
                                                text: _shoppingCartModel
                                                    .getCartResponse
                                                    .dataCart![index]
                                                    .title
                                                    .toString(),
                                                color: Colors.black,
                                                size: 14,
                                                weight: FontWeight.normal,
                                              )),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              IconButton(
                                                  icon: const Icon(
                                                      Icons.chevron_left),
                                                  onPressed: () {
                                                    _shoppingCartPresenter.qty(
                                                        0,
                                                        index,
                                                        _shoppingCartModel
                                                            .getCartResponse
                                                            .dataCart![index]
                                                            .idCart
                                                            .toString(),
                                                        GetStorage().read(
                                                            constant.idUser));
                                                  }),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: CustomText(
                                                  text: _shoppingCartModel
                                                      .getCartResponse
                                                      .dataCart![index]
                                                      .qty
                                                      .toString(),
                                                  color: Colors.black,
                                                  size: 14,
                                                  weight: FontWeight.bold,
                                                ),
                                              ),
                                              IconButton(
                                                  icon: const Icon(
                                                      Icons.chevron_right),
                                                  onPressed: () {
                                                    _shoppingCartPresenter.qty(
                                                        1,
                                                        index,
                                                        _shoppingCartModel
                                                            .getCartResponse
                                                            .dataCart![index]
                                                            .idCart
                                                            .toString(),
                                                        GetStorage().read(
                                                            constant.idUser));
                                                  }),
                                            ],
                                          )
                                        ],
                                      )),
                                      Padding(
                                        padding: const EdgeInsets.all(14),
                                        child: CustomText(
                                          text: "Rp." +
                                              _shoppingCartModel.getCartResponse
                                                  .dataCart![index].price
                                                  .toString(),
                                          size: 18,
                                          weight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  )),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        child: DropdownSearch<Santri>(
                          mode: Mode.DIALOG,
                          showSearchBox: true,
                          onFind: (text) async {
                            if (_shoppingCartModel.santri.isEmpty) {
                              return [];
                            }
                            return _shoppingCartModel.santri;
                          },
                          popupItemBuilder: (context, item, isSelected) =>
                              ListTile(
                            title: Text(item.name),
                          ),
                          onChanged: (value) {
                            _shoppingCartPresenter.addIdSantri(
                                value!.idSantri.toString(),
                                value.name.toString());
                          },
                          dropdownBuilder: (context, selectedItem) => Text(
                              selectedItem?.name ?? "Silahkan Pilih Santri"),
                        ),
                      )
                    ],
                  ),
                  Positioned(
                      bottom: 30,
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(8),
                            child: GestureDetector(
                              onTap: () {
                                if (_shoppingCartModel.idSantri == "") {
                                  return onError("santri harus dipilih dulu");
                                }
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CheckoutScreen(
                                        shoppingCartModel: _shoppingCartModel,
                                      ),
                                    ));
                              },
                              child: PhysicalModel(
                                color: Colors.grey.withOpacity(.4),
                                elevation: 2,
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color(0XFF4CACBC),
                                    ),
                                    child: Container(
                                      margin: const EdgeInsets.all(14),
                                      alignment: Alignment.center,
                                      child: const CustomText(
                                        text: 'Bayar',
                                        color: Colors.white,
                                        size: 22,
                                        weight: FontWeight.bold,
                                      ),
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          );
  }

  @override
  void onError(String error) {
    Fluttertoast.showToast(
        msg: error,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 15);
  }

  @override
  void onSuccess(String success) {
    Fluttertoast.showToast(
        msg: success,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.green,
        textColor: Colors.black,
        fontSize: 15);
  }

  @override
  void refreshData(ShoppingCartModel shoppingCartModel) {
    setState(() {
      _shoppingCartModel = shoppingCartModel;
    });
  }
}
