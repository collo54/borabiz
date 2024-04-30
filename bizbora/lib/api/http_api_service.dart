import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/stkresponse_model.dart';

/// Initializes a new instance of [Mpesa]
/// Requires 4 parameters:
///
/// 1. `clientKey` - This is your consumer key
///
/// 2. `clientSecret` - This is your consumer secret
///
/// 3. `environment` - This is the environment our app is running on. It can either be `sandbox` or `production`.
///
/// 4. `initiatorPassword` - You can get this from Your Portal(production) or from test credentials(Sandbox). It will be the Security Credential (Shortcode 1)
class Mpesa {
  //      environment == "production" ? Routes.production : Routes.sandbox,
  //  _accessToken = base64Url.encode("$clientKey:$clientSecret".codeUnits);

  static const String host = 'https://sandbox.safaricom.co.ke/';

  // ignore: public_member_api_docs
  Future<String> authenticate() async {
    try {
      final accessToken = base64Url.encode(
          "9MGZlH7tZGGW2GwSYZT4RlaFYGqRxz1fGWXEEphlYiZB8GVb:eiP59UPV70CE6zfC0kjPefZB3gxsqlMA04GmCbKPHtit6ljJCobooMP6Lci7NJ6T"
              .codeUnits);
      final http.Response response = await http.get(
        Uri.parse("${host}oauth/v1/generate?grant_type=client_credentials"),
        headers: {
          "Authorization": "Basic $accessToken",
        },
      );

      final data = json.decode(response.body);
      final String accessTokenfromdata = data["access_token"].toString();

      if (response.statusCode != 200) {
        throw Exception('Failed to authenticate with Mpesa API');
      }

      debugPrint(accessTokenfromdata);
      return accessTokenfromdata;
    } catch (e) {
      throw Exception('Failed to authenticate with Mpesa API: $e');
    }
  }

  /// Triggers a lipa na mpesa stk push and presents user with dialog to input mpesa pin. The method will complete regardless of whether the transaction was successful or not. Results of the transaction are sent to the [callbackUrl] provided. Ensure that the [callbackUrl] provided is publicly accessible. You can use ngrok,local-tunnel or serveo for local development.
  ///
  /// `phoneNumber` is the phone number(MSISDN) to be charged. It must be a registered mpesa number(MSISDN) and should contain the international dialing code i.e `254`. For example `254712345678`
  ///
  /// `amount` is the amount to be charged. During development/sandbox all money transferred is refunded by Safaricom within 24 hours. Please note that this is only applicable if you're using the [businessShortCode] provided by Safaricom and not a real one.
  ///
  /// `callbackUrl` is the URL to which Mpesa responses are sent upon success or failure of a transaction. Should be able to receive post requests.
  ///
  /// `businessShortCode` can be obtained from https://developer.safaricom.co.ke/APIs/MpesaExpressSimulate under the Lipa Na Mpesa Online simulator under PartyB. You can ignore this if you have already set it in [globalBusinessShortCode]. Please note that this is for the sandbox environment. Use your registered business short code for production.
  ///
  /// `transactionType` is the type of transaction. Default value is "CustomerPayBillOnline".
  ///
  /// `accountReference` is used with Mpesa paybill as the account number.
  ///
  /// `transactionDescription` is the description of the transaction. Default value is "Lipa Na Mpesa Online".
  ///
  ///  Please see https://developer.safaricom.co.ke/Documentation for more info.
  Future<StkResponse> lipaNaMpesa({
    required String phoneNumber,
    required double amount,
    // required String callbackUrl,
    // required String businessShortCode,
    String transactionType = "CustomerPayBillOnline",
    String accountReference = "account",
    String transactionDescription = "Lipa Na Mpesa Online",
    String payBill = '174379',
    //String amount = '10',
    // String phoneNumber = '254743397176',
    String callbackUrl =
        'https://d35e-196-250-210-152.ngrok-free.app/callbackurl',
  }) async {
    // if (amount < 1.0) {
    //   throw Exception("Amount should be at least Ksh 1");
    // }

    final now = DateTime.now();
    // const payBill = '174379';
    // const amount = '1';
    // const phoneNumber = '0743397176';
    // const callbackUrl = 'https://c1fa-196-250-210-183.ngrok-free.app';

    // if (payBill == null) {
    //   throw Exception(
    //     "Paybill must be set either via businessShortCode or via globalBusinessShortCode",
    //   );
    // }

    final timestamp = _generateTimestamp(now);
    final String password = _generatePassword(payBill, timestamp);

    final String token = await authenticate();

    final String body = json.encode({
      'BusinessShortCode': payBill,
      'Password': password,
      'Timestamp': timestamp,
      'TransactionType': transactionType,
      'Amount': amount,
      'PartyA': phoneNumber,
      'PartyB': payBill,
      'PhoneNumber': phoneNumber,
      'CallBackURL': callbackUrl,
      'AccountReference': accountReference,
      'TransactionDesc': transactionDescription
    });

    final http.Response response = await http.post(
      Uri.parse(
          "https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest"),
      body: body,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    debugPrint("passed call stk");
    if (response.statusCode != 200) {
      throw Exception(
          'Failed to process Mpesa transaction ${response.reasonPhrase}');
    }
    debugPrint("call is 200 stk");
    return StkResponse.fromJson(
      json.decode(response.body) as Map<String, dynamic>,
    );
  }

  String _generateTimestamp(DateTime now) {
    return "${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}";
  }

  String _generatePassword(String paybill, String timestamp) {
    final String rawPassword =
        "${paybill}bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919$timestamp";
    final List<int> passwordBytes = utf8.encode(rawPassword);
    return base64.encode(passwordBytes);
  }
}
