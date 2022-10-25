import 'package:flutter/material.dart';
import 'package:lakuseni_user/add_craft_page.dart';
import 'package:lakuseni_user/const.dart';
import 'package:lakuseni_user/craft_detail_page.dart';
import 'package:lakuseni_user/models/performance.dart';
import 'package:lakuseni_user/models/product_category.dart';
import 'package:lakuseni_user/performance_detail_page.dart';
import 'package:lakuseni_user/seller_order_performance.dart';
import 'package:lakuseni_user/services/order_service.dart';
import 'package:lakuseni_user/services/product_service.dart';
import 'package:money_formatter/money_formatter.dart';

import 'add_performance_page.dart';
import 'craft_card.dart';
import 'menu_page.dart';
import 'models/craft.dart';
import 'models/order.dart';
import 'performance_card.dart';
import 'seller_order_craft_page.dart';

class SellerHomePage extends StatefulWidget {
  SellerHomePage({Key? key, required this.seller_type}) : super(key: key);
  String seller_type;
  @override
  State<SellerHomePage> createState() => _SellerHomePageState();
}

class _SellerHomePageState extends State<SellerHomePage> {
  final TextEditingController _tecSearch = TextEditingController();
  int _selectedMenu = 0;
  Widget productWidget = ProdukCraftSaya();
  @override
  void initState() {
    if (widget.seller_type != 'Toko Seni')
      productWidget = ProdukPerformanceSaya();
    super.initState();
  }

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
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/bg_image.png"),
              fit: BoxFit.contain,
              alignment: Alignment.topCenter),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(right: 10, left: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: _selectedMenu == 0
                              ? Colors.white
                              : MyColor.mainColor,
                          side: BorderSide(color: Colors.white),
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedMenu = 0;
                          });
                        },
                        child: Text(
                          'Produk Saya',
                          style: TextStyle(
                            color: _selectedMenu == 0
                                ? Colors.black87
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: _selectedMenu == 1
                              ? Colors.white
                              : MyColor.mainColor,
                          side: BorderSide(color: Colors.white),
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedMenu = 1;
                          });
                        },
                        child: Text(
                          'Daftar Transaksi',
                          style: TextStyle(
                            color: _selectedMenu == 1
                                ? Colors.black87
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _selectedMenu == 0
                ? Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: MyColor.mainColor,
                        side: BorderSide(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                widget.seller_type == 'Toko Seni'
                                    ? AddCraftPage()
                                    : AddPerformancePage(),
                          ),
                        );
                      },
                      child: Text(
                        'Tambahkan Produk',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                : Container(),
            _selectedMenu == 0 ? productWidget : DaftarTransaksi(),
          ],
        ),
      ),
    );
  }
}

class ProdukPerformanceSaya extends StatefulWidget {
  ProdukPerformanceSaya({Key? key}) : super(key: key);

  @override
  State<ProdukPerformanceSaya> createState() => _ProdukPerformanceSayaState();
}

class _ProdukPerformanceSayaState extends State<ProdukPerformanceSaya> {
  final List<Widget> _seniPertunjukanCards = [];

  @override
  void initState() {
    ProductService().performanceIndex().then((values) {
      for (Performance performance in values) {
        setState(() {
          _seniPertunjukanCards.add(PerformanceCard(performance: performance));
        });
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
      child: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.start,
        spacing: 5,
        runSpacing: 5,
        children: _seniPertunjukanCards,
      ),
    ));
  }
}

class ProdukCraftSaya extends StatefulWidget {
  const ProdukCraftSaya({Key? key}) : super(key: key);

  @override
  State<ProdukCraftSaya> createState() => _ProdukCraftSayaState();
}

class _ProdukCraftSayaState extends State<ProdukCraftSaya> {
  final List<Widget> _seniRupaCards = [];
  @override
  void initState() {
    ProductService().craftIndex().then((values) {
      for (Craft craft in values) {
        setState(() {
          _seniRupaCards.add(CraftCard(craft: craft));
        });
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            spacing: 5,
            runSpacing: 5,
            children: _seniRupaCards),
      ),
    );
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
    OrderService().orderIndex().then((value) {
      setState(() {
        orders = value;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                        builder: (context) => order.orderType == 'craft'
                            ? SellerOrderCraftPage(
                                order: order,
                              )
                            : SellerOrderPerformancePage(order: order),
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
