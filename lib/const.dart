import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lakuseni_user/models/payment.dart';

class MyColor {
  static Color get mainColor => const Color(0xFFFFAA0D);
  static Color get fade50MainColor => const Color(0x80FFAA0D);
  static Color get fade20MainColor => const Color(0x1AFFAA0D);
  // static const String lorem = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas dapibus ex elit, a semper nisi aliquam lacinia. Cras at massa a nunc pretium accumsan. Etiam sed ipsum eu lorem cursus accumsan. Donec fermentum felis at metus lacinia, sed bibendum metus tristique. Suspendis';
}

class MyTheme {
  static ButtonStyle get btnAccept => TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: MyColor.mainColor,
        primary: Colors.white,
        textStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      );
  static ButtonStyle get btnAcceptAlt => TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.white,
        side: BorderSide(color: MyColor.mainColor),
        primary: MyColor.mainColor,
        textStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      );
  static ButtonStyle get btnDecline => TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.black12,
        primary: Colors.black87,
        textStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      );
  static ButtonStyle get btnInline => TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        visualDensity: VisualDensity.compact,
        primary: MyColor.mainColor,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      );

  static TextStyle get txtTitle => GoogleFonts.poppins(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      );
}

class MyUrl {
  static String get baseUrl => 'http://192.168.142.85:8000';
  static String get apiUrl => '$baseUrl/api';
  static String get login => '$apiUrl/login';
  static String get logout => '$apiUrl/logout';
  static String get register => '$apiUrl/register';
  static String get profile => '$apiUrl/profile';
  static String get sellerType => '$apiUrl/seller_type/1';
  static String get craft => '$apiUrl/craft';
  // static String get addCraft => '$apiUrl/craft';
  static String get perfromance => '$apiUrl/performance';
  static String get province => '$apiUrl/province';
  static String get order => '$apiUrl/order';
  static String get book => '$apiUrl/book';
  static String get payment => '$order/payment';
  static String get addCost => '$apiUrl/cost';
  static String get admin => '$apiUrl/admin';

  static String get rajaOnkirUrl => 'http://api.rajaongkir.com/starter/';
  static String get cost => '$rajaOnkirUrl/cost';
}
