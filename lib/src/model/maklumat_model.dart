
class Maklumat {
  String id;
  String title;
  String titleExcerpt;
  String slug;
  String thumbnail;
  String content;
  String categoryName;
  String userName;
  String date;
  Maklumat({
  required this.id,
  required this.title,
  required this.titleExcerpt,
  required this.slug,
  required this.thumbnail,
  required this.content,
  required this.categoryName,
  required this.userName,
  required this.date,
    });
}

class MaklumatListModel {
  int idUser = 0;
  bool isloading = false;
  bool isSuccess = false;
  List<Maklumat> maklumat = <Maklumat>[];
}
