import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String iconImagePath;
  final String categoryName;
  final String router;
  const CategoryCard(
      {Key? key,
      required this.iconImagePath,
      required this.categoryName,
      required this.router})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, router);
      },
      child: Ink(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0XFFA0D995),
            ),
            child: Row(
              children: [
                Image.asset(
                  iconImagePath,
                  height: 30,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(categoryName),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
