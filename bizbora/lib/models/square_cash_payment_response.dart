class SquareCashPaymentsResponse {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Money amountMoney;
  final String status;
  final String sourceType;
  final String locationId;
  final String orderId;
  final String customerId;
  final Money totalMoney;
  final List<String> capabilities;
  final CashDetails cashDetails;
  final String receiptNumber;
  final String receiptUrl;
  final ApplicationDetails applicationDetails;
  final String versionToken;

  SquareCashPaymentsResponse({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.amountMoney,
    required this.status,
    required this.sourceType,
    required this.locationId,
    required this.orderId,
    required this.customerId,
    required this.totalMoney,
    required this.capabilities,
    required this.cashDetails,
    required this.receiptNumber,
    required this.receiptUrl,
    required this.applicationDetails,
    required this.versionToken,
  });

  factory SquareCashPaymentsResponse.fromJson(Map<String, dynamic> json) {
    return SquareCashPaymentsResponse(
      id: json['payment']['id'],
      createdAt: DateTime.parse(json['payment']['created_at']),
      updatedAt: DateTime.parse(json['payment']['updated_at']),
      amountMoney: Money.fromJson(json['payment']['amount_money']),
      status: json['payment']['status'],
      sourceType: json['payment']['source_type'],
      locationId: json['payment']['location_id'],
      orderId: json['payment']['order_id'],
      customerId: json['payment']['customer_id'],
      totalMoney: Money.fromJson(json['payment']['total_money']),
      capabilities: List<String>.from(json['payment']['capabilities']),
      cashDetails: CashDetails.fromJson(json['payment']['cash_details']),
      receiptNumber: json['payment']['receipt_number'],
      receiptUrl: json['payment']['receipt_url'],
      applicationDetails:
          ApplicationDetails.fromJson(json['payment']['application_details']),
      versionToken: json['payment']['version_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'amount_money': amountMoney.toJson(),
      'status': status,
      'source_type': sourceType,
      'location_id': locationId,
      'order_id': orderId,
      'customer_id': customerId,
      'total_money': totalMoney.toJson(),
      'capabilities': capabilities,
      'cash_details': cashDetails.toJson(),
      'receipt_number': receiptNumber,
      'receipt_url': receiptUrl,
      'application_details': applicationDetails.toJson(),
      'version_token': versionToken,
    };
  }
}

class Money {
  final int amount;
  final String currency;

  Money({required this.amount, required this.currency});

  factory Money.fromJson(Map<String, dynamic> json) {
    return Money(
      amount: json['amount'],
      currency: json['currency'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'currency': currency,
    };
  }
}

class CashDetails {
  final Money buyerSuppliedMoney;
  final Money changeBackMoney;

  CashDetails(
      {required this.buyerSuppliedMoney, required this.changeBackMoney});

  factory CashDetails.fromJson(Map<String, dynamic> json) {
    return CashDetails(
      buyerSuppliedMoney: Money.fromJson(json['buyer_supplied_money']),
      changeBackMoney: Money.fromJson(json['change_back_money']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'buyer_supplied_money': buyerSuppliedMoney.toJson(),
      'change_back_money': changeBackMoney.toJson(),
    };
  }
}

class ApplicationDetails {
  final String squareProduct;
  final String applicationId;

  ApplicationDetails(
      {required this.squareProduct, required this.applicationId});

  factory ApplicationDetails.fromJson(Map<String, dynamic> json) {
    return ApplicationDetails(
      squareProduct: json['square_product'],
      applicationId: json['application_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'square_product': squareProduct,
      'application_id': applicationId,
    };
  }
}

//Response example 
// {
//   "payment": {
//     "id": "L3jjXK4U5EuzL3m55kxVwqpFEw5YY",
//     "created_at": "2024-04-28T19:26:43.180Z",
//     "updated_at": "2024-04-28T19:26:43.333Z",
//     "amount_money": {
//       "amount": 40,
//       "currency": "USD"
//     },
//     "status": "COMPLETED",
//     "source_type": "CASH",
//     "location_id": "L0976QXCW7V28",
//     "order_id": "dSXDJs9erYJT6go8Hv3TKy4UUtWZY",
//     "customer_id": "MHTPXJSBE0BQKJA8YVD8HQM330",
//     "total_money": {
//       "amount": 40,
//       "currency": "USD"
//     },
//     "capabilities": [
//       "EDIT_AMOUNT_UP",
//       "EDIT_AMOUNT_DOWN",
//       "EDIT_TIP_AMOUNT_UP",
//       "EDIT_TIP_AMOUNT_DOWN",
//       "EDIT_DELAY_ACTION"
//     ],
//     "cash_details": {
//       "buyer_supplied_money": {
//         "amount": 40,
//         "currency": "USD"
//       },
//       "change_back_money": {
//         "amount": 0,
//         "currency": "USD"
//       }
//     },
//     "receipt_number": "L3jj",
//     "receipt_url": "https://squareupsandbox.com/receipt/preview/L3jjXK4U5EuzL3m55kxVwqpFEw5YY",
//     "application_details": {
//       "square_product": "ECOMMERCE_API",
//       "application_id": "sandbox-sq0idb-XsiCUTkMwkWYeZnyn8-wbQ"
//     },
//     "version_token": "HrwDIcTnmu4LPJO43MC5YXkIcDXQHoxU33I9AeszcaK6o"
//   }
// }