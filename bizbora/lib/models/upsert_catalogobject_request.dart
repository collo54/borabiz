class UpsertCatalogObjectRequest {
  final String idempotencyKey;
  final CatalogObject object;

  UpsertCatalogObjectRequest({
    required this.idempotencyKey,
    required this.object,
  });

  Map<String, dynamic> toMap() {
    return {
      'idempotency_key': idempotencyKey,
      'object': object.toMap(),
    };
  }

  factory UpsertCatalogObjectRequest.fromMap(Map<String, dynamic> map) {
    return UpsertCatalogObjectRequest(
      idempotencyKey: map['idempotency_key'] as String,
      object: CatalogObject.fromMap(map['object'] as Map<String, dynamic>),
    );
  }
}

class CatalogObject {
  final String id;
  final String type;
  final bool isDeleted;
  final int version;
  final UpsertItemData itemData;

  CatalogObject({
    required this.id,
    required this.type,
    required this.isDeleted,
    required this.version,
    required this.itemData,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'is_deleted': isDeleted,
      'version': version,
      'item_data': itemData.toMap(),
    };
  }

  factory CatalogObject.fromMap(Map<String, dynamic> map) {
    return CatalogObject(
      id: map['id'] as String,
      type: map['type'] as String,
      isDeleted: map['is_deleted'] as bool,
      version: map['version'] as int,
      itemData:
          UpsertItemData.fromMap(map['item_data'] as Map<String, dynamic>),
    );
  }
}

class UpsertItemData {
  final String abbreviation;
  final bool availableForPickup;
  final String name;
  final List<UpsertRequestVariation> variations;

  UpsertItemData({
    required this.abbreviation,
    required this.availableForPickup,
    required this.name,
    required this.variations,
  });

  Map<String, dynamic> toMap() {
    return {
      'abbreviation': abbreviation,
      'available_for_pickup': availableForPickup,
      'name': name,
      'variations': variations.map((v) => v.toMap()).toList(),
    };
  }

  factory UpsertItemData.fromMap(Map<String, dynamic> map) {
    return UpsertItemData(
      abbreviation: map['abbreviation'] as String,
      availableForPickup: map['available_for_pickup'] as bool,
      name: map['name'] as String,
      variations: List<UpsertRequestVariation>.from((map['variations'] as List)
          .map((v) =>
              UpsertRequestVariation.fromMap(v as Map<String, dynamic>))),
    );
  }
}

class UpsertRequestVariation {
  final String id;
  final String type;
  final int version;
  final UpsertRequestItemVariationData itemVariationData;

  UpsertRequestVariation({
    required this.id,
    required this.type,
    required this.itemVariationData,
    required this.version,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'version': version,
      'item_variation_data': itemVariationData.toMap(),
    };
  }

  factory UpsertRequestVariation.fromMap(Map<String, dynamic> map) {
    return UpsertRequestVariation(
      id: map['id'] as String,
      version: map['version'] as int,
      type: map['type'] as String,
      itemVariationData: UpsertRequestItemVariationData.fromMap(
          map['item_variation_data'] as Map<String, dynamic>),
    );
  }
}

class UpsertRequestItemVariationData {
  final bool availableForBooking;
  final String itemId;
  int inventoryThreshold;
  final String name;
  final String pricingType;
  final bool sellable;
  final UpsertRequestMoney priceMoney;

  UpsertRequestItemVariationData({
    required this.availableForBooking,
    required this.itemId,
    required this.inventoryThreshold,
    required this.name,
    required this.pricingType,
    required this.sellable,
    required this.priceMoney,
  });

  Map<String, dynamic> toMap() {
    return {
      'available_for_booking': availableForBooking,
      'item_id': itemId,
      'inventory_alert_threshold': inventoryThreshold,
      'name': name,
      'pricing_type': pricingType,
      'sellable': sellable,
      'price_money': priceMoney.toMap(),
    };
  }

  factory UpsertRequestItemVariationData.fromMap(Map<String, dynamic> map) {
    final containsThreshold = map.containsKey('inventory_alert_threshold');
    return UpsertRequestItemVariationData(
      availableForBooking: map['available_for_booking'] as bool,
      itemId: map['item_id'] as String,
      inventoryThreshold:
          containsThreshold ? map['inventory_alert_threshold'] as int : 0,
      name: map['name'] as String,
      pricingType: map['pricing_type'] as String,
      sellable: map['sellable'] as bool,
      priceMoney: UpsertRequestMoney.fromMap(
          map['price_money'] as Map<String, dynamic>),
    );
  }
}

class UpsertRequestMoney {
  final int amount;
  final String currency;

  UpsertRequestMoney({
    required this.amount,
    required this.currency,
  });

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'currency': currency,
    };
  }

  factory UpsertRequestMoney.fromMap(Map<String, dynamic> map) {
    return UpsertRequestMoney(
      amount: map['amount'] as int,
      currency: map['currency'] as String,
    );
  }
}


// '{
//     "idempotency_key": "f7e38405-feb5-4f01-9c84-23073d6208ed",
//     "object": {
//       "id": "#furniture",
//       "type": "ITEM",
//       "is_deleted": false,
//       "version": 1,
//       "item_data": {
//         "abbreviation": "fnr",
//         "available_for_pickup": true,
//         "name": "furniture",
//         "variations": [
//           {
//             "id": "#small",
//             "type": "ITEM_VARIATION",
//             "item_variation_data": {
//               "available_for_booking": false,
//               "item_id": "#furniture",
//               "name": "meru oak chair",
//               "pricing_type": "FIXED_PRICING",
//               "sellable": true,
//               "price_money": {
//                 "amount": 200,
//                 "currency": "USD"
//               }
//             }
//           }
//         ]
//       }
//     }
//   }'


//Update catalog object with version key
// '{
//     "idempotency_key": "64392005-5796-45a2-bd46-cd3618a215d3",
//     "object": {
//       "type": "ITEM",
//       "is_deleted": false,
//       "item_data": {
//         "abbreviation": "fnr",
//         "available_for_pickup": true,
//         "name": "furniture",
//         "variations": [
//           {
//             "type": "ITEM_VARIATION",
//             "item_variation_data": {
//               "available_for_booking": false,
//               "name": "meru oak chair aged",
//               "pricing_type": "FIXED_PRICING",
//               "sellable": true,
//               "price_money": {
//                 "currency": "USD",
//                 "amount": 500
//               },
//               "item_id": "R2TZKGUEN7GSG3IB5DFLPQXM"
//             },
//             "id": "SPAMUK6VMFWFQEAHVF6I2VQB",
//             "version": 1714389554214
//           }
//         ]
//       },
//       "id": "R2TZKGUEN7GSG3IB5DFLPQXM",
//       "version": 1714389554214
//     }
//   }'

//repsonse with inventory threshold
// '{
//     "idempotency_key": "9a1112c6-eb5c-4e00-9510-5cf067c324df",
//     "object": {
//       "type": "ITEM",
//       "is_deleted": false,
//       "item_data": {
//         "abbreviation": "fnr",
//         "available_for_pickup": true,
//         "name": "furniture",
//         "variations": [
//           {
//             "type": "ITEM_VARIATION",
//             "item_variation_data": {
//               "available_for_booking": false,
//               "name": "meru oak chair aged",
//               "pricing_type": "FIXED_PRICING",
//               "sellable": true,
//               "price_money": {
//                 "currency": "USD",
//                 "amount": 500
//               },
//               "item_id": "6OBLODFNJI66ASKMDFDQEPZ7",
//               "inventory_alert_threshold": 5
//             },
//             "id": "5G5BIRBNQ46GPQDO2J3SWPRE",
//             "version": 1714464237995
//           }
//         ]
//       },
//       "id": "6OBLODFNJI66ASKMDFDQEPZ7",
//       "version": 1714464237995
//     }
//   }'