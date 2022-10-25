import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lakuseni_user/const.dart';
import 'package:lakuseni_user/home_page.dart';
import 'package:lakuseni_user/models/payment.dart';
import 'package:lakuseni_user/services/order_service.dart';

import 'menu_page.dart';

class PaymentPage extends StatefulWidget {
  PaymentPage({Key? key, required this.orderId}) : super(key: key);
  int orderId;
  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late File image;
  bool imageSelected = false;
  Future<File> _getFromCamera() async {
    XFile? photo = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 20);
    return File(photo!.path);
  }

  Future<File> _getFromGallery() async {
    XFile? photo = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 20);
    return File(photo!.path);
  }

  late Payment payment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pembayaran'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                'Rekening Admin',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 5),
                        child: Text(
                          'Nama',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text(
                          'Admin Aokiji',
                          maxLines: 5,
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 5),
                        child: Text(
                          'Nomor Rekening',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text(
                          '213687919270312',
                          maxLines: 5,
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Text(
                'Bukti Pembayaran',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            Container(
              height: 300,
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: imageSelected ? Image.file(image) : Container(),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      _getFromCamera().then((value) {
                        setState(() {
                          image = value;
                          imageSelected = true;
                        });
                      });
                    },
                    child: Wrap(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.photo_camera,
                            color: MyColor.mainColor,
                          ),
                        ),
                        Text(
                          'Ambil Gambar',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    style: MyTheme.btnAcceptAlt,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      _getFromGallery().then((value) {
                        setState(() {
                          image = value;
                          imageSelected = true;
                        });
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
                          'Buka Galeri',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    style: MyTheme.btnAcceptAlt,
                  ),
                )
              ],
            ),
          ],
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
          onPressed: () async {
            List<int> imageBytes = await image.readAsBytesSync();
            String base64Image = base64Encode(imageBytes);
            payment = Payment(id: -1, orderId: widget.orderId, imageUrl: base64Image);
            OrderService().paymentStore(payment);
            print('fuck'+payment.imageUrl+'fuck');
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
          child: Text(
            'Kirim Bukti Pembayaran',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600, fontSize: 17, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
