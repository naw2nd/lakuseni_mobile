import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lakuseni_user/seller_home_page.dart';
import 'package:lakuseni_user/services/address_service.dart';
import 'package:lakuseni_user/services/order_service.dart';

import 'const.dart';
import 'home_page.dart';
import 'models/address.dart';
import 'models/city.dart';
import 'models/order.dart';
import 'models/province.dart';

class ReceiptPage extends StatefulWidget {
  ReceiptPage({Key? key, required this.order}) : super(key: key);
  Order order;
  @override
  State<ReceiptPage> createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  // Address address = Address(id: 1, desc: '', url: '', city: city);
  TextEditingController _tecReceipt = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih Kurir'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 5, top: 10),
              child: Text(
                'JNE | OKE (Ongkos Kirim Ekonomis)',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  // Navigator.pop(context, 'JNE | OKE');
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: Colors.black12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'JNE | OKE (Ongkos Kirim Ekonomis)',
                          maxLines: 1,
                        ),
                      ),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ),
            ),
            TextFormField(
              controller: _tecReceipt,
              decoration: InputDecoration(label: Text('Nomor Resi')),
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
          onPressed: () {
            OrderService()
                .storeDelivery(widget.order.id, _tecReceipt.text)
                .then((value) {
              OrderService().updateOrder(widget.order.id, 4).then((value) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SellerHomePage(seller_type: 'Toko Seni'),
                  ),
                );
              });
            });
          },
          child: Text(
            'Unggah Resi Pengiriman',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600, fontSize: 17, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
