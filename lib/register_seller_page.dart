import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lakuseni_user/services/user_service.dart';

import 'const.dart';
import 'login_page.dart';

class RegisterSellerPage extends StatefulWidget {
  const RegisterSellerPage({Key? key}) : super(key: key);

  @override
  State<RegisterSellerPage> createState() => _RegisterSellerPageState();
}

class _RegisterSellerPageState extends State<RegisterSellerPage> {
  TextEditingController tecNama = TextEditingController();
  TextEditingController tecEmail = TextEditingController();
  TextEditingController tecNoHP = TextEditingController();
  TextEditingController tecPassword = TextEditingController();
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
            IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
        title: const Text('Daftar'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: TextFormField(
                controller: tecNama,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                ),
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
                controller: tecNoHP,
                decoration: const InputDecoration(
                  labelText: 'No HP',
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
                  UserService()
                      .register(tecNama.text, tecEmail.text, tecNoHP.text,
                          tecPassword.text)
                      .then((value) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginPage();
                        },
                      ),
                    );
                  });
                },
                style: MyTheme.btnAccept,
                child: const Text(
                  'Daftar Sekarang',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}