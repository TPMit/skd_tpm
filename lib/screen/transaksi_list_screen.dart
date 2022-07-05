import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:siakad_tpm/screen/fragment/loading.dart';
import 'package:siakad_tpm/src/state/transaksi_history_state.dart';

import '../helper/convertRupiah.dart';
import '../src/model/transaksi_history_model.dart';
import '../src/presenter/Transaksi_history_presenter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:siakad_tpm/helper/getStorage.dart' as constant;

class TransaksiHostoryScreen extends StatefulWidget {
  const TransaksiHostoryScreen({ Key? key }) : super(key: key);

  @override
  State<TransaksiHostoryScreen> createState() => _TransaksiHostoryScreenState();
}

class _TransaksiHostoryScreenState extends State<TransaksiHostoryScreen> implements TransaksiHistoryState {
  
  late TransaksiHistoryModel _transaksiHistoryModel;
  late TransaksiHistoryPresenter _historyPresenter;
  
  _TransaksiHostoryScreenState() {
    _historyPresenter = TransaksiHistoryPresenter();
  }

  @override
  void initState() {
    super.initState();
    _historyPresenter.view = this;
    _historyPresenter.getData(GetStorage().read(constant.idUser));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _transaksiHistoryModel.isloading
    ? const Loading()
    : SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: double.infinity,
          child: Column(
            children: [
              Container(
                color: const Color(0XFFA0D995),
                padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                height: 90,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop(true);
                      },
                      child: const Icon(LineIcons.arrowLeft, color: Colors.white,size: 30),
                    ),
                    const Text(
                      'History Transaksi',
                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              ),

              _transaksiHistoryModel.transaksi.isEmpty
              ? Container(
                padding: const EdgeInsets.only(top: 25.0),
                      child: Center(
                      child: Text('Belum Ada data',
                          style: GoogleFonts.poppins(
                            fontStyle: FontStyle.italic,
                            textStyle:
                                const TextStyle(fontSize: 14, color: Color(0xff1f1f1f)),
                          )),
                    ))
              : Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: double.infinity,
                  color: const Color(0xffecedf2),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: ListView.builder(
                                        itemCount:
                                            _transaksiHistoryModel.transaksi.length,
                                        scrollDirection: Axis.vertical,
                                        primary: false,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder:
                                            (BuildContext context, int index) =>
                                                Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 8.0),
                                          child: InkWell(
                                            onTap: () {
                                              
                                            },
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 100,
                                                  height: 80,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    child: Image.network(
                                                      'https://sis.mindotek.com/assets/images/default.png',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        _transaksiHistoryModel.transaksi[index].totalItem + " Barang",
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        _transaksiHistoryModel
                                                            .transaksi[index]
                                                            .createdAt,
                                                        style: const TextStyle(
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Text(
                                                  CurrencyFormat.convertToIdr(
                                                      int.parse(_transaksiHistoryModel.transaksi[index].harga)),
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onError(String error) {
    
  }

  @override
  void onSuccess(String success) {
    
  }

  @override
  void refreshData(TransaksiHistoryModel transaksiHistoryModel) {
    setState(() {
      _transaksiHistoryModel = transaksiHistoryModel;
    });
  }
}