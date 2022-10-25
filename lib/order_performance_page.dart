import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lakuseni_user/home_page.dart';
import 'package:lakuseni_user/models/package.dart';
import 'package:lakuseni_user/models/performance.dart';
import 'package:lakuseni_user/services/order_service.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'const.dart';
import 'models/cost_item.dart';
import 'models/order.dart';
import 'payment_page.dart';

class OrderPerformancePage extends StatefulWidget {
  OrderPerformancePage({Key? key, required this.order}) : super(key: key);
  Order order;
  @override
  State<OrderPerformancePage> createState() => _OrderPerformancePageState();
}

class _OrderPerformancePageState extends State<OrderPerformancePage> {
  List<Package> _mainPackages = [];
  List<Package> _additionalPackages = [];
  bool userAction = false;
  @override
  void initState() {
    if (widget.order.orderStatusName == 'Menunggu Pembayaran' ||
        widget.order.orderStatusName == 'Diproses')
      setState(() {
        userAction = true;
      });
    OrderService().packageIndex(widget.order.id).then((value) {
      setState(() {
        for (Package package in value) {
          if (package.packageType == 'main')
            _mainPackages.add(package);
          else
            _additionalPackages.add(package);
        }
      });
    });
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
              margin: EdgeInsets.only(bottom: 5),
              child: Text(
                'Rincian Acara',
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
                          'Paket Acara',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Column(
                          children:
                              List.generate(_mainPackages.length, (index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '• ${_mainPackages[index].name}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 1, horizontal: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: MyColor.fade20MainColor,
                                  ),
                                  child: Text(
                                    'Rincian',
                                    style: TextStyle(color: MyColor.mainColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      })),
                      Container(
                        margin: EdgeInsets.only(bottom: 5),
                        child: Text(
                          'Tanggal',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text(
                          DateFormat.yMMMMEEEEd().format(widget.order.date),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 5),
                        child: Text(
                          'Lokasi Acara',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                widget.order.address.desc,
                                maxLines: 1,
                              ),
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 1, horizontal: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: MyColor.fade20MainColor,
                                ),
                                child: Text(
                                  'Tampilkan Lokasi',
                                  style: TextStyle(color: MyColor.mainColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 5),
                        child: Text(
                          'Catatan',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text(
                          widget.order.desc,
                          maxLines: 5,
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 5),
                        child: Text(
                          'Paket Tambahan',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 5),
                        child: Column(
                            children: List.generate(_additionalPackages.length,
                                (index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '• ${_additionalPackages[index].name}',
                                ),
                                InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: () {},
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 1, horizontal: 15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: MyColor.fade20MainColor,
                                    ),
                                    child: Text(
                                      'Rincian',
                                      style:
                                          TextStyle(color: MyColor.mainColor),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        })),
                      ),
                    ],
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
                      children: List.generate(
                          widget.order.cost.costItems.length, (index) {
                        CostItem costItem = widget.order.cost.costItems[index];
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
                                    amount: widget.order.cost.total,
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
          ],
        ),
      ),
      bottomSheet: userAction
          ? Container(
              width: double.maxFinite,
              padding: EdgeInsets.all(10),
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: MyColor.mainColor,
                ),
                onPressed: () =>
                    widget.order.orderStatusName == 'Menunggu Pembayaran'
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentPage(
                                orderId: widget.order.id,
                              ),
                            ),
                          )
                        : OrderService()
                            .updateOrder(widget.order.id, 8)
                            .then((value) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return HomePage();
                                },
                              ),
                            );
                          }),
                child: Text(
                  widget.order.orderStatusName == 'Menunggu Pembayaran'
                      ? 'Bayar Sekarang'
                      : 'Selesai',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: Colors.white),
                ),
              ),
            )
          : Container(
              height: 0,
            ),
    );
  }
}
