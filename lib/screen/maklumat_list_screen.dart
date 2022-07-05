import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:siakad_tpm/screen/fragment/loading.dart';
import 'package:siakad_tpm/src/model/maklumat_model.dart';

import '../src/presenter/maklumat_presenter.dart';
import '../src/state/maklumat_state.dart';
import 'fragment/maklumat/maklumat_detail_screen.dart';

class MaklumatListScreen extends StatefulWidget {
  const MaklumatListScreen({ Key? key }) : super(key: key);

  @override
  State<MaklumatListScreen> createState() => _MaklumatListScreenState();
}

class _MaklumatListScreenState extends State<MaklumatListScreen> with SingleTickerProviderStateMixin
    implements MaklumatListState {

  late AnimationController _animationController;
  late MaklumatListModel _maklumatListModel;
  late MaklumatPresenter _maklumatPresenter;

  _MaklumatListScreenState() {
    _maklumatPresenter = MaklumatPresenter();
  }

  @override
  void initState() {
    super.initState();
    _maklumatPresenter.view = this;
    _animationController = AnimationController(vsync: this);
    _maklumatPresenter.getData();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _maklumatListModel.isloading
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
                      'Maklumat',
                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              ),

              _maklumatListModel.maklumat.isEmpty
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
              : Expanded(child: Container(
                padding: const EdgeInsets.all(20),
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
                          itemCount: _maklumatListModel.maklumat.length,
                          scrollDirection: Axis.vertical,
                          primary: false,
                          shrinkWrap: true,
                          physics:
                              const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context,
                                int index) =>
                            Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 8.0),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(
                                            builder: (_) => MaklumatDetailScreen(
                                              title: _maklumatListModel
                                                    .maklumat[index].title,
                                              image: _maklumatListModel
                                                    .maklumat[index].thumbnail,
                                              author: _maklumatListModel
                                                    .maklumat[index].userName,
                                              date: _maklumatListModel
                                                    .maklumat[index].date,
                                              text: _maklumatListModel
                                                    .maklumat[index].content,
                                            ),
                                          ),);
                                        },
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 130,
                                              height: 80,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Image.network(
                                                  'https://sis.mindotek.com/assets/images/posts/' +
                                                      _maklumatListModel
                                                          .maklumat[index]
                                                          .thumbnail,
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
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    _maklumatListModel
                                                        .maklumat[index]
                                                        .titleExcerpt,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  const Text(
                                                    '20-06-2022',
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ],
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
              ))
            ],
          ),
        ),
      )
    );
  }

  @override
  void onError(String error) {
    
  }

  @override
  void onSuccess(String success) {
    
  }

  @override
  void refreshData(MaklumatListModel maklumatListModel) {
    setState(() {
      _maklumatListModel = maklumatListModel;
    });
  }
}