import 'dart:convert';

import 'package:bizbora/models/list_catalogue_response.dart';
import 'package:bizbora/models/list_payments_response.dart';
import 'package:bizbora/models/square_create_order_request.dart';
import 'package:bizbora/models/square_create_order_response.dart';
import 'package:bizbora/models/square_retrieve_order_response.dart';
import 'package:bizbora/models/upsert_catalogobject_request.dart';
import 'package:bizbora/models/upsert_catalogobject_response.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/create_customer_request.dart';
import '../models/overall_customer_response.dart';
import '../models/square_cash_payment_response.dart';
import '../models/square_cash_payments_request.dart';
import '../models/square_external_payment_request.dart';
import '../models/square_external_payments_response.dart';

class WebClient {
  // String get _host =>
  //     Platform.isAndroid ? 'http://10.0.2.2:8080' : 'http://127.0.0.1:8080';
  final _host = 'http://192.168.88.243:8080';
  static const String _squarehost = 'https://connect.squareupsandbox.com';

  Future<String> fetchToken() async {
    final response = await http.get(Uri.parse('$_host/token'));
    if (response.statusCode != 200) {
      throw ClientException('Error getting tip: ${response.body}');
    }
    return response.body;
  }

  Future<OverrallCustomerResponse> createandgetCustomerData({
    required String accessToken,
    required CreateCustomerRequestModel customerRequestModel,
  }) async {
    final uri = Uri.parse('$_squarehost/v2/customers');
    final response = await http.post(
      uri,
      headers: {
        'Square-Version': '2024-04-17',
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        customerRequestModel.toMap(),
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return OverrallCustomerResponse.fromMap(data);
    }

    debugPrint(
      'Request $uri failed /n Response: ${response.statusCode} ${response.reasonPhrase}',
    );

    throw response;
  }

  Future<SquareCashPaymentsResponse> createSquareCashPayment({
    required String accessToken,
    required SquareCashPaymentsRequest requestModel,
  }) async {
    final uri = Uri.parse('$_squarehost/v2/payments');
    final response = await http.post(
      uri,
      headers: {
        'Square-Version': '2024-04-17',
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        requestModel.toMap(),
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return SquareCashPaymentsResponse.fromJson(data);
    }

    debugPrint(
      'Request $uri failed /n Response: ${response.statusCode} ${response.reasonPhrase}',
    );

    throw response;
  }

  Future<SquareExternalPaymentsResponse> createExternalSquarePayment({
    required String accessToken,
    required SquareExternalPaymentsRequest requestModel,
  }) async {
    final uri = Uri.parse('$_squarehost/v2/payments');
    final response = await http.post(
      uri,
      headers: {
        'Square-Version': '2024-04-17',
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        requestModel.toMap(),
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return SquareExternalPaymentsResponse.fromMap(data);
    }

    debugPrint(
      'Request $uri failed /n Response: ${response.statusCode} ${response.reasonPhrase}',
    );

    throw response;
  }

  Future<UpsertCatalogObjectResponse> upsertCatalogObject({
    required String accessToken,
    required UpsertCatalogObjectRequest requestModel,
  }) async {
    final uri = Uri.parse('$_squarehost/v2/catalog/object');
    final response = await http.post(
      uri,
      headers: {
        'Square-Version': '2024-04-17',
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        requestModel.toMap(),
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return UpsertCatalogObjectResponse.fromMap(data);
    }

    debugPrint(
      'Request $uri failed /n Response: ${response.statusCode} ${response.reasonPhrase}',
    );

    throw response;
  }

  Future<ListCatalogResponse> listCatalog({
    required String accessToken,
  }) async {
    final uri = Uri.parse('$_squarehost/v2/catalog/list');
    final response = await http.get(
      uri,
      headers: {
        'Square-Version': '2024-04-17',
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return ListCatalogResponse.fromMap(data);
    }

    debugPrint(
      'Request $uri failed /n Response: ${response.statusCode} ${response.reasonPhrase}',
    );

    throw response;
  }

  Future<SquareCreateOrderResponse> createOrder({
    required String accessToken,
    required SquareCreateOrderRequest requestModel,
  }) async {
    final uri = Uri.parse('$_squarehost/v2/orders');
    final response = await http.post(
      uri,
      headers: {
        'Square-Version': '2024-04-17',
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        requestModel.toJson(),
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> datab = json.decode(response.body);
      final Map<String, dynamic> dataa = datab['order'];
      return SquareCreateOrderResponse.fromMap(dataa);
    }

    debugPrint(
      'Request $uri failed /n Response: ${response.statusCode} ${response.reasonPhrase}',
    );

    throw response;
  }

  Future<SquareRetrieveOrderResponse> retrieveOrder({
    required String accessToken,
    required String orderId,
  }) async {
    final uri = Uri.parse('$_squarehost/v2/orders/$orderId');
    final response = await http.get(
      uri,
      headers: {
        'Square-Version': '2024-04-17',
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return SquareRetrieveOrderResponse.fromMap(data);
    }

    debugPrint(
      'Request $uri failed /n Response: ${response.statusCode} ${response.reasonPhrase}',
    );

    throw response;
  }

  Future<ListPaymentsResponse> listPayments({
    required String accessToken,
    required String orderId,
  }) async {
    final uri = Uri.parse(
        '$_squarehost/v2/payments?location_id=L0976QXCW7V28&sort_order=DESC');
    final response = await http.get(
      uri,
      headers: {
        'Square-Version': '2024-04-17',
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return ListPaymentsResponse.fromMap(data);
    }

    debugPrint(
      'Request $uri failed /n Response: ${response.statusCode} ${response.reasonPhrase}',
    );

    throw response;
  }
}

class ClientException implements Exception {
  ClientException(this.message);
  final String message;
}
