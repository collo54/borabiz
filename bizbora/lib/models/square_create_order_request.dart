class SquareCreateOrderRequest {
  final Order order;
  final String idempotencyKey;

  SquareCreateOrderRequest({required this.order, required this.idempotencyKey});

  factory SquareCreateOrderRequest.fromJson(Map<String, dynamic> json) {
    return SquareCreateOrderRequest(
      order: Order.fromJson(json['order']),
      idempotencyKey: json['idempotency_key'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order': order.toJson(),
      'idempotency_key': idempotencyKey,
    };
  }
}

class Order {
  final List<LineItem> lineItems;
  final String locationId;
  final String customerId;

  Order({
    required this.lineItems,
    required this.locationId,
    required this.customerId,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      lineItems: (json['line_items'] as List<dynamic>)
          .map((item) => LineItem.fromJson(item))
          .toList(),
      locationId: json['location_id'],
      customerId: json['customer_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'line_items': lineItems.map((item) => item.toJson()).toList(),
      'location_id': locationId,
      'customer_id': customerId,
    };
  }
}

class LineItem {
  final String quantity;
  final CreateOrderRequestMoney basePriceMoney;
  final String itemType;
  final String name;

  LineItem({
    required this.quantity,
    required this.basePriceMoney,
    required this.itemType,
    required this.name,
  });

  factory LineItem.fromJson(Map<String, dynamic> json) {
    return LineItem(
      quantity: json['quantity'],
      basePriceMoney:
          CreateOrderRequestMoney.fromJson(json['base_price_money']),
      itemType: json['item_type'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
      'base_price_money': basePriceMoney.toJson(),
      'item_type': itemType,
      'name': name,
    };
  }
}

class CreateOrderRequestMoney {
  final int amount;
  final String currency;

  CreateOrderRequestMoney({required this.amount, required this.currency});

  factory CreateOrderRequestMoney.fromJson(Map<String, dynamic> json) {
    return CreateOrderRequestMoney(
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

//Request example
//  '{
//     "order": {
//       "line_items": [
//         {
//           "quantity": "2",
//           "base_price_money": {
//             "amount": 30,
//             "currency": "USD"
//           },
//           "item_type": "ITEM",
//           "name": "keg regular"
//         },
//         {
//           "quantity": "1",
//           "base_price_money": {
//             "amount": 50,
//             "currency": "USD"
//           },
//           "item_type": "ITEM",
//           "name": "keg dark"
//         }
//       ],
//       "location_id": "L0976QXCW7V28",
//       "customer_id": "MHTPXJSBE0BQKJA8YVD8HQM330"
//     },
//     "idempotency_key": "c24d1d1e-4074-48a2-856e-1fc200c19798"
//   }'