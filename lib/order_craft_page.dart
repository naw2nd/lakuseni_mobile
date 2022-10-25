import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lakuseni_user/address_page.dart';
import 'package:lakuseni_user/courier_page.dart';
import 'package:lakuseni_user/home_page.dart';
import 'package:lakuseni_user/models/address.dart';
import 'package:lakuseni_user/models/cost_item.dart';
import 'package:lakuseni_user/payment_page.dart';
import 'package:lakuseni_user/services/order_service.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'const.dart';
import 'models/cost.dart';
import 'models/order.dart';

class OrderCraftPage extends StatefulWidget {
  OrderCraftPage({Key? key, required this.order}) : super(key: key);
  Order order;
  @override
  State<OrderCraftPage> createState() => _OrderCraftPageState();
}

class _OrderCraftPageState extends State<OrderCraftPage> {
  bool userAction = false;
  String receipt = 'XXXXXXXXXX';
  @override
  void initState() {
    if (widget.order.orderStatusName == 'Menunggu Pembayaran' ||
        widget.order.orderStatusName == 'Dikirim')
      setState(() {
        userAction = true;
      });

    if(widget.order.orderStatusName == 'Dikirim')
      OrderService().showDelivery(widget.order.id).then((value) {
        setState(() {
          receipt = value.receipt_number;
        });
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Pemesanan')),
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
              margin: EdgeInsets.only(top: 10),
              child: Text(
                'Pengiriman',
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
                          'Status',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text(
                          '${widget.order.orderStatusName}',
                          style: TextStyle(
                            color: MyColor.mainColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          maxLines: 5,
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 5),
                        child: Text(
                          'Alamat',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text(
                          '${widget.order.address.desc}\n${widget.order.address.city.name}',
                          maxLines: 5,
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 5),
                        child: Text(
                          'Kurir',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text(
                          'JNE | OKE (Ongkos Kirim Ekonomis)',
                          maxLines: 5,
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      widget.order.orderStatusName == 'Dikirim'
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // margin: EdgeInsets.only(bottom: 0),
                                  child: Text(
                                    'Nomor Resi',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 5),
                                      child: Text(
                                        receipt,
                                        maxLines: 5,
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                    Container(
                                      height: 25,
                                      child: TextButton(
                                        onPressed: ()  {
                                           launchUrl(Uri.parse('https://www.jne.co.id/id/tracking/trace'));
                                          
                                        },
                                        child: Text('Cek Resi'),
                                        style: MyTheme.btnInline,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5),
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
                onPressed: () {
                  widget.order.orderStatusName == 'Menunggu Pembayaran'
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return PaymentPage(
                                orderId: widget.order.id,
                              );
                            },
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
                        });
                },
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
