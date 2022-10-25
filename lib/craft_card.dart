import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';

import 'const.dart';
import 'craft_detail_page.dart';
import 'models/craft.dart';

class CraftCard extends StatelessWidget {
  CraftCard({Key? key, required this.craft}) : super(key: key);
  Craft craft;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2 - 10,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CraftDetailPage(craft: craft),
            ),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: Image.network(
                  MyUrl.baseUrl + craft.productImages[0].imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    // padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10),
                    //     color: MyColor.mainColor),
                    child: Text(
                      craft.productCategoryName,
                      style: TextStyle(
                          color: MyColor.mainColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Text(
                      craft.productName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Text(
                      MoneyFormatter(
                              amount: craft.price,
                              settings: MoneyFormatterSettings(
                                  symbol: 'Rp',
                                  thousandSeparator: '.',
                                  decimalSeparator: ',',
                                  fractionDigits: 0))
                          .output
                          .symbolOnLeft,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Container(
                    child: Wrap(
                      children: [
                        Container(
                            margin: EdgeInsets.only(right: 3),
                            child: Icon(
                              Icons.shopping_bag,
                              color: Colors.black54,
                              size: 15,
                            )),
                        Text(
                          'Terjual ${craft.productSold}',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
