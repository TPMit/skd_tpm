import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as html_parser;

class MaklumatDetailScreen extends StatelessWidget {
  final String title;
  final String image;
  final String author;
  final String date;
  final String text;
  const MaklumatDetailScreen(
      {Key? key, required this.title,
      required this.image,
      required this.author,
      required this.date,
      required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0XFF4CACBC),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.only(top: 32),
          child: ListView(
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 16,
                    backgroundImage: AssetImage('assets/icons/user.png'),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text('$author, '),
                  Text(
                    date,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                    'https://sis.mindotek.com/assets/images/posts/' + image),
              ),
              Html(
                data: html_parser.DocumentFragment.html(text)
                    .text,
                style: {
                  "table": Style(
                    backgroundColor: const Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                  ),
                  "tr": Style(
                    border: const Border(bottom: BorderSide(color: Colors.grey)),
                  ),
                  "th": Style(
                    padding: const EdgeInsets.all(6),
                    backgroundColor: Colors.grey,
                  ),
                  "td": Style(
                    padding: const EdgeInsets.all(6),
                  ),
                  "p": Style(fontFamily: 'serif', textAlign: TextAlign.justify),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
