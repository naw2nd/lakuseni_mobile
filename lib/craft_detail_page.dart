import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lakuseni_user/models/product_image.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'const.dart';
import 'craft_order_form_page.dart';
import 'models/craft.dart';

class CraftDetailPage extends StatefulWidget {
  CraftDetailPage({Key? key, required this.craft}) : super(key: key);
  Craft craft;

  @override
  State<CraftDetailPage> createState() => _CraftDetailPageState();
}

class _CraftDetailPageState extends State<CraftDetailPage> {
  List<ProductImage> lProductImages = [];

  @override
  void initState() {
    lProductImages = widget.craft.productImages;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Produk'),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: CarouselSlider.builder(
              itemCount: lProductImages.length,
              options: CarouselOptions(
                  autoPlay: true,
                  height: 250,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                  viewportFraction: 0.95,
                  enlargeStrategy: CenterPageEnlargeStrategy.height),
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) {
                print('${MyUrl.baseUrl}/${lProductImages[itemIndex].imageUrl}');
                return Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 3),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      '${MyUrl.baseUrl}${lProductImages[itemIndex].imageUrl}',
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
            child: Text(
              widget.craft.productName,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 5),
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(right: 3),
                    child: Icon(
                      Icons.shopping_bag,
                      color: Colors.black54,
                      size: 15,
                    )),
                Text(
                  'Terjual ${widget.craft.productSold}',
                  style: TextStyle(color: Colors.black54),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Text(
              widget.craft.productDesc,
              maxLines: 5,
              textAlign: TextAlign.justify,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {},
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: Colors.black12),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image(
                          image: AssetImage('images/temp_profile.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      widget.craft.sellerName,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                    widget.craft.sellerLocation,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              height: 42,
              width: 50,
              margin: EdgeInsets.only(right: 10),
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      side:
                          BorderSide(width: 2, color: MyColor.fade50MainColor),
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  launchUrl(Uri.parse('https://wa.me/${widget.craft.sellerPhone}'));
                },
                // onPressed: () => Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => CraftDetailPage(),
                //   ),
                // ),
                child: Icon(
                  Icons.message,
                  color: MyColor.mainColor,
                ),
              ),
            ),
            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: MyColor.mainColor,
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CraftOrderFormPage(
                      craft: widget.craft,
                    ),
                  ),
                ),
                child: Text(
                  'Beli sekarang',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
