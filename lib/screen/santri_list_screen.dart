import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:siakad_tpm/src/model/santri_list_model.dart';
import 'package:siakad_tpm/src/presenter/santri_list_presenter.dart';

import '../src/resources/session.dart';
import '../src/state/santri_list_state.dart';

class SantriListScreen extends StatefulWidget {
  const SantriListScreen({ Key? key }) : super(key: key);

  @override
  State<SantriListScreen> createState() => _SantriListScreenState();
}

class _SantriListScreenState extends State<SantriListScreen> implements SantriListState {

  late SantriListModel _santriListModel;
  late SantriListPresenter _santriListPresenter;

  _SantriListScreenState() {
    _santriListPresenter = SantriListPresenter();
  }

  @override
  void initState() {
    Session.getId().then((value) {
      setState(() {
        _santriListModel.idUser = int.parse(value!);
      });
    });
    _santriListPresenter.view =this;
    super.initState();
    _santriListPresenter.getData();
  }

  @override
  void dispose() {
    super.dispose();
    _santriListModel.santri.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: double.infinity,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                child: Row(
                  children: [
                    
                  ],
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
    Fluttertoast.showToast(
        msg: error,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.amber,
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
        backgroundColor: Colors.amber,
        textColor: Colors.white,
        fontSize: 15);
  }

  @override
  void refreshData(SantriListModel santriListModel) {
    _santriListModel = santriListModel;
  }
}