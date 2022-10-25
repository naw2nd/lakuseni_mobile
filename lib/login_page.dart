import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:lakuseni_user/admin_page.dart';
import 'package:lakuseni_user/home_page.dart';
import 'package:lakuseni_user/register_user_page.dart';
import 'package:lakuseni_user/seller_home_page.dart';
import 'package:lakuseni_user/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'const.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController tecEmail = TextEditingController();
  TextEditingController tecPassword = TextEditingController();
  bool hidePassword = true;

  Future<Response> login() async {
    UserService userService = UserService();
    Response response =
        await userService.login(tecEmail.text, tecPassword.text);
    return response;
  }

  storeToken(String token) async {
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('user_token', 'Bearer $token');
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 180, 0, 0),
              alignment: Alignment.center,
              child: const Image(
                image: AssetImage('images/logo_kuning.png'),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 20),
              child: Text(
                'e-marketplace untuk produk seni Indonesia',
                style: GoogleFonts.poppins(
                    color: MyColor.mainColor, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: TextFormField(
                controller: tecEmail,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: TextFormField(
                controller: tecPassword,
                obscureText: hidePassword ? true : false,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                      icon: Icon(hidePassword
                          ? Icons.visibility_off
                          : Icons.visibility)),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              height: 45,
              child: TextButton(
                onPressed: () {
                  // Toast.show('Pressed');
                  String message = '';
                  login().then((value) {
                    dynamic body = json.decode(value.body);
                    message = body['message'];
                    Toast.show(message);
                    if (body['success']) {
                      storeToken(body['access_token']);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            if(body['admin'] == true)
                              return AdminPage();
                            if (body['seller_type'] != 'false') {
                              print('you are seller');
                              return SellerHomePage(seller_type: body['seller_type'],);
                            }
                            return HomePage();
                          },
                        ),
                      );
                    }
                  });
                },
                style: MyTheme.btnAccept,
                child: const Text(
                  'Login',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              alignment: Alignment.center,
              child: const Text('atau'),
            ),
            Container(
              height: 45,
              margin: const EdgeInsets.only(bottom: 15),
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: Row(
                  children: [
                    const Image(
                      image: AssetImage('images/icon_google.png'),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Login dengan Google',
                          style: GoogleFonts.poppins(
                              fontSize: 15, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Belum punya akun?'),
                TextButton(
                  style: MyTheme.btnInline,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return RegisterUserPage();
                          },
                        ),
                      );
                  },
                  child: const Text(
                    'Daftar sekarang',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
