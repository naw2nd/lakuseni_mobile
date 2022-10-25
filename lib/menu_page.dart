import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lakuseni_user/const.dart';
import 'package:lakuseni_user/main.dart';
import 'package:lakuseni_user/order_performance_page.dart';
import 'package:lakuseni_user/services/order_service.dart';
import 'package:lakuseni_user/services/user_service.dart';
import 'package:money_formatter/money_formatter.dart';

import 'models/order.dart';
import 'models/user.dart';
import 'order_craft_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  Future<User> profile() async {
    UserService userService = UserService();
    return await userService.profile();
  }

  User user = User(
      id: -1,
      name: "user name",
      email: 'user@mail.com',
      phone: "083467xxxx",
      profilePictureUrl: '');
  List<Order> orders = [];
  @override
  void initState() {
    profile().then((value) {
      setState(() {
        user = value;
      });
    });

    OrderService().orderIndex().then((value) {
      setState(() {
        orders = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        actions: [
          TextButton(
            onPressed: () async {
              await UserService().logout().then((value) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyApp(),
                  ),
                );
              });
            },
            child: Text(
              'Keluar',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: 220,
            decoration: BoxDecoration(
              color: MyColor.mainColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            width: double.maxFinite,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)),
                    margin: EdgeInsets.only(right: 10),
                    padding: EdgeInsets.all(3),
                    height: 100,
                    width: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        'images/temp_profile.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  // margin: EdgeInsets.only(bottom: 5),
                  child: Text(
                    'Profile Saya',
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Card(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: MyColor.fade20MainColor),
                                  child: Icon(
                                    Icons.person_outline,
                                    color: MyColor.mainColor,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Nama ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(user.name),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: MyColor.fade20MainColor),
                                  child: Icon(
                                    Icons.email_outlined,
                                    color: MyColor.mainColor,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Email",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(user.email),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: MyColor.fade20MainColor),
                                  child: Icon(
                                    Icons.phone_android,
                                    color: MyColor.mainColor,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "No HP",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(user.phone),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(bottom: 5),
                  child: Text(
                    'Transaksi Saya',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                Expanded(
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
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => order.orderType ==
                                            'craft'
                                        ? OrderCraftPage(
                                            order: order,
                                          )
                                        : OrderPerformancePage(order: order),
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin:
                                                    EdgeInsets.only(bottom: 2),
                                                child: Text(
                                                  order.seller.user.name,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Text(order
                                                  .seller.address.city.name),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 5, 10, 5),
                                          decoration: BoxDecoration(
                                            color: MyColor.fade20MainColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                      margin:
                                          EdgeInsets.only(bottom: 10, top: 2),
                                      child: Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            height: 40,
                                            width: 40,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                MyUrl.baseUrl +
                                                    order.productImageUrl,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 5),
                                                  child: Text(
                                                    order.productName,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin:
                                                    EdgeInsets.only(bottom: 2),
                                                child: Text(
                                                  'Total Biaya',
                                                ),
                                              ),
                                              Text(
                                                  MoneyFormatter(
                                                          amount:
                                                              order.cost.total,
                                                          settings: MoneyFormatterSettings(
                                                              symbol: 'Rp',
                                                              thousandSeparator:
                                                                  '.',
                                                              decimalSeparator:
                                                                  ',',
                                                              fractionDigits:
                                                                  0))
                                                      .output
                                                      .symbolOnLeft,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(15, 5, 15, 5),
                                          decoration: BoxDecoration(
                                            color: MyColor.mainColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
