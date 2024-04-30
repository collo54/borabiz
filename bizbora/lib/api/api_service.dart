// import 'dart:convert';

// import 'package:bizbora_flutter/models/stkrequest_model.dart';
// import 'package:bizbora_flutter/models/stkresponse_model.dart';
// import 'package:dio/dio.dart';

// class Repository {
//   final dio = Dio();
//   static const String host = 'https://sandbox.safaricom.co.ke/';
//   // static String darajasandboxkey =
//   //     "S285b09LMUtTdlQzaFllT0ltZFhMRXZrcmNVU3BXa0E6VDhkcjF1YjhNQXdHZkF3ag";

//   String encodeCredentials(String key, String secret) {
//     String credentials = '$key:$secret';
//     Codec<String, String> stringToBase64 = utf8.fuse(base64);
//     String encoded = stringToBase64.encode(credentials);
//     return encoded;
//   }

//   Future<StkResponse> stkPushOnlineMerchant({
//     required StkRequest request,
//   }) async {
//     // "access_token" -> "ALuQnnxoAcD7deqtf9F6JmUddVS2"
//     // final accessToken = await getAccessToken();
//     final body = {
//       "BusinessShortCode": request.businessShortCode,
//       "Password": request.password,
//       "Timestamp": request.timestamp,
//       "TransactionType": request.transactionType,
//       "Amount": request.amount,
//       "PartyA": request.partyA,
//       "PartyB": request.partyB,
//       "PhoneNumber": request.phoneNumber,
//       "CallBackURL": request.callBackURL,
//       "AccountReference": request.accountReference,
//       "TransactionDesc": request.transactionDesc,
//     };
//     final response = await dio.post(
//       '${host}mpesa/stkpush/v1/processrequest',
//       options: Options(
//         followRedirects: false,
//         validateStatus: (status) {
//           return true;
//         },
//         headers: {
//           'Accept': 'application/json',
//           'Content-Type': 'application/json',
//           "Authorization": "Bearer VdH1amaa37Pl5QYoFJ2wibkmwfNX ",
//         },
//       ),
//       data: jsonEncode(body),
//     );
//     if (response.statusCode == 200) {
//       final Map<String, dynamic> data = response.data;
//       return StkResponse.fromJson(data);
//     } else {
//       final Map<String, dynamic> data = response.data;
//       return StkResponse.fromJson(data);
//     }
//   }

//   Future<String> getAccessToken() async {
//     String mpesaKey = '9MGZlH7tZGGW2GwSYZT4RlaFYGqRxz1fGWXEEphlYiZB8GVb';
//     String mpesaSecret =
//         'eiP59UPV70CE6zfC0kjPefZB3gxsqlMA04GmCbKPHtit6ljJCobooMP6Lci7NJ6T';

//     String auth = encodeCredentials(mpesaKey, mpesaSecret);
//     final response = await dio.get(
//       '${host}oauth/v1/generate?grant_type=client_credentials',
//       options: Options(
//         followRedirects: false,
//         validateStatus: (status) {
//           return true;
//         },
//         headers: {
//           'Accept': 'application/json',
//           'Content-Type': 'application/json',
//           'Authorization': 'Basic $auth',
//         },
//       ),
//     );
//     if (response.statusCode == 200) {
//       final data = json.decode(response.data);
//       final accessToken = data['access_token'];
//       // if (accessToken != null) {
//       return accessToken;
//       //  }
//     } else {
//       return response.statusMessage!;
//     }
//   }
// }
