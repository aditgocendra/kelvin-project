import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kelvin_project/firebase_options.dart';
import 'package:kelvin_project/services/local/shared_pref.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final user = await SharedPrefService().readCache();
  initializeDateFormatting();
  runApp(
    App(
      user: user,
    ),
  );
}

class App extends StatelessWidget {
  dynamic user;
  App({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Point Of Sale",
      theme: ThemeData(
        backgroundColor: Colors.grey.shade100,
        canvasColor: Colors.white,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme.apply(
                bodyColor: Colors.black87,
              ),
        ),
      ),
      initialRoute: user == null ? Routes.LOGIN : AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
