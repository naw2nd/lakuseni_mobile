import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lakuseni_user/services/address_service.dart';

import 'const.dart';
import 'home_page.dart';
import 'models/address.dart';
import 'models/city.dart';
import 'models/province.dart';

class CourierPage extends StatefulWidget {
  CourierPage({Key? key, required this.address}) : super(key: key);
  Address address;
  @override
  State<CourierPage> createState() => _CourierPageState();
}

class _CourierPageState extends State<CourierPage> {
  // Address address = Address(id: 1, desc: '', url: '', city: city);

  @override
  void initState() {
    // AddressService().provinceIndex().then((value) {
    //   setState(() {
    //     provinces = value;
    //     province = value[0];
    //     cities = province.cities;
    //     city = cities[0];
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih Kurir'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 5, top: 10),
              child: Text(
                'JNE',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  Navigator.pop(context, 'JNE | OKE');
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: Colors.black12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'JNE | OKE (Ongkos Kirim Ekonomis)',
                          maxLines: 1,
                        ),
                      ),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
