import 'package:get_storage/get_storage.dart';
import 'package:siakad_tpm/src/model/santri_list_model.dart';
import 'package:siakad_tpm/src/resources/santriApi.dart';
import 'package:siakad_tpm/src/state/santri_list_state.dart';
import 'package:siakad_tpm/helper/getStorage.dart' as constant;

abstract class SantriListPresenterAbstract {
  set view(SantriListState view) {}
  void getData(){}
}

class SantriListPresenter implements SantriListPresenterAbstract {
  final SantriListModel _santriListModel = SantriListModel();
  late SantriListState _santriListState;
  final SantriServices _santriServices = SantriServices();

  @override
  set view(SantriListState view) {
    _santriListState = view;
    _santriListState.refreshData(_santriListModel);
  }

  @override
  void getData() {
    print('==');
    print(GetStorage().read(constant.idUser));
    // print(GetStorage().read(constant.namaUser));
    print('===');
    _santriListModel.isloading = true;
    _santriListState.refreshData(_santriListModel);
    _santriServices.getData(GetStorage().read(constant.idUser)).then((value) {
      for (var element in value.dataSantri!) {
        _santriListModel.santri.add(Santri(
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
    });
  }

  
}