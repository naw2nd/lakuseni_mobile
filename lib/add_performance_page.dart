import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lakuseni_user/add_package_page.dart';
import 'package:lakuseni_user/seller_home_page.dart';

import 'const.dart';
import 'models/package.dart';
import 'services/seller_service.dart';

class AddPerformancePage extends StatefulWidget {
  const AddPerformancePage({Key? key}) : super(key: key);

  @override
  State<AddPerformancePage> createState() => _AddPerformancePageState();
}

class _AddPerformancePageState extends State<AddPerformancePage> {
  TextEditingController _tecName = TextEditingController();
  TextEditingController _tecDesc = TextEditingController();
  Future<File> _getFromGallery() async {
    XFile? photo = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 20);
    return File(photo!.path);
  }

  int _selectedCategory = 0;
  List<Widget> listGambar = [];
  List<String> listKategori = ['Tari', 'Jaranan', 'Wayang', 'Lainnya'];
  List<File> listFile = [];
  List<Map<String, dynamic>> listImages = [];
  List<Map<String, dynamic>> listPackage = [];
  List<Widget> txt = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambahkan Pertunjukan'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Container(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              margin: EdgeInsets.only(bottom: 5),
              child: Text(
                'Paket Pertunjukan',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: txt,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: TextButton(
                      onPressed: () async {
                        Map<String, dynamic> package = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddPackagePage(),
                          ),
                        );
                        setState(() {
                          txt.add(Text(
                              '- ${package['name']} | Harga = ${package['price']}'));
                        });
                        listPackage.add(package);
                      },
                      child: const Text(
                        'Tambahkan Paket',
                        style: TextStyle(fontSize: 15),
                      ),
                      style: MyTheme.btnAcceptAlt,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
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
                      child: const Text(
                        'Tambahkan Gambar',
                        style: TextStyle(fontSize: 15),
                      ),
                      style: MyTheme.btnAcceptAlt,
                    ),
                  ),
                ),
              ],
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
              'product_category_id': _selectedCategory + 4,
              'package': listPackage,
              'images': listImages
            };

            print(body);
            SellerService().addPerformance(body).then((value) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => SellerHomePage(
                    seller_type: 'Seni Pertunjukan',
                  ),
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
