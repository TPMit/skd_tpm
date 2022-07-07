// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:siakad_tpm/src/model/maklumat_model.dart';
import 'package:siakad_tpm/src/presenter/maklumat_presenter.dart';

import '../../../src/state/maklumat_state.dart';
import '../maklumat/maklumat_detail_screen.dart';

class MaklumatWidget extends StatefulWidget {
  const MaklumatWidget({Key? key}) : super(key: key);

  @override
  State<MaklumatWidget> createState() => _MaklumatWidgetState();
}

class _MaklumatWidgetState extends State<MaklumatWidget>
    with SingleTickerProviderStateMixin
    implements MaklumatListState {
  late AnimationController _animationController;
  late MaklumatListModel _maklumatListModel;
  late MaklumatPresenter _maklumatPresenter;

  _MaklumatWidgetState() {
    _maklumatPresenter = MaklumatPresenter();
  }

  @override
  void initState() {
    super.initState();
    _maklumatPresenter.view = this;
    _animationController = AnimationController(vsync: this);
    _maklumatPresenter.getDataLimit();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _maklumatListModel.isloading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MaklumatDetailScreen(
                          title: _maklumatListModel.maklumat[0].title,
                          image: _maklumatListModel.maklumat[0].thumbnail,
                          author: _maklumatListModel.maklumat[0].userName,
                          date: _maklumatListModel.maklumat[0].date,
                          text: _maklumatListModel.maklumat[0].content,
                        ),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 130,
                        height: 80,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            'https://sis.mindotek.com/assets/images/posts/' +
                                _maklumatListModel.maklumat[0].thumbnail,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _maklumatListModel.maklumat[0].titleExcerpt,
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
              const SizedBox(
                height: 20.0,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MaklumatDetailScreen(
                          title: _maklumatListModel.maklumat[1].title,
                          image: _maklumatListModel.maklumat[1].thumbnail,
                          author: _maklumatListModel.maklumat[1].userName,
                          date: _maklumatListModel.maklumat[1].date,
                          text: _maklumatListModel.maklumat[1].content,
                        ),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 130,
                        height: 80,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            'https://sis.mindotek.com/assets/images/posts/' +
                                _maklumatListModel.maklumat[1].thumbnail,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _maklumatListModel.maklumat[1].titleExcerpt,
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
              )
            ],
          );
  }

  @override
  void onError(String error) {}

  @override
  void onSuccess(String success) {}

  @override
  void refreshData(MaklumatListModel maklumatListModel) {
    setState(() {
      _maklumatListModel = maklumatListModel;
    });
  }
}
