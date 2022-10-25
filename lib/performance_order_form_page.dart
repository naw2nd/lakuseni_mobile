import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lakuseni_user/models/address.dart';
import 'package:lakuseni_user/models/package.dart';
import 'package:lakuseni_user/models/performance.dart';
import 'package:lakuseni_user/order_performance_page.dart';
import 'package:lakuseni_user/services/order_service.dart';
import 'package:money_formatter/money_formatter.dart';

import 'address_page.dart';
import 'const.dart';

class PerformanceOrderFormPage extends StatefulWidget {
  PerformanceOrderFormPage({Key? key, required this.performance})
      : super(key: key);
  Performance performance;
  @override
  State<PerformanceOrderFormPage> createState() =>
      _PerformanceOrderFormPageState();
}

class _PerformanceOrderFormPageState extends State<PerformanceOrderFormPage> {
  // List<String> _strPackage = ['Acara Siang', 'Acara Malam', 'Acara Sore'];
  int _selectedPackageId = 0;
  TextEditingController _tecLocation = TextEditingController();
  TextEditingController _tecDate = TextEditingController();
  TextEditingController _tecDesc = TextEditingController();
  List<int> _selectedAdditionalPacakage = [];
  List<Package> _mainPackages = [];
  List<Package> _additionalPackages = [];
  late Address address;
  String alamat = 'Lokasi Pertunjukan';
  @override
  void initState() {
    for (Package package in widget.performance.packages) {
      if (package.packageType == 'main')
        _mainPackages.add(package);
      else
        _additionalPackages.add(package);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengajuan Pesanan'),
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
                            child: Image.network(
                              MyUrl.baseUrl +
                                  widget.performance.productImages[0].imageUrl,
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
                                  widget.performance.sellerName,
                                  maxLines: 1,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                // margin: EdgeInsets.only(bottom: 5),
                                child: Text(
                                  widget.performance.productName,
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
                'Jenis Paket',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10),
                  width: 110,
                  height: 110,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Image.network(
                      MyUrl.baseUrl +
                          _mainPackages[_selectedPackageId].imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        width: double.maxFinite,
                        margin: EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black12,
                        ),
                        child: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          children: [
                            Text(
                              '${_mainPackages[_selectedPackageId].name} :',
                              maxLines: 1,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            Text(
                              MoneyFormatter(
                                amount: _mainPackages[_selectedPackageId].price,
                                settings: MoneyFormatterSettings(
                                    symbol: 'Rp',
                                    thousandSeparator: '.',
                                    decimalSeparator: ',',
                                    fractionDigits: 0),
                              ).output.symbolOnLeft,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 5),
                        child: Text(
                          _mainPackages[_selectedPackageId].desc,
                          maxLines: 4,
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 15),
              height: 30,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _mainPackages.length,
                itemBuilder: (BuildContext context, int id) {
                  return Container(
                    margin: EdgeInsets.only(right: 10),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: _selectedPackageId == id
                            ? MyColor.fade20MainColor
                            : Colors.white,
                        side: BorderSide(
                            color: _selectedPackageId == id
                                ? MyColor.mainColor
                                : Colors.black26),
                      ),
                      onPressed: () {
                        setState(() {
                          _selectedPackageId = id;
                        });
                      },
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 5),
                            child: Text(
                              _mainPackages[id].name,
                              style: TextStyle(
                                  color: _selectedPackageId == id
                                      ? MyColor.mainColor
                                      : Colors.black87),
                              maxLines: 1,
                            ),
                          ),
                          _selectedPackageId == id
                              ? Icon(
                                  Icons.check_box,
                                  color: MyColor.mainColor,
                                  size: 18,
                                )
                              : Icon(
                                  Icons.check_box_outline_blank,
                                  color: Colors.black87,
                                  size: 18,
                                )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text(
                'Detail Pesanan',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () async {
                  address = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddressPage(),
                    ),
                  );
                  setState(() {
                    alamat = address.desc;
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: Colors.black45),
                  ),
                  child: Container(
                    child: Text(
                      alamat,
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: TextFormField(
                controller: _tecDate,
                decoration: const InputDecoration(
                  labelText: 'Tanggal Acara',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: TextFormField(
                controller: _tecDesc,
                maxLines: 3,
                decoration: const InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'Catatan Pemesanan',
                  constraints:
                      const BoxConstraints(maxHeight: double.maxFinite),
                ),
              ),
            ),
            Container(
              // margin: EdgeInsets.only(bottom: 10),
              child: Text(
                'Paket Tambahan',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            Wrap(
              runSpacing: 0,
              children: _additionalPackages.map((package) {
                int id = _additionalPackages.indexOf(package);
                return OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: _selectedAdditionalPacakage.contains(id)
                        ? MyColor.fade20MainColor
                        : Colors.white,
                    side: BorderSide(
                      color: _selectedAdditionalPacakage.contains(id)
                          ? MyColor.mainColor
                          : Colors.black38,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedAdditionalPacakage.contains(id)
                          ? _selectedAdditionalPacakage.remove(id)
                          : _selectedAdditionalPacakage.add(id);
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.menu,
                              size: 18,
                              color: _selectedAdditionalPacakage.contains(id)
                                  ? MyColor.mainColor
                                  : Colors.black87,
                            ),
                          ),
                          Text(
                            package.name,
                            maxLines: 1,
                            style: TextStyle(
                                color: _selectedAdditionalPacakage.contains(id)
                                    ? MyColor.mainColor
                                    : Colors.black87),
                          )
                        ],
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Text(
                              MoneyFormatter(
                                amount: package.price,
                                settings: MoneyFormatterSettings(
                                    symbol: 'Rp',
                                    thousandSeparator: '.',
                                    decimalSeparator: ',',
                                    fractionDigits: 0),
                              ).output.symbolOnLeft,
                              style: TextStyle(
                                  color:
                                      _selectedAdditionalPacakage.contains(id)
                                          ? MyColor.mainColor
                                          : Colors.black87),
                            ),
                          ),
                          Icon(
                            _selectedAdditionalPacakage.contains(id)
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            size: 18,
                            color: _selectedAdditionalPacakage.contains(id)
                                ? MyColor.mainColor
                                : Colors.black87,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
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
            List<Map<String, dynamic>> packages = [];
            int mainPackage = _mainPackages[_selectedPackageId].id;
            packages.add({'package_id': mainPackage});
            for (int id in _selectedAdditionalPacakage) {
              packages.add({'package_id': _additionalPackages[id].id});
            }
            Map<String, dynamic> body = {
              'product_id': widget.performance.productId,
              'city_id': address.city.id,
              'address_url': address.url,
              'address_desc': address.desc,
              'desc' : _tecDesc.text,
              'date': _tecDate.text,
              'package': packages
            };
            print('=============================');
            print(body);
            OrderService().bookStore(body).then((value) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderPerformancePage(
                    order: value,
                  ),
                ),
              );
            });
          },
          child: Text(
            'Pesan Sekarang',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600, fontSize: 17, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
