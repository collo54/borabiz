class SquareCashPaymentsRequest {
  String idempotencyKey;
  String sourceId;
  AmountMoney amountMoney;
  String customerId;
  CashDetails cashDetails;

  SquareCashPaymentsRequest({
    required this.idempotencyKey,
    required this.sourceId,
    required this.amountMoney,
    required this.customerId,
    required this.cashDetails,
  });

  factory SquareCashPaymentsRequest.fromMap(Map<String, dynamic> json) {
    return SquareCashPaymentsRequest(
      idempotencyKey: json['idempotency_key'] ?? '',
      sourceId: json['source_id'] ?? '',
      amountMoney: AmountMoney.fromMap(json['amount_money'] ?? {}),
      customerId: json['customer_id'] ?? '',
      cashDetails: CashDetails.fromMap(json['cash_details'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idempotency_key': idempotencyKey,
      'source_id': sourceId,
      'amount_money': amountMoney.toMap(),
      'customer_id': customerId,
      'cash_details': cashDetails.toMap(),
    };
  }
}

class AmountMoney {
  int amount;
  String currency;

  AmountMoney({
    required this.amount,
    required this.currency,
  });

  factory AmountMoney.fromMap(Map<String, dynamic> json) {
    return AmountMoney(
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

class CashDetails {
  BuyerSuppliedMoney buyerSuppliedMoney;

  CashDetails({
    required this.buyerSuppliedMoney,
  });

  factory CashDetails.fromMap(Map<String, dynamic> json) {
    return CashDetails(
      buyerSuppliedMoney:
          BuyerSuppliedMoney.fromMap(json['buyer_supplied_money'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'buyer_supplied_money': buyerSuppliedMoney.toMap(),
    };
  }
}

class BuyerSuppliedMoney {
  int amount;
  String currency;

  BuyerSuppliedMoney({
    required this.amount,
    required this.currency,
  });

  factory BuyerSuppliedMoney.fromMap(Map<String, dynamic> json) {
    return BuyerSuppliedMoney(
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

//Request example
// '{
//     "idempotency_key": "e0646d19-81f5-4c09-9b01-e10e0c6f1e68",
//     "source_id": "CASH",
//     "amount_money": {
//       "amount": 40,
//       "currency": "USD"
//     },
//     "customer_id": "MHTPXJSBE0BQKJA8YVD8HQM330",
//     "cash_details": {
//       "buyer_supplied_money": {
//         "amount": 40,
//         "currency": "USD"
//       }
//     }
//   }'