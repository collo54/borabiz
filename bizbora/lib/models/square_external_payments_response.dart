class SquareExternalPaymentsResponse {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Money amountMoney;
  final String status;
  final String sourceType;
  final String locationId;
  final String orderId;
  final String note;
  final String customerId;
  final Money totalMoney;
  final List<String> capabilities;
  final ExternalDetails externalDetails;
  final String receiptNumber;
  final String receiptUrl;
  final ApplicationDetails applicationDetails;
  final String versionToken;

  SquareExternalPaymentsResponse({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.amountMoney,
    required this.status,
    required this.sourceType,
    required this.locationId,
    required this.orderId,
    required this.note,
    required this.customerId,
    required this.totalMoney,
    required this.capabilities,
    required this.externalDetails,
    required this.receiptNumber,
    required this.receiptUrl,
    required this.applicationDetails,
    required this.versionToken,
  });

  factory SquareExternalPaymentsResponse.fromMap(Map<String, dynamic> json) {
    return SquareExternalPaymentsResponse(
      id: json['payment']['id'] ?? '',
      createdAt: DateTime.parse(json['payment']['created_at'] ?? ''),
      updatedAt: DateTime.parse(json['payment']['updated_at'] ?? ''),
      amountMoney: Money.fromMap(json['payment']['amount_money'] ?? {}),
      status: json['payment']['status'] ?? '',
      sourceType: json['payment']['source_type'] ?? '',
      locationId: json['payment']['location_id'] ?? '',
      orderId: json['payment']['order_id'] ?? '',
      note: json['payment']['note'] ?? '',
      customerId: json['payment']['customer_id'] ?? '',
      totalMoney: Money.fromMap(json['payment']['total_money'] ?? {}),
      capabilities: List<String>.from(json['payment']['capabilities'] ?? []),
      externalDetails:
          ExternalDetails.fromMap(json['payment']['external_details'] ?? {}),
      receiptNumber: json['payment']['receipt_number'] ?? '',
      receiptUrl: json['payment']['receipt_url'] ?? '',
      applicationDetails: ApplicationDetails.fromMap(
          json['payment']['application_details'] ?? {}),
      versionToken: json['payment']['version_token'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'payment': {
        'id': id,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
        'amount_money': amountMoney.toMap(),
        'status': status,
        'source_type': sourceType,
        'location_id': locationId,
        'order_id': orderId,
        'customer_id': customerId,
        'total_money': totalMoney.toMap(),
        'capabilities': capabilities,
        'external_details': externalDetails.toMap(),
        'receipt_number': receiptNumber,
        'receipt_url': receiptUrl,
        'application_details': applicationDetails.toMap(),
        'version_token': versionToken,
      }
    };
  }
}

class Money {
  final int amount;
  final String currency;

  Money({required this.amount, required this.currency});

  factory Money.fromMap(Map<String, dynamic> json) {
    return Money(
      amount: json['amount'] ?? 0,
      currency: json['currency'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'currency': currency,
    };
  }
}

class ExternalDetails {
  final String type;
  final String source;
  final String sourceId;
  final Money sourceFeeMoney;

  ExternalDetails({
    required this.type,
    required this.source,
    required this.sourceId,
    required this.sourceFeeMoney,
  });

  factory ExternalDetails.fromMap(Map<String, dynamic> json) {
    return ExternalDetails(
      type: json['type'] ?? '',
      source: json['source'] ?? '',
      sourceId: json['source_id'] ?? '',
      sourceFeeMoney: Money.fromMap(json['source_fee_money'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'source': source,
      'source_id': sourceId,
      'source_fee_money': sourceFeeMoney.toMap(),
    };
  }
}

class ApplicationDetails {
  final String squareProduct;
  final String applicationId;

  ApplicationDetails(
      {required this.squareProduct, required this.applicationId});

  factory ApplicationDetails.fromMap(Map<String, dynamic> json) {
    return ApplicationDetails(
      squareProduct: json['square_product'] ?? '',
      applicationId: json['application_id'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'square_product': squareProduct,
      'application_id': applicationId,
    };
  }
}


// {
//   "payment": {
//     "id": "9MRzVnDyi6QzfcsPRYEmevuDZ4PZY",
//     "created_at": "2024-04-28T20:37:08.179Z",
//     "updated_at": "2024-04-28T20:37:08.332Z",
//     "amount_money": {
//       "amount": 40,
//       "currency": "USD"
//     },
//     "status": "COMPLETED",
//     "source_type": "EXTERNAL",
//     "location_id": "L0976QXCW7V28",
//     "order_id": "tCdWY5ZmwRTeXBK4Vo3tatvfuO9YY",
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
//     "external_details": {
//       "type": "EMONEY",
//       "source": "Mpesa ",
//       "source_id": "EXTERNAL",
//       "source_fee_money": {
//         "amount": 0,
//         "currency": "USD"
//       }
//     },
//     "receipt_number": "9MRz",
//     "receipt_url": "https://squareupsandbox.com/receipt/preview/9MRzVnDyi6QzfcsPRYEmevuDZ4PZY",
//     "application_details": {
//       "square_product": "ECOMMERCE_API",
//       "application_id": "sandbox-sq0idb-XsiCUTkMwkWYeZnyn8-wbQ"
//     },
//     "version_token": "o6550q4mZvGaqLihwf7YiHzXw4YEhRQr32ouyjyEzL16o"
//   }
// }

//partial auth false
// {
//   "payment": {
//     "id": "tcx9TQGt8pEWDY1KDOK4xZPGO4NZY",
//     "created_at": "2024-04-29T09:31:46.230Z",
//     "updated_at": "2024-04-29T09:31:46.383Z",
//     "amount_money": {
//       "amount": 110,
//       "currency": "USD"
//     },
//     "status": "COMPLETED",
//     "source_type": "EXTERNAL",
//     "location_id": "L0976QXCW7V28",
//     "order_id": "FmHJWVLnea8Xh0Q1SUxicPYl1wCZY",
//     "customer_id": "MHTPXJSBE0BQKJA8YVD8HQM330",
//     "total_money": {
//       "amount": 110,
//       "currency": "USD"
//     },
//     "capabilities": [
//       "EDIT_AMOUNT_UP",
//       "EDIT_AMOUNT_DOWN",
//       "EDIT_TIP_AMOUNT_UP",
//       "EDIT_TIP_AMOUNT_DOWN"
//     ],
//     "external_details": {
//       "type": "EMONEY",
//       "source": "Mpesa ",
//       "source_id": "EXTERNAL",
//       "source_fee_money": {
//         "amount": 0,
//         "currency": "USD"
//       }
//     },
//     "receipt_number": "tcx9",
//     "receipt_url": "https://squareupsandbox.com/receipt/preview/tcx9TQGt8pEWDY1KDOK4xZPGO4NZY",
//     "application_details": {
//       "square_product": "ECOMMERCE_API",
//       "application_id": "sandbox-sq0idb-XsiCUTkMwkWYeZnyn8-wbQ"
//     },
//     "version_token": "atjrmg4oP6lABzqkEokL01N0ZnCot9GfC5qg0pNWTIR6o"
//   }
// }