import 'dart:convert';
import 'package:http/http.dart';
import 'package:lakuseni_user/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cost.dart';
import '../models/craft.dart';
import '../models/performance.dart';
import '../models/seller_type.dart';

class SellerService {
  Future<SellerType> sellerType() async {
    final response = await get(Uri.parse(MyUrl.sellerType));

    if (response.statusCode == 200) {
      return SellerType.fromJson(json.decode(response.body));
    } else {
      print(response.body);
      throw Exception('Failed to load a seller_type');
    }
  }

  Future<Craft> addCraft(Map<String, dynamic> body) async {
    final prefs = await SharedPreferences.getInstance();
    final response = await post(
      Uri.parse(MyUrl.craft),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': prefs.getString('user_token') ?? ''
      },
      body: jsonEncode(body),
    );

    return Craft.fromJson(json.decode(response.body));
  }

  Future<Performance> addPerformance(Map<String, dynamic> body) async {
    final prefs = await SharedPreferences.getInstance();
    final response = await post(
      Uri.parse(MyUrl.perfromance),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': prefs.getString('user_token') ?? ''
      },
      body: jsonEncode(body),
    );
    print(response.body);
    return Performance.fromJson(json.decode(response.body));
  }
  Future<String> addCost(Map<String, dynamic> body, int order_id) async {
    final prefs = await SharedPreferences.getInstance();
    final response = await post(
      Uri.parse('${MyUrl.addCost}/$order_id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': prefs.getString('user_token') ?? ''
      },
      body: jsonEncode(body),
    );
    print(response.body);
    //  Cost.fromJson(json.decode(response.body));
    return 'Success';
  }
  // Future<Cases> createCase(Cases cases) async {
  //   Map data = {
  //     'name': cases.name,
  //     'gender': cases.gender,
  //     'age': cases.age,
  //     'address': cases.address,
  //     'city': cases.city,
  //     'country': cases.country,
  //     'status': cases.status
  //   };

  //   final Response response = await post(
  //     apiUrl,
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(data),
  //   );
  //   if (response.statusCode == 200) {
  //     return Cases.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception('Failed to post cases');
  //   }
  // }

  // Future<Cases> updateCases(String id, Cases cases) async {
  //   Map data = {
  //     'name': cases.name,
  //     'gender': cases.gender,
  //     'age': cases.age,
  //     'address': cases.address,
  //     'city': cases.city,
  //     'country': cases.country,
  //     'status': cases.status
  //   };

  //   final Response response = await put(
  //     '$apiUrl/$id',
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(data),
  //   );
  //   if (response.statusCode == 200) {
  //     return Cases.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception('Failed to update a case');
  //   }
  // }

  // Future<void> deleteCase(String id) async {
  //   Response res = await delete('$apiUrl/$id');

  //   if (res.statusCode == 200) {
  //     print("Case deleted");
  //   } else {
  //     throw "Failed to delete a case.";
  //   }
  // }
}
