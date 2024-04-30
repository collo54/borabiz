import 'dart:convert';

import 'package:bizbora/api/api_service.dart';
import 'package:bizbora/api/http_api_service.dart';
import 'package:bizbora/models/stkrequest_model.dart';
import 'package:bizbora/screens/products_screen.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key, required this.title});

  final String title;

  @override
  ProductsPageState createState() => ProductsPageState();
}

class ProductsPageState extends State<ProductsPage> {
  final _textEditingController = TextEditingController();
  //final repository = Repository();
  final mpesa = Mpesa();
  final _shortCode = "174379";
  String? _accessToken;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kgreen02075310,
        title: Text(
          widget.title,
          style: const TextStyle(color: kwhite25525525510),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Row(
              children: [
                Icon(
                  Icons.add,
                  color: kwhite25525525510,
                  size: 25,
                ),
                SizedBox(
                  width: 3,
                ),
                Text(
                  'add product',
                  style: TextStyle(color: kwhite25525525510),
                ),
              ],
            ),
          ),
        ],
      ),
      body: ProductsScreen(),
    );
  }

  // Future<void> _requestStKCall() async {
  //   try {
  //     String timestamp = getTodayValidTimeStamp();
  //     final stkrequest = StkRequest(
  //       businessShortCode: _shortCode,
  //       password: generatePasswordForStk(timestamp),
  //       timestamp: timestamp,
  //       transactionType: "CustomerPayBillOnline",
  //       amount: "1",
  //       partyA: _textEditingController.text,
  //       partyB: _shortCode,
  //       phoneNumber: _textEditingController.text,
  //       callBackURL: "https://8fa4-196-250-210-167.ngrok-free.app",
  //       accountReference: "account",
  //       transactionDesc: "Lipa Na Mpesa Online",
  //     );
  //     final result =
  //         await repository.stkPushOnlineMerchant(request: stkrequest);
  //   } catch (e) {
  //     setState(() {});
  //   }
  // }

  /// this generates the password for the stk push request
  String generatePasswordForStk(String timestamp) {
    const stkPassword =
        "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919";

    final bytes = utf8.encode("$_shortCode$stkPassword$timestamp");
    return base64.encode(bytes);
  }

  /// this provides the valid date stamp to be used in password generation for stk
  String getTodayValidTimeStamp() {
    var datedefinedstamp = DateTime.now();
    return "${datedefinedstamp.year.toString()}${datedefinedstamp.month.toString().padLeft(2, '0')}${datedefinedstamp.day.toString().padLeft(2, '0')}${datedefinedstamp.hour.toString().padLeft(2, '0')}${datedefinedstamp.minute.toString().padLeft(2, '0')}${datedefinedstamp.second.toString().padLeft(2, '0')}";
  }
}
