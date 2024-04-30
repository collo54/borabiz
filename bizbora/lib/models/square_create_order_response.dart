class SquareCreateOrderResponse {
  final String id;
  final String locationId;
  final List<CreateOrderResponseLineItem> lineItems;
  final String createdAt;
  final String updatedAt;
  final String state;
  final int version;
  final Money totalTaxMoney;
  final Money totalDiscountMoney;
  final Money totalTipMoney;
  final Money totalMoney;
  final Money totalServiceChargeMoney;
  final NetAmounts netAmounts;
  final Source source;
  final String customerId;
  final Money netAmountDueMoney;

  SquareCreateOrderResponse({
    required this.id,
    required this.locationId,
    required this.lineItems,
    required this.createdAt,
    required this.updatedAt,
    required this.state,
    required this.version,
    required this.totalTaxMoney,
    required this.totalDiscountMoney,
    required this.totalTipMoney,
    required this.totalMoney,
    required this.totalServiceChargeMoney,
    required this.netAmounts,
    required this.source,
    required this.customerId,
    required this.netAmountDueMoney,
  });

  factory SquareCreateOrderResponse.fromMap(Map<String, dynamic> map) {
    final containsLineItems = map.containsKey('order');
    final containsLine = map.containsKey('line_items');
    // final lineitemslist = (map['order']['line_items']
    //         .map((x) => CreateOrderResponseLineItem.fromMap(x))
    //         .toList() ??
    //     <CreateOrderResponseLineItem>[]) as List<CreateOrderResponseLineItem>; // map['line_items'] as List<CreateOrderResponseLineItem>;
    return SquareCreateOrderResponse(
      id: map['id'] ?? '',
      locationId: map['location_id'] ?? '',
      lineItems: List<CreateOrderResponseLineItem>.from(
          map['line_items'].map((x) => CreateOrderResponseLineItem.fromMap(x))),
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      state: map['state'] ?? '',
      version: map['version'] ?? 0,
      totalTaxMoney: Money.fromMap(
          map['total_tax_money'] ?? {'amount': 0, 'currency': 'USD'}),
      totalDiscountMoney: Money.fromMap(
          map['total_discount_money'] ?? {'amount': 0, 'currency': 'USD'}),
      totalTipMoney: Money.fromMap(
          map['total_tip_money'] ?? {'amount': 0, 'currency': 'USD'}),
      totalMoney:
          Money.fromMap(map['total_money'] ?? {'amount': 0, 'currency': 'USD'}),
      totalServiceChargeMoney: Money.fromMap(
          map['total_service_charge_money'] ??
              {'amount': 0, 'currency': 'USD'}),
      netAmounts: NetAmounts.fromMap(map['net_amounts'] ??
          {
            'total_money': {'amount': 0, 'currency': 'USD'},
            'tax_money': {'amount': 0, 'currency': 'USD'},
            'discount_money': {'amount': 0, 'currency': 'USD'},
            'tip_money': {'amount': 0, 'currency': 'USD'},
            'service_charge_money': {'amount': 0, 'currency': 'USD'}
          }),
      source: Source.fromMap(map['source'] ?? {'name': ''}),
      customerId: map['customer_id'] ?? '',
      netAmountDueMoney: Money.fromMap(
          map['net_amount_due_money'] ?? {'amount': 0, 'currency': 'USD'}),
    );
    // return SquareCreateOrderResponse(
    //   id: map['id'],
    //   locationId: map['location_id'],
    //   lineItems: List<CreateOrderResponseLineItem>.from(
    //       map['line_items'].map((x) => CreateOrderResponseLineItem.fromMap(x))),
    //   createdAt: DateTime.parse(map['created_at']),
    //   updatedAt: DateTime.parse(map['updated_at']),
    //   state: map['state'],
    //   version: map['version'],
    //   totalTaxMoney: Money.fromMap(map['total_tax_money']),
    //   totalDiscountMoney: Money.fromMap(map['total_discount_money']),
    //   totalTipMoney: Money.fromMap(map['total_tip_money']),
    //   totalMoney: Money.fromMap(map['total_money']),
    //   totalServiceChargeMoney: Money.fromMap(map['total_service_charge_money']),
    //   netAmounts: NetAmounts.fromMap(map['net_amounts']),
    //   source: Source.fromMap(map['source']),
    //   customerId: map['customer_id'],
    //   netAmountDueMoney: Money.fromMap(map['net_amount_due_money']),
    // );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'location_id': locationId,
      'line_items': List<dynamic>.from(lineItems.map((x) => x.toMap())),
      'created_at': createdAt,
      'updated_at': updatedAt,
      'state': state,
      'version': version,
      'total_tax_money': totalTaxMoney.toMap(),
      'total_discount_money': totalDiscountMoney.toMap(),
      'total_tip_money': totalTipMoney.toMap(),
      'total_money': totalMoney.toMap(),
      'total_service_charge_money': totalServiceChargeMoney.toMap(),
      'net_amounts': netAmounts.toMap(),
      'source': source.toMap(),
      'customer_id': customerId,
      'net_amount_due_money': netAmountDueMoney.toMap(),
    };
  }
}

class CreateOrderResponseLineItem {
  final String uid;
  final String quantity;
  final String name;
  final Money basePriceMoney;
  final Money grossSalesMoney;
  final Money totalTaxMoney;
  final Money totalDiscountMoney;
  final Money totalMoney;
  final Money variationTotalPriceMoney;
  final String itemType;
  final Money totalServiceChargeMoney;

  CreateOrderResponseLineItem({
    required this.uid,
    required this.quantity,
    required this.name,
    required this.basePriceMoney,
    required this.grossSalesMoney,
    required this.totalTaxMoney,
    required this.totalDiscountMoney,
    required this.totalMoney,
    required this.variationTotalPriceMoney,
    required this.itemType,
    required this.totalServiceChargeMoney,
  });

  factory CreateOrderResponseLineItem.fromMap(Map<String, dynamic> map) {
    return CreateOrderResponseLineItem(
      uid: map['uid'] ?? '',
      quantity: map['quantity'] ?? '',
      name: map['name'] ?? '',
      basePriceMoney: Money.fromMap(
          map['base_price_money'] ?? {'amount': 0, 'currency': 'USD'}),
      grossSalesMoney: Money.fromMap(
          map['gross_sales_money'] ?? {'amount': 0, 'currency': 'USD'}),
      totalTaxMoney: Money.fromMap(
          map['total_tax_money'] ?? {'amount': 0, 'currency': 'USD'}),
      totalDiscountMoney: Money.fromMap(
          map['total_discount_money'] ?? {'amount': 0, 'currency': 'USD'}),
      totalMoney:
          Money.fromMap(map['total_money'] ?? {'amount': 0, 'currency': 'USD'}),
      variationTotalPriceMoney: Money.fromMap(
          map['variation_total_price_money'] ??
              {'amount': 0, 'currency': 'USD'}),
      itemType: map['item_type'] ?? '',
      totalServiceChargeMoney: Money.fromMap(
          map['total_service_charge_money'] ??
              {'amount': 0, 'currency': 'USD'}),
    );
    // return CreateOrderResponseLineItem(
    //   uid: map['uid'],
    //   quantity: map['quantity'],
    //   name: map['name'],
    //   basePriceMoney: Money.fromMap(map['base_price_money']),
    //   grossSalesMoney: Money.fromMap(map['gross_sales_money']),
    //   totalTaxMoney: Money.fromMap(map['total_tax_money']),
    //   totalDiscountMoney: Money.fromMap(map['total_discount_money']),
    //   totalMoney: Money.fromMap(map['total_money']),
    //   variationTotalPriceMoney:
    //       Money.fromMap(map['variation_total_price_money']),
    //   itemType: map['item_type'],
    //   totalServiceChargeMoney: Money.fromMap(map['total_service_charge_money']),
    // );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'quantity': quantity,
      'name': name,
      'base_price_money': basePriceMoney.toMap(),
      'gross_sales_money': grossSalesMoney.toMap(),
      'total_tax_money': totalTaxMoney.toMap(),
      'total_discount_money': totalDiscountMoney.toMap(),
      'total_money': totalMoney.toMap(),
      'variation_total_price_money': variationTotalPriceMoney.toMap(),
      'item_type': itemType,
      'total_service_charge_money': totalServiceChargeMoney.toMap(),
    };
  }
}

class Money {
  final int amount;
  final String currency;

  Money({required this.amount, required this.currency});

  factory Money.fromMap(Map<String, dynamic> map) {
    return Money(
      amount: map['amount'] ?? 0,
      currency: map['currency'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'currency': currency,
    };
  }
}

class NetAmounts {
  final Money totalMoney;
  final Money taxMoney;
  final Money discountMoney;
  final Money tipMoney;
  final Money serviceChargeMoney;

  NetAmounts({
    required this.totalMoney,
    required this.taxMoney,
    required this.discountMoney,
    required this.tipMoney,
    required this.serviceChargeMoney,
  });

  factory NetAmounts.fromMap(Map<String, dynamic> map) {
    return NetAmounts(
      totalMoney:
          Money.fromMap(map['total_money'] ?? {'amount': 0, 'currency': 'USD'}),
      taxMoney:
          Money.fromMap(map['tax_money'] ?? {'amount': 0, 'currency': 'USD'}),
      discountMoney: Money.fromMap(
          map['discount_money'] ?? {'amount': 0, 'currency': 'USD'}),
      tipMoney:
          Money.fromMap(map['tip_money'] ?? {'amount': 0, 'currency': 'USD'}),
      serviceChargeMoney: Money.fromMap(
          map['service_charge_money'] ?? {'amount': 0, 'currency': 'USD'}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'total_money': totalMoney.toMap(),
      'tax_money': taxMoney.toMap(),
      'discount_money': discountMoney.toMap(),
      'tip_money': tipMoney.toMap(),
      'service_charge_money': serviceChargeMoney.toMap(),
    };
  }
}

class Source {
  final String name;

  Source({required this.name});

  factory Source.fromMap(Map<String, dynamic> map) {
    return Source(
      name: map['name'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }
}

// {
//   "order": {
//     "id": "FmHJWVLnea8Xh0Q1SUxicPYl1wCZY",
//     "location_id": "L0976QXCW7V28",
//     "line_items": [
//       {
//         "uid": "RJjo3AKpU4sSHterlegY3B",
//         "quantity": "2",
//         "name": "keg regular",
//         "base_price_money": {
//           "amount": 30,
//           "currency": "USD"
//         },
//         "gross_sales_money": {
//           "amount": 60,
//           "currency": "USD"
//         },
//         "total_tax_money": {
//           "amount": 0,
//           "currency": "USD"
//         },
//         "total_discount_money": {
//           "amount": 0,
//           "currency": "USD"
//         },
//         "total_money": {
//           "amount": 60,
//           "currency": "USD"
//         },
//         "variation_total_price_money": {
//           "amount": 60,
//           "currency": "USD"
//         },
//         "item_type": "ITEM",
//         "total_service_charge_money": {
//           "amount": 0,
//           "currency": "USD"
//         }
//       },
//       {
//         "uid": "rTcyKrgYYZObzKF7FjMLw",
//         "quantity": "1",
//         "name": "keg dark",
//         "base_price_money": {
//           "amount": 50,
//           "currency": "USD"
//         },
//         "gross_sales_money": {
//           "amount": 50,
//           "currency": "USD"
//         },
//         "total_tax_money": {
//           "amount": 0,
//           "currency": "USD"
//         },
//         "total_discount_money": {
//           "amount": 0,
//           "currency": "USD"
//         },
//         "total_money": {
//           "amount": 50,
//           "currency": "USD"
//         },
//         "variation_total_price_money": {
//           "amount": 50,
//           "currency": "USD"
//         },
//         "item_type": "ITEM",
//         "total_service_charge_money": {
//           "amount": 0,
//           "currency": "USD"
//         }
//       }
//     ],
//     "created_at": "2024-04-29T08:18:11.425Z",
//     "updated_at": "2024-04-29T08:18:11.425Z",
//     "state": "OPEN",
//     "version": 1,
//     "total_tax_money": {
//       "amount": 0,
//       "currency": "USD"
//     },
//     "total_discount_money": {
//       "amount": 0,
//       "currency": "USD"
//     },
//     "total_tip_money": {
//       "amount": 0,
//       "currency": "USD"
//     },
//     "total_money": {
//       "amount": 110,
//       "currency": "USD"
//     },
//     "total_service_charge_money": {
//       "amount": 0,
//       "currency": "USD"
//     },
//     "net_amounts": {
//       "total_money": {
//         "amount": 110,
//         "currency": "USD"
//       },
//       "tax_money": {
//         "amount": 0,
//         "currency": "USD"
//       },
//       "discount_money": {
//         "amount": 0,
//         "currency": "USD"
//       },
//       "tip_money": {
//         "amount": 0,
//         "currency": "USD"
//       },
//       "service_charge_money": {
//         "amount": 0,
//         "currency": "USD"
//       }
//     },
//     "source": {
//       "name": "Sandbox for sq0idp-mlIJW_PcToqCR1DDoZglTw"
//     },
//     "customer_id": "MHTPXJSBE0BQKJA8YVD8HQM330",
//     "net_amount_due_money": {
//       "amount": 110,
//       "currency": "USD"
//     }
//   }
// }
