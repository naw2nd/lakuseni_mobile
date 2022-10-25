import 'package:flutter/material.dart';
import 'package:lakuseni_user/const.dart';
import 'package:lakuseni_user/craft_detail_page.dart';
import 'package:lakuseni_user/models/performance.dart';
import 'package:lakuseni_user/models/product_category.dart';
import 'package:lakuseni_user/performance_detail_page.dart';
import 'package:lakuseni_user/services/product_service.dart';
import 'package:money_formatter/money_formatter.dart';

import 'craft_card.dart';
import 'menu_page.dart';
import 'models/craft.dart';
import 'performance_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _tecSearch = TextEditingController();
  final List<String> _productType = ['Seni Rupa', 'Seni Petunjukan'];
  final List<String> _performanceCategory = [
    'Semua',
    'Jaranan',
    'Tari',
    'Wayang',
    'Lainnya'
  ];
  final List<String> _craftCategory = [
    'Semua',
    'Lukis',
    'Patung',
    'Kerajinan',
    'Lainnya'
  ];
  String _selectedProductType = 'Seni Rupa';
  List<Widget> _seniRupaCards = [];
  List<Widget> _seniPertunjukanCards = [];
  int _selectedProductCategory = 0;

  @override
  void initState() {
    ProductService().craftIndex().then((values) {
      for (Craft craft in values) {
        setState(() {
          _seniRupaCards.add(CraftCard(craft: craft));
        });
      }
    });

    ProductService().performanceIndex().then((values) {
      for (Performance performance in values) {
        setState(() {
          _seniPertunjukanCards.add(PerformanceCard(performance: performance));
        });
      }
    });
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
              padding: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: MyColor.mainColor,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 10, left: 10),
                      child: TextFormField(
                        controller: _tecSearch,
                        decoration: InputDecoration(
                          hintText: 'Cari Produk',
                          hintStyle: const TextStyle(color: Colors.black38),
                          isCollapsed: true,
                          prefixIcon: const Icon(Icons.search, size: 15),
                          prefixIconConstraints:
                              const BoxConstraints(minWidth: 30, maxHeight: 15),
                          contentPadding: const EdgeInsets.all(10),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                  ),
                  PopupMenuButton(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(_selectedProductType, style: MyTheme.txtTitle),
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          child: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    onSelected: (int value) {
                      setState(() {
                        _selectedProductType = _productType[value];
                      });
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 0,
                        child: Text(_productType[0]),
                      ),
                      PopupMenuItem(
                        value: 1,
                        child: Text(_productType[1]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
              height: 30,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _craftCategory.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin:
                          EdgeInsets.only(right: 10, left: index == 0 ? 10 : 0),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: _selectedProductCategory == index
                              ? Colors.white
                              : MyColor.mainColor,
                          side: BorderSide(color: Colors.white),
                        ),
                        onPressed: () {
                          ProductService().craftIndex().then((values) {
                            for (Craft craft in values) {
                              setState(() {
                                _seniRupaCards = [];
                                _selectedProductCategory = index;

                                if (_selectedProductCategory != 0) if (craft
                                        .productCategoryName ==
                                    _craftCategory[_selectedProductCategory])
                                  _seniRupaCards.add(CraftCard(craft: craft));

                                
                              });
                            }
                          });
                          setState(() {});
                        },
                        child: Text(
                          _selectedProductType == 'Seni Rupa'
                              ? _craftCategory[index]
                              : _performanceCategory[index],
                          style: TextStyle(
                            color: _selectedProductCategory == index
                                ? Colors.black87
                                : Colors.white,
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                spacing: 5,
                runSpacing: 5,
                children: _selectedProductType == 'Seni Rupa'
                    ? _seniRupaCards
                    : _seniPertunjukanCards,
              ),
            )),
          ],
        ),
      ),
    );
  }
}
