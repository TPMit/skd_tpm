import 'package:flutter/cupertino.dart';
import 'package:siakad_tpm/screen/home_screen.dart';

import '../screen/login_screen.dart';
import '../screen/santri_list_screen.dart';

final routes = {
  '/': (BuildContext context) => const Login(),
  '/home': (BuildContext context) => const HomePage(),
  '/santri': (BuildContext context) => const SantriListScreen(),
};