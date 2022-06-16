import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:siakad_tpm/screen/fragment/loading.dart';
import 'package:siakad_tpm/src/model/shopping_model.dart';
import 'package:siakad_tpm/src/presenter/shopping_presenter.dart';

import '../src/state/shopping_state.dart';
import 'fragment/store/custom_text.dart';
import 'fragment/store/shopping_cart.dart';

class ShoopingScreen extends StatefulWidget {
  const ShoopingScreen({ Key? key }) : super(key: key);

  @override
  State<ShoopingScreen> createState() => _ShoopingScreenState();
}

class _ShoopingScreenState extends State<ShoopingScreen> implements ShoppingState {
  late ShoppingModel _shoppingModel;
  late ShoppingPresenter _shoppingPresenter;

  _ShoopingScreenState() {
    _shoppingPresenter = ShoppingPresenter();
  }

  @override
  void initState() {
    _shoppingPresenter.view = this;
    super.initState();
    _shoppingPresenter.getData();
  }
  
  @override
  Widget build(BuildContext context) {
    return _shoppingModel.isloading
    ? const Loading()
    : Scaffold(
      appBar: buildAppBar(),
      body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          "Kebutuhan Santri",
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 2 / 2,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20),
                        itemCount:
                            _shoppingModel.productResponse.dataProduct!.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return GestureDetector(
                            onTap: () {},
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    // For  demo we use fixed height  and width
                                    // Now we dont need them
                                    // height: 180,
                                    // width: 160,
                                    decoration: BoxDecoration(
                                      color: const Color(0XFFA0D995),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Hero(
                                      tag:
                                          "${_shoppingModel.productResponse.dataProduct![index].categoryTitle}",
                                      child: Image.network(
                                        'https://sis.mindotek.com/assets/images/products/' +
                                            _shoppingModel
                                                .productResponse
                                                .dataProduct![index]
                                                .images![0]
                                                .fileName
                                                .toString(),
                                        height: 300,
                                        width: 300,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20 / 4),
                                  child: Text(
                                    // products is out demo list
                                    _shoppingModel.productResponse
                                        .dataProduct![index].title
                                        .toString(),
                                    style: const TextStyle(
                                        color: Color(0xFFACACAC)),
                                  ),
                                ),
                                Text(
                                  "Rp. ${_shoppingModel.productResponse.dataProduct![index].price}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          );
                        }),
        ),
      ),
      ],
    )
    );
  }

   AppBar buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0XFFA0D995),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, size: 24,),
        onPressed: () {
          Navigator.of(context).pop(true);
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {
            showBarModalBottomSheet(
              context: context,
              builder: (context) => Container(
                color: Colors.white,
                child: const ShoppingCartWidget(),
              ),
            );
          },
        ),
        const SizedBox(width: 20 / 2)
      ],
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
        backgroundColor: Colors.amber,
        textColor: Colors.white,
        fontSize: 15);
  }

  @override
  void refreshData(ShoppingModel shoppingModel) {
    setState(() {
      _shoppingModel = shoppingModel;
    });
  }
}