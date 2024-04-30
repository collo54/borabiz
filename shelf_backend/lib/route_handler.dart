import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

final router = Router()
  ..post('/callbackurl', _stkLNMCallback)
  ..get('/token', _tokenHandler);

Future<Response> _tokenHandler(Request request) async {
  if (request.method != 'GET') {
    return Response(405, body: 'Method Not Allowed');
  }
  const String host = 'https://sandbox.safaricom.co.ke/';
  final accessToken = base64Url.encode(
      "9MGZlH7tZGGW2GwSYZT4RlaFYGqRxz1fGWXEEphlYiZB8GVb:eiP59UPV70CE6zfC0kjPefZB3gxsqlMA04GmCbKPHtit6ljJCobooMP6Lci7NJ6T"
          .codeUnits);
  final url =
      Uri.parse('${host}oauth/v1/generate?grant_type=client_credentials');
  final headers = {
    "Authorization": "Basic $accessToken",
  };

  final response = await http.get(
    url,
    headers: headers,
  );

  if (response.statusCode == 200) {
    final responseBody = jsonDecode(response.body);
    final messageContent = responseBody["access_token"].toString();
    return Response.ok(messageContent);
  } else {
    return Response.internalServerError(
      body: 'Safaricom request failed: ${response.body}',
    );
  }
}

Future<Response> _stkLNMCallback(Request request) async {
  //final body = request.
  // if (request.method != 'POST') {
  //   print('Method Not Allowed');
  //   return Response(405, body: 'Method Not Allowed');
  // }

  final body = await request.readAsString();
  final res = {
    "ResponseCode": 0,
    "ResponseDesc": "Accept Service",
  };
  // final stkresult = jsonDecode(body);
  print('/n $body');
  //return Response.ok(jsonEncode(res));
  return Response.ok(res);

  // https://sandbox.safaricom.co.ke/mpesa/stkpushquery/v1/query

//     Headers
// Key: Authorization
// Value: Basic cFJZcjZ6anEwaThMMXp6d1FETUxwWkIzeVBDa2hNc2M6UmYyMkJmWm9nMHFRR2xWOQ==

// Body
//   {
//     "BusinessShortCode": 174379,
//     "Password": "MTc0Mzc5YmZiMjc5ZjlhYTliZGJjZjE1OGU5N2RkNzFhNDY3Y2QyZTBjODkzMDU5YjEwZjc4ZTZiNzJhZGExZWQyYzkxOTIwMjQwNDI2MTc1NzM4",
//     "Timestamp": 20240426175738,
//     "CheckoutRequestID": "ws_CO_26042024174824449743397176"
//   }

  //   {
  // "ResponseCode": "0",
  // "ResponseDescription": "The service request has been accepted successsfully",
  // "MerchantRequestID": "7071-4170-a0e4-8345632bad44142564",
  // "CheckoutRequestID": "ws_CO_26042024174824449743397176",
  // "ResultCode": "0",
  // "ResultDesc": "The service request is processed successfully."
  //  }
}
