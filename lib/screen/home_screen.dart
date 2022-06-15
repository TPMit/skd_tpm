// ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad_tpm/screen/fragment/utils/category_card_home.dart';
import 'package:siakad_tpm/screen/fragment/utils/maklumat_card_home.dart';

import '../src/resources/session.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username = "user";

  _HomePageState(){
    Session.checkUser().then((check) {
      if (check) {
      } else {
        Navigator.pushReplacementNamed(context, "/landing");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    Session.getName().then((value) {
      setState(() {
        username = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2EBE9),
      body: SafeArea(
        child: Column(
          children: [
            //app bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      //name
                      const Text('hello,',
                      style: TextStyle(fontWeight: FontWeight.bold,
                      fontSize: 18),
                      ),
                      const SizedBox(height: 8,),
                      Text(username.toString(),
                      style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),),
                    ],
                  ),

                  //Profile Picture
                  InkWell(
                    onTap: () async{
                      SharedPreferences preferences = await SharedPreferences.getInstance();
                      preferences.clear();
                      GetStorage().erase();
                      Navigator.pushNamed(context, "/");
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      child: const InkWell(
                        child: Icon(Icons.person, color: Colors.white,)),
                      decoration: BoxDecoration(
                        color: const Color(0XFF4CACBC),
                        borderRadius: BorderRadius.circular(12) 
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25,),

            //card -> hhow do you feel?
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0XFFA0D995),
                  borderRadius: BorderRadius.circular(12)
                ), 
                child: Row(
                  children: [
                    //animation or picture
                    Container(
                      padding: const EdgeInsets.all(12),
                      height: 100,
                      width: 100,
                      child: Lottie.asset('assets/icons/mengajar.json'),
                    ),
                    const SizedBox(width: 20,),
                    // how do you feel + get started button
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Selamat datang', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text('Beli keperluan santri', style: TextStyle(fontSize: 14),),
                          const SizedBox(height: 12,),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0XFF4CACBC),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(child: Text('Menuju Toko', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xffF9F9F9), fontSize: 16),)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
      
            //search bar
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
            //   child: Container(
            //     padding: const EdgeInsets.all(8),
            //     decoration: BoxDecoration(
            //       color: const Color.fromARGB(255, 203, 204, 235),
            //       borderRadius: BorderRadius.circular(12),
            //     ),
            //     child: const TextField(
            //       decoration: InputDecoration(
            //         prefixIcon: Icon(Icons.search),
            //         border: InputBorder.none,
            //         hintText: 'How can we help you?',
            //       ),
            //     ),
            //   ),
            // ),

            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Container(
                child: Column(
                  children: const [
                    CategoryCard(
                        iconImagePath: 'assets/icons/user.png',
                        categoryName: 'Daftar Santri',
                        router: '/santri'),
                  ],
                ),
              )
            ),

            const SizedBox(
              height: 25,
            ),
      
            // horizontal listview -> Category: Store, Finance etc..
            Container(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  CategoryCard(
                      iconImagePath: 'assets/icons/wallet.png',
                      categoryName: 'Store',
                      router: '/store'),
                  CategoryCard(
                      iconImagePath: 'assets/icons/finance_2.png',
                      categoryName: 'Keuangan',
                      router: '/keuangan'),
                  CategoryCard(
                      iconImagePath: 'assets/icons/tomb.png',
                      categoryName: 'Maklumat',
                      router: '/maklumat'),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),

            //doctor list
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Maklumat list', style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),),
                  Text('Lihat semua',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  MaklumatCard(
                    desc: 'Masjid Seribu Tiang',
                    maklumatImagePath: 'assets/img/masjid1.jpg',
                  ),
                  MaklumatCard(
                    desc: 'Taj-mahal nya sunter',
                    maklumatImagePath: 'assets/img/masjid2.jpg',
                  )
                ],
              )
            )

          ],
        ),
      ),
    );
  }
}