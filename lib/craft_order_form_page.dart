import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lakuseni_user/address_page.dart';
import 'package:lakuseni_user/courier_page.dart';
import 'package:lakuseni_user/models/address.dart';
import 'package:lakuseni_user/order_craft_page.dart';
import 'package:lakuseni_user/services/order_service.dart';
import 'package:money_formatter/money_formatter.dart';

import 'const.dart';
import 'models/craft.dart';

class CraftOrderFormPage extends StatefulWidget {
  CraftOrderFormPage({Key? key, required this.craft}) : super(key: key);
  Craft craft;
  @override
  State<CraftOrderFormPage> createState() => _CraftOrderFormPageState();
}

class _CraftOrderFormPageState extends State<CraftOrderFormPage> {
  String alamat = 'Pilih Alamat Pengiriman';
  String kurir = 'Pilih Kurir';
  late Address address;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Beli Langsung')),
      body: Container(
        margin: EdgeInsets.all(10),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Text(
                'Produk yang dibeli',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            Card(
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        height: 75,
                        width: 75,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            MyUrl.baseUrl +
                                widget.craft.productImages[0].imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 5),
                              child: Text(
                                widget.craft.sellerName,
                                maxLines: 1,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 5),
                              child: Text(
                                widget.craft.productName,
                                maxLines: 2,
                              ),
                            ),
                            Container(
                              child: Text(
                                  MoneyFormatter(
                                          amount: widget.craft.price,
                                          settings: MoneyFormatterSettings(
                                              symbol: 'Rp',
                                              thousandSeparator: '.',
                                              decimalSeparator: ',',
                                              fractionDigits: 0))
                                      .output
                                      .symbolOnLeft,
                                  maxLines: 1,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5, top: 10),
              child: Text(
                'Pengiriman',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () async {
                  address = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddressPage(),
                    ),
                  );
                  setState(() {
                    alamat = address.desc;
                  });
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
                          alamat,
                          maxLines: 1,
                        ),
                      ),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () async {
                  String value = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CourierPage(
                        address: address,
                      ),
                    ),
                  );
                  setState(() {
                    kurir = value;
                  });
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
                          kurir,
                          maxLines: 1,
                        ),
                      ),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ),
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
            Map<String, dynamic> body = {
              'product_id': widget.craft.productId,
              'city_id': address.city.id,
              'address_url': address.url,
              'address_desc': address.desc,
            };
            OrderService().orderStore(body).then((value) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderCraftPage(
                    order: value,
                  ),
                ),
              );
            });
          },
          child: Text(
            'Pesan Sekarang',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600, fontSize: 17, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
