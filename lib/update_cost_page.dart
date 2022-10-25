import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lakuseni_user/home_page.dart';
import 'package:lakuseni_user/models/cost.dart';
import 'package:lakuseni_user/models/package.dart';
import 'package:lakuseni_user/models/performance.dart';
import 'package:lakuseni_user/seller_home_page.dart';
import 'package:lakuseni_user/services/order_service.dart';
import 'package:intl/intl.dart';
import 'package:lakuseni_user/services/seller_service.dart';
import 'package:money_formatter/money_formatter.dart';
import 'const.dart';
import 'models/cost_item.dart';
import 'models/order.dart';
import 'payment_page.dart';

class UpdateCostPage extends StatefulWidget {
  UpdateCostPage({Key? key, required this.order}) : super(key: key);
  Order order;
  @override
  State<UpdateCostPage> createState() => _UpdateCostPageState();
}

class _UpdateCostPageState extends State<UpdateCostPage> {
  TextEditingController _tecName = TextEditingController();
  TextEditingController _tecHarga = TextEditingController();
  List<CostItem> list = [];
  List<Map<String, dynamic>> listMap = [];
  double costTotal = 0;
  @override
  void initState() {
    costTotal = widget.order.cost.total;
    list = widget.order.cost.costItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pesanan'),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Text(
                'Produk yang dipesan',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Card(
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
                          height: 60,
                          width: 60,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'images/temp_art2.png',
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
                                  widget.order.seller.user.name,
                                  maxLines: 1,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                // margin: EdgeInsets.only(bottom: 5),
                                child: Text(
                                  widget.order.productName,
                                  maxLines: 2,
                                ),
                              ),
                              // s
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              // margin: EdgeInsets.only(bottom: 5),
              child: Text(
                'Rincian Biaya',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            Card(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: List.generate(list.length, (index) {
                        CostItem costItem = list[index];
                        return Container(
                          margin: EdgeInsets.only(bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(costItem.name),
                              Text(
                                MoneyFormatter(
                                        amount: costItem.price,
                                        settings: MoneyFormatterSettings(
                                            symbol: 'Rp',
                                            thousandSeparator: '.',
                                            decimalSeparator: ',',
                                            fractionDigits: 0))
                                    .output
                                    .symbolOnLeft,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        );
                      }),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Divider(
                        color: Colors.black,
                        // height: 10,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Biaya',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Text(
                            MoneyFormatter(
                                    amount: costTotal,
                                    settings: MoneyFormatterSettings(
                                        symbol: 'Rp',
                                        thousandSeparator: '.',
                                        decimalSeparator: ',',
                                        fractionDigits: 0))
                                .output
                                .symbolOnLeft,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5, top: 10),
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    controller: _tecName,
                    decoration: InputDecoration(label: Text('Nama Biaya')),
                  )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: TextFormField(
                    controller: _tecHarga,
                    decoration: InputDecoration(label: Text('Biaya')),
                  )),
                ],
              ),
            ),
            OutlinedButton(
              onPressed: () {
                setState(() {
                  list.add(CostItem(
                      id: -1,
                      name: _tecName.text,
                      desc: '',
                      price: double.parse(_tecHarga.text)));
                  costTotal += double.parse(_tecHarga.text);
                });
                listMap.add({
                  'name': _tecName.text,
                  'price': double.parse(_tecHarga.text)
                });
              },
              child: Text('Tambahkan Biaya'),
              style: MyTheme.btnAcceptAlt,
            )
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
            Map<String, dynamic> body = {'items': listMap};
            print(body);
            print('object');
            SellerService().addCost(body, widget.order.id).then((value) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SellerHomePage(seller_type: 'Seni Pertunjukan'),
                ),
              );
            });
          },
          child: Text(
            'Update Rincian Biaya',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600, fontSize: 17, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
