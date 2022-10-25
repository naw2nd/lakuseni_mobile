import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lakuseni_user/admin_payment_page.dart';
import 'package:lakuseni_user/services/order_service.dart';
import 'package:lakuseni_user/services/user_service.dart';
import 'package:money_formatter/money_formatter.dart';

import 'const.dart';
import 'menu_page.dart';
import 'models/order.dart';
import 'seller_order_craft_page.dart';
import 'seller_order_performance.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 40,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          title: const Image(
            width: 100,
            height: 100,
            fit: BoxFit.contain,
            image: AssetImage('images/logo_putih.png'),
          ),
          centerTitle: false,
          titleSpacing: 10,
          actions: [
            IconButton(
              padding: const EdgeInsets.all(10),
              constraints: const BoxConstraints(),
              onPressed: () {},
              icon: const Icon(Icons.favorite_border),
            ),
            IconButton(
              padding: const EdgeInsets.all(10),
              constraints: const BoxConstraints(),
              onPressed: () {},
              icon: const Icon(Icons.email_outlined),
            ),
            IconButton(
              padding: const EdgeInsets.all(10),
              constraints: const BoxConstraints(),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MenuPage(),
                ),
              ),
              icon: const Icon(Icons.menu),
            ),
          ],
        ),
        body: Container(
          height: double.maxFinite,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/bg_image.png"),
                  fit: BoxFit.contain,
                  alignment: Alignment.topCenter),
            ),
            child: DaftarTransaksi()));
  }
}

class DaftarTransaksi extends StatefulWidget {
  DaftarTransaksi({Key? key}) : super(key: key);

  @override
  State<DaftarTransaksi> createState() => _DaftarTransaksiState();
}

class _DaftarTransaksiState extends State<DaftarTransaksi> {
  List<Order> orders = [];
  @override
  void initState() {
    UserService().orderAdmin().then((value) {
      setState(() {
        orders = value;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (BuildContext context, int index) {
            Order order = orders[index];
            return Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Card(
                child: InkWell(
                  onTap: () {
                    print(order.orderType);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminPaymentPage(order: order),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 2),
                                    child: Text(
                                      order.user.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(order.address.city.name),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                color: MyColor.fade20MainColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                order.productCateogryName,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: MyColor.mainColor),
                              ),
                            )
                          ],
                        ),
                        Divider(
                          color: Colors.black54,
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10, top: 2),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                height: 40,
                                width: 40,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    MyUrl.baseUrl + order.productImageUrl,
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
                                        order.productName,
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      // margin: EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        order.productDesc,
                                        maxLines: 1,
                                      ),
                                    ),
                                    // s
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 2),
                                    child: Text(
                                      'Total Biaya',
                                    ),
                                  ),
                                  Text(
                                      MoneyFormatter(
                                              amount: order.cost.total,
                                              settings: MoneyFormatterSettings(
                                                  symbol: 'Rp',
                                                  thousandSeparator: '.',
                                                  decimalSeparator: ',',
                                                  fractionDigits: 0))
                                          .output
                                          .symbolOnLeft,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                              decoration: BoxDecoration(
                                color: MyColor.mainColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                order.orderStatusName,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
