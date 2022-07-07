import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:siakad_tpm/screen/fragment/loading.dart';
import 'package:siakad_tpm/screen/fragment/store/custom_text.dart';
import 'package:siakad_tpm/src/model/checkout_model.dart';
import 'package:siakad_tpm/src/model/shopping_cart_model.dart';
import 'package:siakad_tpm/src/presenter/checkout_presenter.dart';

import '../../../src/state/checkout_state.dart';

class CheckoutScreen extends StatefulWidget {
  final ShoppingCartModel shoppingCartModel;
  const CheckoutScreen({Key? key, required this.shoppingCartModel})
      : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen>
    implements CheckoutState {
  late CheckoutModel _checkoutModel;
  late CheckoutPresenter _checkoutPresenter;
  final currencyFormatter = NumberFormat.currency(locale: 'ID');

  _CheckoutScreenState() {
    _checkoutPresenter = CheckoutPresenter();
  }

  @override
  void initState() {
    super.initState();
    _checkoutPresenter.view = this;
  }

  @override
  void dispose() {
    super.dispose();
    _checkoutModel.selectedBank = "";
    _checkoutModel.admin = 0;
  }

  @override
  Widget build(BuildContext context) {
    return _checkoutModel.isloading
        ? const Loading()
        : SafeArea(
            child: Scaffold(
            body: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: double.infinity,
              child: Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.only(top: 30, left: 20, right: 20),
                    child: Row(children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop(true);
                        },
                        child: const Icon(LineIcons.arrowLeft),
                      )
                    ]),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      height: double.infinity,
                      color: const Color(0xffecedf2),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              child: const Text(
                                'Invoice',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Container(
                              child: Text(
                                'Nama Santri : ' +
                                    widget.shoppingCartModel.namaSantri,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text('ADM PONPES'),
                                ],
                              ),
                            ),
                            Container(
                              height: 110,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 7,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ]),
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: const Text(
                                      'Harga Paket',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(
                                          currencyFormatter.format(widget
                                              .shoppingCartModel.totalHarga),
                                          style: const TextStyle(
                                              color: Colors.red,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              'Metode Pembayaran',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            buildCard(
                              'Bank Transfer',
                            ),
                            const Divider(color: Colors.black),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(8),
                    child: GestureDetector(
                      onTap: () {
                        if (_checkoutModel.selectedBank == '') {
                          Fluttertoast.showToast(
                              msg: "Metode pembayaran\n harus dipilih",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          _checkoutPresenter.checkout(widget.shoppingCartModel);
                        }
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
                                text: 'Checkout',
                                color: Colors.white,
                                size: 22,
                                weight: FontWeight.bold,
                              ),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ));
  }

  Widget buildCard(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
      child: Card(
        child: ExpandablePanel(
          header: const Center(
            child: Text(
              'Pilih Metode Pembayaran',
              softWrap: true,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          collapsed: const Text(
            '',
            softWrap: false,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          expanded: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                child: Text(
                  'Transfer Bank',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _checkoutModel.selectedBank = 'BCA';
                    _checkoutModel.admin = 5000;
                  });
                },
                child: Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 7.5, top: 7.5),
                  decoration: BoxDecoration(
                      color: _checkoutModel.selectedBank == 'BCA'
                          ? Colors.grey[400]
                          : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ]),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                            width: 60,
                            margin: const EdgeInsets.all(5),
                            child: ClipRRect(
                              // borderRadius: BorderRadius.circular(10),
                              child: Image.asset('assets/icons/bca.png'),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _checkoutModel.selectedBank = 'bri';
                    _checkoutModel.admin = 4000;
                  });
                },
                child: Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 7.5, top: 7.5),
                  decoration: BoxDecoration(
                      color: _checkoutModel.selectedBank == 'bri'
                          ? Colors.grey[400]
                          : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ]),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                            width: 60,
                            margin: const EdgeInsets.all(5),
                            child: ClipRRect(
                              // borderRadius: BorderRadius.circular(10),
                              child: Image.asset('assets/icons/bri.png'),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _checkoutModel.selectedBank = 'permata';
                    _checkoutModel.admin = 4000;
                  });
                },
                child: Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 7.5, top: 7.5),
                  decoration: BoxDecoration(
                      color: _checkoutModel.selectedBank == 'permata'
                          ? Colors.grey[400]
                          : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ]),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                            width: 60,
                            margin: const EdgeInsets.all(5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                  'https://storage.googleapis.com/go-merchant-production.appspot.com/uploads/2020/09/3809ed0cf7907054f860ef4f64529ba0_bc5e15f9d4b3eedc3d459c45e2df7709_compressed.png'),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _checkoutModel.selectedBank = 'bni';
                    _checkoutModel.admin = 4000;
                  });
                },
                child: Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 7.5, top: 7.5),
                  decoration: BoxDecoration(
                      color: _checkoutModel.selectedBank == 'bni'
                          ? Colors.grey[400]
                          : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ]),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                            width: 60,
                            margin: const EdgeInsets.all(5),
                            child: ClipRRect(
                              // borderRadius: BorderRadius.circular(10),
                              child: Image.asset('assets/icons/bni.png'),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _checkoutModel.selectedBank = 'mandiri';
                    _checkoutModel.admin = 4000;
                  });
                },
                child: Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 7.5, top: 7.5),
                  decoration: BoxDecoration(
                      color: _checkoutModel.selectedBank == 'mandiri'
                          ? Colors.grey[400]
                          : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ]),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                            width: 60,
                            margin: const EdgeInsets.all(5),
                            child: ClipRRect(
                              // borderRadius: BorderRadius.circular(10),
                              child: Image.asset('assets/icons/mandiri.png'),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _checkoutModel.selectedBank = 'BSI';
                    _checkoutModel.admin = 5000;
                  });
                },
                child: Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 7.5, top: 7.5),
                  decoration: BoxDecoration(
                      color: _checkoutModel.selectedBank == 'BSI'
                          ? Colors.grey[400]
                          : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ]),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                            width: 60,
                            margin: const EdgeInsets.all(5),
                            child: ClipRRect(
                              // borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                  'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Bank_Syariah_Indonesia.svg/2560px-Bank_Syariah_Indonesia.svg.png'),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                child: Text(
                  'E-Money',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _checkoutModel.selectedBank = 'gopay';
                    _checkoutModel.admin = 1000;
                  });
                },
                child: Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 7.5, top: 7.5),
                  decoration: BoxDecoration(
                      color: _checkoutModel.selectedBank == 'gopay'
                          ? Colors.grey[400]
                          : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ]),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                            width: 60,
                            margin: const EdgeInsets.all(5),
                            child: ClipRRect(
                              // borderRadius: BorderRadius.circular(10),
                              child: Image.asset('assets/icons/gopay.png'),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _checkoutModel.selectedBank = 'dana';
                    _checkoutModel.admin = 1000;
                  });
                },
                child: Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 7.5, top: 7.5),
                  decoration: BoxDecoration(
                      color: _checkoutModel.selectedBank == 'dana'
                          ? Colors.grey[400]
                          : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ]),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                            width: 60,
                            margin: const EdgeInsets.all(5),
                            child: ClipRRect(
                              // borderRadius: BorderRadius.circular(10),
                              child: Image.asset('assets/icons/dana.png'),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _checkoutModel.selectedBank = 'ovo';
                    _checkoutModel.admin = 1000;
                  });
                },
                child: Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 7.5, top: 7.5),
                  decoration: BoxDecoration(
                      color: _checkoutModel.selectedBank == 'ovo'
                          ? Colors.grey[400]
                          : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ]),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                            width: 43,
                            margin: const EdgeInsets.all(5),
                            child: ClipRRect(
                              // borderRadius: BorderRadius.circular(10),
                              child: SvgPicture.network(
                                'https://dashboard.xendit.co/assets/images/ovo-logo.svg',
                                width: 45,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _checkoutModel.selectedBank = 'shopeepay';
                    _checkoutModel.admin = 1000;
                  });
                },
                child: Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 7.5, top: 7.5),
                  decoration: BoxDecoration(
                      color: _checkoutModel.selectedBank == 'shopeepay'
                          ? Colors.grey[400]
                          : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ]),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                            width: 42,
                            margin: const EdgeInsets.all(5),
                            child: ClipRRect(
                              // borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                  'https://storage.googleapis.com/go-merchant-production.appspot.com/uploads/2020/10/f7fb2e0ab8572355142dba33ddc7b8d6_0747205be87147c03d04217ad4eb06c3_compressed.png'),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                child: Text(
                  'Credit Card',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _checkoutModel.selectedBank = 'credit_card';
                    _checkoutModel.admin = 4000;
                  });
                },
                child: Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 7.5, top: 7.5),
                  decoration: BoxDecoration(
                      color: _checkoutModel.selectedBank == 'credit_card'
                          ? Colors.grey[400]
                          : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ]),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: SizedBox(
                            width: 38,
                            child: ClipRRect(
                              // borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                'https://www.xendit.co/wp-content/uploads/2019/12/Mastercard-logo.png',
                                width: 36,
                              ),
                            )),
                      ),
                      Center(
                        child: SizedBox(
                            width: 38,
                            child: ClipRRect(
                              // borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                'https://www.xendit.co/wp-content/uploads/2019/12/Visa-logo.png',
                                width: 36,
                              ),
                            )),
                      ),
                      Center(
                        child: SizedBox(
                            width: 38,
                            child: ClipRRect(
                              // borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                'https://www.xendit.co/wp-content/uploads/2019/12/JCB-logo.png',
                                width: 36,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                child: Text(
                  'Store',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _checkoutModel.selectedBank = 'alfamart_pay';
                    _checkoutModel.admin = 5000;
                  });
                },
                child: Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 7.5, top: 7.5),
                  decoration: BoxDecoration(
                      color: _checkoutModel.selectedBank == 'alfamart_pay'
                          ? Colors.grey[400]
                          : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ]),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                            width: 42,
                            margin: const EdgeInsets.all(5),
                            child: ClipRRect(
                              // borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                  'https://storage.googleapis.com/go-merchant-production.appspot.com/uploads/2020/09/0b49d7de63b2367e0515c1283060f64e_c16ca417c1f390206d3ccc6785df8f19_compressed.png'),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onError(String error) {}

  @override
  void onSuccess(String success) {}

  @override
  void refreshData(CheckoutModel checkoutModel) {
    setState(() {
      _checkoutModel = checkoutModel;
    });
  }
}
