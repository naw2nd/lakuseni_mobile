import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lakuseni_user/services/address_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'const.dart';
import 'home_page.dart';
import 'models/address.dart';
import 'models/city.dart';
import 'models/province.dart';

class AddressPage extends StatefulWidget {
  AddressPage({Key? key}) : super(key: key);
  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  // Address address = Address(id: 1, desc: '', url: '', city: city);
  TextEditingController tecDesc = TextEditingController();
  TextEditingController tecUrl = TextEditingController();
  List<Province> provinces = [];
  List<City> cities = [];
  Province province = Province(id: -1, name: 'Mengambil data...', cities: []);
  City city = City(id: -1, name: 'Mengambil data...', provinceId: -1);
  @override
  void initState() {
    AddressService().provinceIndex().then((value) {
      setState(() {
        provinces = value;
        province = value[0];
        cities = province.cities;
        city = cities[0];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih Alamat'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: TextFormField(
                controller: tecDesc,
                maxLines: 3,
                decoration: const InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'Alamat Rumah',
                  constraints:
                      const BoxConstraints(maxHeight: double.maxFinite),
                ),
              ),
            ),
            Container(
              height: 45,
              margin: EdgeInsets.only(bottom: 15),
              child: DropdownButtonFormField<Province>(
                decoration: InputDecoration(label: Text('Provinsi')),
                value: province,
                isExpanded: true,
                items: provinces.map(
                  (Province province) {
                    return DropdownMenuItem<Province>(
                        value: province,
                        child: Container(
                          // width: double.maxFinite,
                          child: Text(
                            province.name,
                            style: TextStyle(color: Colors.black),
                          ),
                        ));
                  },
                ).toList(),
                onChanged: (value) {
                  setState(() {
                    province = value!;
                    cities = value.cities;
                    city = cities[0];
                  });
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 15),
              height: 45,
              child: DropdownButtonFormField<City>(
                decoration: InputDecoration(label: Text('Kota/Kabupaten')),
                value: city,
                isExpanded: true,
                items: cities.map(
                  (City city) {
                    return DropdownMenuItem<City>(
                        value: city,
                        child: Container(
                          // width: double.maxFinite,
                          child: Text(
                            city.name,
                            style: TextStyle(color: Colors.black),
                          ),
                        ));
                  },
                ).toList(),
                onChanged: (value) {
                  setState(() {
                    city = value!;
                  });
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: TextFormField(
                controller: tecUrl,
                decoration: InputDecoration(
                  label: Text('Link Google Maps'),
                  contentPadding: EdgeInsets.all(12),
                  suffixIcon: IconButton(
                    onPressed: () {
                      launchUrl(Uri.parse('https://maps.google.com/'));
                    },
                    icon: Icon(Icons.map),
                  ),
                ),
              ),
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
            Address address = Address(
                id: 1, desc: tecDesc.text, url: tecUrl.text, city: city);
            Navigator.pop(context, address);
          },
          child: Text(
            'Tambahkan Alamat',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600, fontSize: 17, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
