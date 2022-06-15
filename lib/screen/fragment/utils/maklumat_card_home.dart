import 'package:flutter/material.dart';

class MaklumatCard extends StatelessWidget {
  final String maklumatImagePath;
  final String desc;
  const MaklumatCard({ Key? key, required this.maklumatImagePath, required this.desc }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('halooooo');
      },
      child: Ink(
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0, bottom: 15, right: 25.0),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0XFF6CC4A1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    maklumatImagePath,
                  height: 130,
                  ),
                ),
                const SizedBox(height: 10,),
          
                Text(desc, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xffF9F9F9),),)
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}