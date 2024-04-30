class SquareRetrieveOrderResponse {
  final String id;
  final String locationId;
  final List<LineItem> lineItems;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String state;
  final int version;
  final Map<String, dynamic> totalTaxMoney;
  final Map<String, dynamic> totalDiscountMoney;
  final Map<String, dynamic> totalTipMoney;
  final Map<String, dynamic> totalMoney;
  final DateTime closedAt;
  final List<dynamic> tenders;
  final Map<String, dynamic> totalServiceChargeMoney;
  final Map<String, dynamic> netAmounts;
  final Map<String, dynamic> source;
  final String customerId;
  final Map<String, dynamic> netAmountDueMoney;

  SquareRetrieveOrderResponse({
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
    required this.closedAt,
    required this.tenders,
    required this.totalServiceChargeMoney,
    required this.netAmounts,
    required this.source,
    required this.customerId,
    required this.netAmountDueMoney,
  });

  factory SquareRetrieveOrderResponse.fromMap(Map<String, dynamic> map) {
    return SquareRetrieveOrderResponse(
      id: map['id'],
      locationId: map['location_id'],
      lineItems: (map['line_items'] as List<dynamic>)
          .map((item) => LineItem.fromMap(item))
          .toList(),
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      state: map['state'],
      version: map['version'],
      totalTaxMoney: map['total_tax_money'],
      totalDiscountMoney: map['total_discount_money'],
      totalTipMoney: map['total_tip_money'],
      totalMoney: map['total_money'],
      closedAt: DateTime.parse(map['closed_at']),
      tenders: map['tenders'],
      totalServiceChargeMoney: map['total_service_charge_money'],
      netAmounts: map['net_amounts'],
      source: map['source'],
      customerId: map['customer_id'],
      netAmountDueMoney: map['net_amount_due_money'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'location_id': locationId,
      'line_items': lineItems.map((item) => item.toMap()).toList(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'state': state,
      'version': version,
      'total_tax_money': totalTaxMoney,
      'total_discount_money': totalDiscountMoney,
      'total_tip_money': totalTipMoney,
      'total_money': totalMoney,
      'closed_at': closedAt.toIso8601String(),
      'tenders': tenders,
      'total_service_charge_money': totalServiceChargeMoney,
      'net_amounts': netAmounts,
      'source': source,
      'customer_id': customerId,
      'net_amount_due_money': netAmountDueMoney,
    };
  }
}

class LineItem {
  final String uid;
  final String quantity;
  final String name;
  final Map<String, dynamic> basePriceMoney;
  final Map<String, dynamic> grossSalesMoney;
  final Map<String, dynamic> totalTaxMoney;
  final Map<String, dynamic> totalDiscountMoney;
  final Map<String, dynamic> totalMoney;
  final Map<String, dynamic> variationTotalPriceMoney;
  final String itemType;
  final Map<String, dynamic> totalServiceChargeMoney;

  LineItem({
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

  factory LineItem.fromMap(Map<String, dynamic> map) {
    return LineItem(
      uid: map['uid'],
      quantity: map['quantity'],
      name: map['name'],
      basePriceMoney: map['base_price_money'],
      grossSalesMoney: map['gross_sales_money'],
      totalTaxMoney: map['total_tax_money'],
      totalDiscountMoney: map['total_discount_money'],
      totalMoney: map['total_money'],
      variationTotalPriceMoney: map['variation_total_price_money'],
      itemType: map['item_type'],
      totalServiceChargeMoney: map['total_service_charge_money'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'quantity': quantity,
      'name': name,
      'base_price_money': basePriceMoney,
      'gross_sales_money': grossSalesMoney,
      'total_tax_money': totalTaxMoney,
      'total_discount_money': totalDiscountMoney,
      'total_money': totalMoney,
      'variation_total_price_money': variationTotalPriceMoney,
      'item_type': itemType,
      'total_service_charge_money': totalServiceChargeMoney,
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
//     "updated_at": "2024-04-29T09:31:47.000Z",
//     "state": "COMPLETED",
//     "version": 4,
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
//     "closed_at": "2024-04-29T09:31:46.471Z",
//     "tenders": [
//       {
//         "id": "tcx9TQGt8pEWDY1KDOK4xZPGO4NZY",
//         "location_id": "L0976QXCW7V28",
//         "transaction_id": "FmHJWVLnea8Xh0Q1SUxicPYl1wCZY",
//         "created_at": "2024-04-29T09:31:46Z",
//         "amount_money": {
//           "amount": 110,
//           "currency": "USD"
//         },
//         "type": "OTHER",
//         "payment_id": "tcx9TQGt8pEWDY1KDOK4xZPGO4NZY"
//       }
//     ],
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
//       "amount": 0,
//       "currency": "USD"
//     }
//   }
// }
