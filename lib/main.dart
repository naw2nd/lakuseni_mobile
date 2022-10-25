import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lakuseni_user/login_page.dart';
import 'package:lakuseni_user/home_page.dart';
import 'package:lakuseni_user/payment_page.dart';
import 'package:lakuseni_user/register_user_page.dart';
import 'package:lakuseni_user/services/seller_service.dart';
import 'package:lakuseni_user/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'const.dart';
import 'models/seller_type.dart';
import 'models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_token') ?? '';
  }

  Widget homeWidget = LoginPage();

  @override
  void initState() {
    getToken().then((value) {
      print('value : $value');
      if (value != '') {
        setState(() {
          homeWidget = HomePage();
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(getSellerType.toString());
    return MaterialApp(
      
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          constraints: const BoxConstraints(maxHeight: 45),
          contentPadding: EdgeInsets.fromLTRB(10,2,10,18),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: true,
          titleTextStyle:
              GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 18),
          backgroundColor: MyColor.mainColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
      home: LoginPage()
    );
  }
}
