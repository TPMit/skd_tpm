// ignore_for_file: avoid_print

import 'package:siakad_tpm/src/model/maklumat_model.dart';
import 'package:siakad_tpm/src/resources/maklumatApi.dart';

import '../state/maklumat_state.dart';

abstract class MaklumatPresenterAbstract {
  set view(MaklumatListState view) {}
  void getDataLimit() {}
}

class MaklumatPresenter implements MaklumatPresenterAbstract {
  final MaklumatListModel _maklumatListModel = MaklumatListModel();
  late MaklumatListState _maklumatListState;
  final MaklumatServices _maklumatServices = MaklumatServices();

  @override
  set view(MaklumatListState view) {
    _maklumatListState = view;
    _maklumatListState.refreshData(_maklumatListModel);
  }

  @override
  void getDataLimit() {
    _maklumatListModel.isloading = true;
    _maklumatListState.refreshData(_maklumatListModel);
  _maklumatServices.getDataLimit().then((value) {
  for (var element in value.dataMaklumat!) {
    _maklumatListModel.maklumat.add( Maklumat(
      categoryName: element.categoryName.toString(),
      content: element.content.toString(),
      id: element.id.toString(),
      slug: element.slug.toString(),
      thumbnail: element.thumbnail.toString(),
      title: element.title.toString(),
      titleExcerpt: element.titleExcerpt.toString(),
      userName: element.userName.toString(),
    ));
    _maklumatListModel.isloading = false;
    _maklumatListState.refreshData(_maklumatListModel);
   }
  }).catchError((error){
    print(error.toString());
    _maklumatListState.onError(error.toString());
    _maklumatListModel.isloading = false;
    _maklumatListState.refreshData(_maklumatListModel);
  });
  }

  
}