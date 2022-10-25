import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../const.dart';
import '../models/craft.dart';
import '../models/performance.dart';

class ProductService {
  Future<List<Craft>> craftIndex() async {
    final prefs = await SharedPreferences.getInstance();
    final response = await get(
      Uri.parse(MyUrl.craft),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': prefs.getString('user_token') ?? ''
      },
    );
    print(response.request);
    print(response.body);
    List<Craft> list = List<Craft>.from(
        json.decode(response.body).map((craft) => Craft.fromJson(craft)));
    return list;
  }

  Future<List<Performance>> performanceIndex() async {
    final prefs = await SharedPreferences.getInstance();
    final response = await get(
      Uri.parse(MyUrl.perfromance),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': prefs.getString('user_token') ?? ''
      },
    );
    print(response.request);
    print(response.body);
    List<Performance> list = List<Performance>.from(json
        .decode(response.body)
        .map((performance) => Performance.fromJson(performance)));
    return list;
  }



}
