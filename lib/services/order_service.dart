import 'dart:convert';

import 'package:http/http.dart';
import 'package:lakuseni_user/models/delivery.dart';
import 'package:lakuseni_user/models/package.dart';
import 'package:lakuseni_user/models/province.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../const.dart';
import '../models/order.dart';
import '../models/payment.dart';

class OrderService {
  Future<Order> orderStore(Map<String, dynamic> body) async {
    final prefs = await SharedPreferences.getInstance();
    final response = await post(Uri.parse(MyUrl.order),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': prefs.getString('user_token') ?? ''
        },
        body: jsonEncode(body));
    // print(response.request);
    // print(response.body);
    print(response.body);
    Order order = Order.fromJson(jsonDecode(response.body));
    return order;
  }

  Future<Order> bookStore(Map<String, dynamic> body) async {
    final prefs = await SharedPreferences.getInstance();
    final response = await post(Uri.parse(MyUrl.book),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': prefs.getString('user_token') ?? ''
        },
        body: jsonEncode(body));

    dynamic json = jsonDecode(response.body);
    json['date'] = json['date']['date'];
    print(json);
    Order order = Order.fromJson(json);
    return order;
  }

  Future<List<Order>> orderIndex() async {
    final prefs = await SharedPreferences.getInstance();
    final response =
        await get(Uri.parse(MyUrl.order), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': prefs.getString('user_token') ?? ''
    });
    // print(response.request);
    // print(response.body);
    // print(response.body);
    List<Order> orders =
        List<Order>.from(json.decode(response.body).map((order) {
      print(order['id']);
      print(order['product_name']);
      print(order['cost']);

      return Order.fromJson(order);
    }));
    return orders;
  }

  Future<Payment> paymentStore(Payment request) async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> body = {
      'order_id': request.orderId,
      'image_base64': request.imageUrl,
    };
    final response = await post(Uri.parse(MyUrl.payment),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': prefs.getString('user_token') ?? ''
        },
        body: jsonEncode(body));
    // print(response.request);
    // print(response.body);
    print(response.body);
    Payment payment = Payment.fromJson(jsonDecode(response.body));
    return payment;
  }

  Future<List<Package>> packageIndex(int orderId) async {
    final prefs = await SharedPreferences.getInstance();
    final response = await get(
      Uri.parse('${MyUrl.book}/$orderId/package'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': prefs.getString('user_token') ?? ''
      },
    );
    print(response.request);
    print(response.body);
    List<Package> list = List<Package>.from(
        json.decode(response.body).map((package) => Package.fromJson(package)));
    return list;
  }

  Future<Order> updateOrder(int orderId, int statusId) async {
    final prefs = await SharedPreferences.getInstance();
    final response = await put(Uri.parse('${MyUrl.order}/$orderId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': prefs.getString('user_token') ?? ''
        },
        body: jsonEncode({'order_status_id': statusId}));

    print(response.request);
    print(response.body);
    Order order = Order.fromJson(jsonDecode(response.body));
    return order;
  }

  Future<Delivery> storeDelivery(int orderId, String recipt_number) async {
    final prefs = await SharedPreferences.getInstance();
    final response = await post(Uri.parse('${MyUrl.order}/$orderId/delivery'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': prefs.getString('user_token') ?? ''
        },
        body: jsonEncode({'receipt_number': recipt_number}));

    print(response.request);
    print(response.body);
    Delivery delivery = Delivery.fromJson(jsonDecode(response.body));
    return delivery;
  }

  Future<Delivery> showDelivery(int orderId) async {
    final prefs = await SharedPreferences.getInstance();
    final response = await get(
      Uri.parse('${MyUrl.order}/$orderId/delivery'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': prefs.getString('user_token') ?? ''
      },
    );

    print(response.request);
    print(response.body);
    Delivery delivery = Delivery.fromJson(jsonDecode(response.body));
    return delivery;
  }
}
