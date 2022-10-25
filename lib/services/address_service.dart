import 'dart:convert';

import 'package:http/http.dart';
import 'package:lakuseni_user/models/province.dart';

import '../const.dart';

class AddressService {
  Future<List<Province>> provinceIndex() async {
    final response = await get(
      Uri.parse(MyUrl.province),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.request);
    print(response.body);
    List<Province> list = List<Province>.from(json
        .decode(response.body)
        .map((province) => Province.fromJson(province)));
    return list;
  }
}
