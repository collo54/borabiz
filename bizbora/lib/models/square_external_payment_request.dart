class SquareExternalPaymentsRequest {
  final String idempotencyKey;
  final String sourceId;
  final ExternalPaymentsRequestMoney amountMoney;
  final String customerId;
  final ExternalDetails externalDetails;

  SquareExternalPaymentsRequest({
    required this.idempotencyKey,
    required this.sourceId,
    required this.amountMoney,
    required this.customerId,
    required this.externalDetails,
  });

  factory SquareExternalPaymentsRequest.fromMap(Map<String, dynamic> map) {
    return SquareExternalPaymentsRequest(
      idempotencyKey: map['idempotency_key'] ?? "",
      sourceId: map['source_id'] ?? "",
      amountMoney:
          ExternalPaymentsRequestMoney.fromMap(map['amount_money'] ?? {}),
      customerId: map['customer_id'] ?? "",
      externalDetails: ExternalDetails.fromMap(map['external_details'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idempotency_key': idempotencyKey,
      'source_id': sourceId,
      'amount_money': amountMoney.toMap(),
      'customer_id': customerId,
      'external_details': externalDetails.toMap(),
    };
  }
}

class ExternalPaymentsRequestMoney {
  final int amount;
  final String currency;

  ExternalPaymentsRequestMoney({
    required this.amount,
    required this.currency,
  });

  factory ExternalPaymentsRequestMoney.fromMap(Map<String, dynamic> map) {
    return ExternalPaymentsRequestMoney(
      amount: map['amount'] ?? 0,
      currency: map['currency'] ?? "",
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
  final ExternalPaymentsRequestMoney sourceFeeMoney;
  final String sourceId;

  ExternalDetails({
    required this.type,
    required this.source,
    required this.sourceFeeMoney,
    required this.sourceId,
  });

  factory ExternalDetails.fromMap(Map<String, dynamic> map) {
    return ExternalDetails(
      type: map['type'] ?? "",
      source: map['source'] ?? "",
      sourceFeeMoney:
          ExternalPaymentsRequestMoney.fromMap(map['source_fee_money'] ?? {}),
      sourceId: map['source_id'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'source': source,
      'source_fee_money': sourceFeeMoney.toMap(),
      'source_id': sourceId,
    };
  }
}

  //  '{
  //   "idempotency_key": "6f62271c-b876-42e8-918a-333b9e9a6b0b",
  //   "source_id": "EXTERNAL",
  //   "amount_money": {
  //     "amount": 40,
  //     "currency": "USD"
  //   },
  //   "customer_id": "MHTPXJSBE0BQKJA8YVD8HQM330",
  //   "external_details": {
  //     "type": "EMONEY",
  //     "source": "Mpesa ",
  //     "source_fee_money": {
  //       "amount": 0,
  //       "currency": "USD"
  //     },
  //     "source_id": "EXTERNAL"
  //   }
  // }'


  //partial auth false
// '{
//     "idempotency_key": "0802f904-be1c-438d-aed6-301d513ae03c",
//     "source_id": "EXTERNAL",
//     "amount_money": {
//       "currency": "USD",
//       "amount": 110
//     },
//     "customer_id": "MHTPXJSBE0BQKJA8YVD8HQM330",
//     "external_details": {
//       "type": "EMONEY",
//       "source": "Mpesa ",
//       "source_fee_money": {
//         "amount": 0,
//         "currency": "USD"
//       },
//       "source_id": "EXTERNAL"
//     },
//     "accept_partial_authorization": false,
//     "order_id": "FmHJWVLnea8Xh0Q1SUxicPYl1wCZY"
//   }'