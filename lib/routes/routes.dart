import 'package:flutter/cupertino.dart';
import 'package:siakad_tpm/screen/fragment/store/shopping_cart.dart';
import 'package:siakad_tpm/screen/home_screen.dart';

import '../screen/login_screen.dart';
import '../screen/santri_list_screen.dart';
import '../screen/shopping_screen.dart';

final routes = {
  '/': (BuildContext context) => const Login(),
  '/home': (BuildContext context) => const HomePage(),
  '/santri': (BuildContext context) => const SantriListScreen(),
  '/store':  (BuildContext context) => const ShoopingScreen(),
    '/storecart': (BuildContext context) => const ShoppingCart(),
  '/keuangan':  (BuildContext context) => const SantriListScreen(),
  '/maklumat':  (BuildContext context) => const SantriListScreen(),
};