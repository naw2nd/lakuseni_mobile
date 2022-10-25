import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lakuseni_user/craft_detail_page.dart';
import 'package:lakuseni_user/seller_home_page.dart';
import 'package:lakuseni_user/services/seller_service.dart';

import 'const.dart';

class AddCraftPage extends StatefulWidget {
  const AddCraftPage({Key? key}) : super(key: key);

  @override
  State<AddCraftPage> createState() => _AddCraftPageState();
}

//  "name": "Lukisan Bagus",
//   "weight": 1900,
//   "desc": "Tempat menjual barang seni atau barang hasil kerajinan tangan.",
//   "product_category_id": 3,
//   "price": 70000,
class _AddCraftPageState extends State<AddCraftPage> {
  TextEditingController _tecName = TextEditingController();
  TextEditingController _tecWeight = TextEditingController();
  TextEditingController _tecDesc = TextEditingController();
  TextEditingController _tecPrice = TextEditingController();
  Future<File> _getFromGallery() async {
    XFile? photo = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 20);
    return File(photo!.path);
  }

  int _selectedCategory = 0;
  List<Widget> listGambar = [];
  List<String> listKategori = ['Lukis', 'Patung', 'Kerajinan', 'Lainnya'];
  List<File> listFile = [];
  List<Map<String, dynamic>> listImages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambahkan Produk'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Container(
          child: Column(children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: DropdownButtonFormField(
                  value: listKategori[_selectedCategory],
                  decoration: InputDecoration(label: Text('Kategori Produk')),
                  items: listKategori
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    _selectedCategory = listKategori.indexOf(value.toString());
                  }),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: TextFormField(
                controller: _tecName,
                decoration: InputDecoration(label: Text('Nama Produk')),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: TextFormField(
                controller: _tecDesc,
                maxLines: 3,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'Deskripsi',
                  constraints:
                      const BoxConstraints(maxHeight: double.maxFinite),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: TextFormField(
                controller: _tecWeight,
                decoration: InputDecoration(label: Text('Berat Produk')),
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
                      listFile.add(value);
                    });
                    List<int> imageBytes = await value.readAsBytesSync();
                    String base64Image = base64Encode(imageBytes);
                    listImages.add({'image_base64': base64Image});
                  });
                },
                child: Wrap(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.photo,
                        color: MyColor.mainColor,
                      ),
                    ),
                    Text(
                      'Tambahkan Gambar',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                style: MyTheme.btnAcceptAlt,
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: listFile.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 200,
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(listFile[index]),
                      ),
                    );
                  }),
            )
          ]),
        ),
      ),
      bottomSheet: Container(
        width: double.maxFinite,
        padding: EdgeInsets.all(10),
        child: TextButton(
          style: TextButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: MyColor.mainColor,
          ),
          onPressed: () {
            Map<String, dynamic> body = {
              'name': _tecName.text,
              'desc': _tecDesc.text,
              'product_category_id': _selectedCategory + 1,
              'weight': _tecWeight.text,
              'price': _tecPrice.text,
              'images': listImages
            };

            print(body);
            SellerService().addCraft(body).then((value) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => SellerHomePage(seller_type: 'Toko Seni',),
                ),
              );
            });
          },
          child: Text(
            'Tambahkan Produk',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600, fontSize: 17, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
