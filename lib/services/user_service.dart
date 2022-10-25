import 'dart:convert';
import 'package:http/http.dart';
import 'package:lakuseni_user/const.dart';
import 'package:lakuseni_user/models/payment.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/order.dart';
import '../models/user.dart';

class UserService {
  Future<User> profile() async {
    final prefs = await SharedPreferences.getInstance();
    final response = await get(
      Uri.parse(MyUrl.profile),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': prefs.getString('user_token') ?? ''
      },
    );
    print(response.request);
    print(response.body);
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      print(response.body);
      throw Exception('Failed to load a user');
    }
  }

  Future<Response> login(String email, String password) async {
    final response = await post(
      Uri.parse(MyUrl.login),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );
    print(response.request);
    print(response.body);
    return response;
  }

  Future<Response> register(String name, String email, String phone, String password) async {
    final response = await post(
      Uri.parse(MyUrl.register),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'name': name, 'email': email, 'phone': phone, 'password': password}),
    );
    print(response.request);
    print(response.body);
    return response;
  }

  Future<Response> logout() async {
    final prefs = await SharedPreferences.getInstance();

    final response = await post(
      Uri.parse(MyUrl.logout),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': prefs.getString('user_token') ?? ''
      },
    );
    print(response.request);
    print(response.body);
    await prefs.remove('user_token');
    return response;
  }

  Future<List<Order>> orderAdmin() async {
    final prefs = await SharedPreferences.getInstance();
    final response =
        await get(Uri.parse(MyUrl.admin), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': prefs.getString('user_token') ?? ''
    });
    // print(response.request);
    // print(response.body);
    // print(response.body);
    List<Order> orders =
        List<Order>.from(json.decode(response.body).map((order) {
      return Order.fromJson(order);
    }));
    return orders;
  }

  Future<Payment> adminPayment(int order_id) async {
    final prefs = await SharedPreferences.getInstance();
    final response = await get(Uri.parse('${MyUrl.admin}/$order_id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': prefs.getString('user_token') ?? ''
        });
    // print(response.request);
    // print(response.body);
    print(response.body);
    Payment payment = Payment.fromJson(jsonDecode(response.body));
    return payment;
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
