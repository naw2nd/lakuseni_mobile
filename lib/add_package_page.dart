import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lakuseni_user/models/package.dart';

import 'const.dart';

class AddPackagePage extends StatefulWidget {
  AddPackagePage({Key? key}) : super(key: key);
  @override
  State<AddPackagePage> createState() => _AddPackagePageState();
}

class _AddPackagePageState extends State<AddPackagePage> {
  TextEditingController _tecName = TextEditingController();
  TextEditingController _tecDesc = TextEditingController();
  TextEditingController _tecPrice = TextEditingController();
  Future<File> _getFromGallery() async {
    XFile? photo = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 20);
    return File(photo!.path);
  }

  String imageBase64 = '';
  Widget image = Container();
  bool mainPackage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambahkan Paket'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: TextFormField(
                controller: _tecName,
                decoration: InputDecoration(label: Text('Nama Paket')),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: TextFormField(
                controller: _tecDesc,
                decoration: InputDecoration(label: Text('Deskripsi')),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: TextFormField(
                controller: _tecPrice,
                decoration: InputDecoration(label: Text('Harga')),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: TextButton(
                onPressed: () {
                  _getFromGallery().then((value) async {
                    setState(() {
                      image = Container(
                        height: 200,
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(value),
                        ),
                      );
                    });
                    List<int> imageBytes = await value.readAsBytesSync();
                    String base64Image = base64Encode(imageBytes);
                    imageBase64 = base64Image;
                  });
                },
                child: const Text(
                  'Tambahkan Gambar',
                  style: TextStyle(fontSize: 15),
                ),
                style: MyTheme.btnAcceptAlt,
              ),
            ),
            image,
          ],
        ),
      ),
      bottomSheet: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: MyColor.mainColor,
                ),
                onPressed: () {
                  Map<String, dynamic> package = {
                    'name': _tecName.text,
                    'price': _tecDesc.text,
                    'price': int.parse(_tecPrice.text),
                    'image_url': imageBase64,
                    'package_type': 'main'
                  }; 
                  print(package);
                  Navigator.pop(context, package);
                  
                },
                child: Text(
                  'Paket Utama',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: MyColor.mainColor,
                ),
                onPressed: () {
                  Map<String, dynamic> package = {
                    'name': _tecName.text,
                    'price': _tecDesc.text,
                    'price': int.parse(_tecPrice.text),
                    'image_url': imageBase64,
                    'package_type': 'additional'
                  }; 
                  print(package);
                  Navigator.pop(context, package);
                  
                },
                child: Text(
                  'Paket Tambahan',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
