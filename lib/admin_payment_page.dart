import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lakuseni_user/admin_page.dart';
import 'package:lakuseni_user/const.dart';
import 'package:lakuseni_user/services/order_service.dart';
import 'package:lakuseni_user/services/user_service.dart';
import 'package:money_formatter/money_formatter.dart';

import 'models/cost_item.dart';
import 'models/order.dart';

class AdminPaymentPage extends StatefulWidget {
  AdminPaymentPage({Key? key, required this.order}) : super(key: key);
  Order order;
  @override
  State<AdminPaymentPage> createState() => _AdminPaymentPageState();
}

class _AdminPaymentPageState extends State<AdminPaymentPage> {
  String paymentUrl = '';
  @override
  void initState() {
    UserService().adminPayment(widget.order.id).then((value) {
      setState(() {
        paymentUrl = value.imageUrl;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Pembayaran')),
      body: Container(
        margin: EdgeInsets.all(10),
        child: ListView(
          children: [
            Container(
              // margin: EdgeInsets.only(bottom: 5),
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
                            MyUrl.baseUrl + widget.order.productImageUrl,
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
                              margin: EdgeInsets.only(bottom: 5),
                              child: Text(
                                widget.order.productName,
                                maxLines: 2,
                              ),
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
            paymentUrl != ''
                ? Container(
                    height: 400,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        '${MyUrl.baseUrl}${paymentUrl}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Container(),
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
            OrderService().updateOrder(widget.order.id, 3).then((value) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminPage(),
                ),
              );
            });
          },
          child: Text(
            'Konfirmasi Pembayaran',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600, fontSize: 17, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
