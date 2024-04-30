class UpsertCatalogObjectResponse {
  final CatalogObject catalogObject;
  final List<IdMapping> idMappings;

  UpsertCatalogObjectResponse(
      {required this.catalogObject, required this.idMappings});

  factory UpsertCatalogObjectResponse.fromMap(Map<String, dynamic> map) {
    final bool = map.containsKey('id_mappings');
    return UpsertCatalogObjectResponse(
      catalogObject: CatalogObject.fromMap(map['catalog_object']),
      idMappings: bool
          ? List<IdMapping>.from(
              map['id_mappings'].map((x) => IdMapping.fromMap(x)))
          : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'catalog_object': catalogObject.toMap(),
      'id_mappings': List<dynamic>.from(idMappings.map((x) => x.toMap())),
    };
  }
}

class CatalogObject {
  final String type;
  final String id;
  final String updatedAt;
  final String createdAt;
  final int version;
  final bool isDeleted;
  final bool presentAtAllLocations;
  final ItemData itemData;

  CatalogObject({
    required this.type,
    required this.id,
    required this.updatedAt,
    required this.createdAt,
    required this.version,
    required this.isDeleted,
    required this.presentAtAllLocations,
    required this.itemData,
  });

  factory CatalogObject.fromMap(Map<String, dynamic> map) {
    return CatalogObject(
      type: map['type'],
      id: map['id'],
      updatedAt: map['updated_at'],
      createdAt: map['created_at'],
      version: map['version'],
      isDeleted: map['is_deleted'],
      presentAtAllLocations: map['present_at_all_locations'],
      itemData: ItemData.fromMap(map['item_data']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'id': id,
      'updated_at': updatedAt,
      'created_at': createdAt,
      'version': version,
      'is_deleted': isDeleted,
      'present_at_all_locations': presentAtAllLocations,
      'item_data': itemData.toMap(),
    };
  }
}

class ItemData {
  final String name;
  final String abbreviation;
  final bool isTaxable;
  final bool availableForPickup;
  final List<Variation> variations;
  final String productType;
  final bool isArchived;

  ItemData({
    required this.name,
    required this.abbreviation,
    required this.isTaxable,
    required this.availableForPickup,
    required this.variations,
    required this.productType,
    required this.isArchived,
  });

  factory ItemData.fromMap(Map<String, dynamic> map) {
    return ItemData(
      name: map['name'],
      abbreviation: map['abbreviation'],
      isTaxable: map['is_taxable'],
      availableForPickup: map['available_for_pickup'],
      variations: List<Variation>.from(
          map['variations'].map((x) => Variation.fromMap(x))),
      productType: map['product_type'],
      isArchived: map['is_archived'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'abbreviation': abbreviation,
      'is_taxable': isTaxable,
      'available_for_pickup': availableForPickup,
      'variations': List<dynamic>.from(variations.map((x) => x.toMap())),
      'product_type': productType,
      'is_archived': isArchived,
    };
  }
}

class Variation {
  final String type;
  final String id;
  final String updatedAt;
  final String createdAt;
  final int version;
  final bool isDeleted;
  final bool presentAtAllLocations;
  final ItemVariationData itemVariationData;

  Variation({
    required this.type,
    required this.id,
    required this.updatedAt,
    required this.createdAt,
    required this.version,
    required this.isDeleted,
    required this.presentAtAllLocations,
    required this.itemVariationData,
  });

  factory Variation.fromMap(Map<String, dynamic> map) {
    return Variation(
      type: map['type'],
      id: map['id'],
      updatedAt: map['updated_at'],
      createdAt: map['created_at'],
      version: map['version'],
      isDeleted: map['is_deleted'],
      presentAtAllLocations: map['present_at_all_locations'],
      itemVariationData: ItemVariationData.fromMap(map['item_variation_data']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'id': id,
      'updated_at': updatedAt,
      'created_at': createdAt,
      'version': version,
      'is_deleted': isDeleted,
      'present_at_all_locations': presentAtAllLocations,
      'item_variation_data': itemVariationData.toMap(),
    };
  }
}

class ItemVariationData {
  final String itemId;
  final String name;
  final int ordinal;
  final String pricingType;
  final Money priceMoney;
  int inventoryThreshold;
  final bool availableForBooking;
  final bool sellable;
  final bool stockable;

  ItemVariationData({
    required this.itemId,
    required this.name,
    required this.ordinal,
    required this.pricingType,
    required this.priceMoney,
    required this.inventoryThreshold,
    required this.availableForBooking,
    required this.sellable,
    required this.stockable,
  });

  factory ItemVariationData.fromMap(Map<String, dynamic> map) {
    final containsThreshold = map.containsKey('inventory_alert_threshold');
    return ItemVariationData(
      itemId: map['item_id'],
      name: map['name'],
      ordinal: map['ordinal'],
      pricingType: map['pricing_type'],
      priceMoney: Money.fromMap(map['price_money']),
      inventoryThreshold:
          containsThreshold ? map['inventory_alert_threshold'] as int : 0,
      availableForBooking: map['available_for_booking'],
      sellable: map['sellable'],
      stockable: map['stockable'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'item_id': itemId,
      'name': name,
      'ordinal': ordinal,
      'pricing_type': pricingType,
      'price_money': priceMoney.toMap(),
      'inventory_alert_threshold': inventoryThreshold,
      'available_for_booking': availableForBooking,
      'sellable': sellable,
      'stockable': stockable,
    };
  }
}

class Money {
  final int amount;
  final String currency;

  Money({
    required this.amount,
    required this.currency,
  });

  factory Money.fromMap(Map<String, dynamic> map) {
    return Money(
      amount: map['amount'],
      currency: map['currency'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'currency': currency,
    };
  }
}

class IdMapping {
  final String clientObjectId;
  final String objectId;

  IdMapping({
    required this.clientObjectId,
    required this.objectId,
  });

  factory IdMapping.fromMap(Map<String, dynamic> map) {
    return IdMapping(
      clientObjectId: map['client_object_id'],
      objectId: map['object_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'client_object_id': clientObjectId,
      'object_id': objectId,
    };
  }
}

// {
//   "catalog_object": {
//     "type": "ITEM",
//     "id": "R2TZKGUEN7GSG3IB5DFLPQXM",
//     "updated_at": "2024-04-29T11:19:14.214Z",
//     "created_at": "2024-04-29T11:19:14.214Z",
//     "version": 1714389554214,
//     "is_deleted": false,
//     "present_at_all_locations": true,
//     "item_data": {
//       "name": "furniture",
//       "abbreviation": "fnr",
//       "is_taxable": true,
//       "available_for_pickup": true,
//       "variations": [
//         {
//           "type": "ITEM_VARIATION",
//           "id": "SPAMUK6VMFWFQEAHVF6I2VQB",
//           "updated_at": "2024-04-29T11:19:14.214Z",
//           "created_at": "2024-04-29T11:19:14.214Z",
//           "version": 1714389554214,
//           "is_deleted": false,
//           "present_at_all_locations": true,
//           "item_variation_data": {
//             "item_id": "R2TZKGUEN7GSG3IB5DFLPQXM",
//             "name": "meru oak chair",
//             "ordinal": 0,
//             "pricing_type": "FIXED_PRICING",
//             "price_money": {
//               "amount": 200,
//               "currency": "USD"
//             },
//             "available_for_booking": false,
//             "sellable": true,
//             "stockable": true
//           }
//         }
//       ],
//       "product_type": "REGULAR",
//       "is_archived": false
//     }
//   },
//   "id_mappings": [
//     {
//       "client_object_id": "#furniture",
//       "object_id": "R2TZKGUEN7GSG3IB5DFLPQXM"
//     },
//     {
//       "client_object_id": "#small",
//       "object_id": "SPAMUK6VMFWFQEAHVF6I2VQB"
//     }
//   ]
// }

// has ordinal int parameter
// {
//   "catalog_object": {
//     "type": "ITEM",
//     "id": "R2TZKGUEN7GSG3IB5DFLPQXM",
//     "updated_at": "2024-04-30T07:51:21.468Z",
//     "created_at": "2024-04-29T11:19:14.214Z",
//     "version": 1714463481468,
//     "is_deleted": false,
//     "present_at_all_locations": true,
//     "item_data": {
//       "name": "furniture",
//       "abbreviation": "fnr",
//       "is_taxable": true,
//       "available_for_pickup": true,
//       "variations": [
//         {
//           "type": "ITEM_VARIATION",
//           "id": "SPAMUK6VMFWFQEAHVF6I2VQB",
//           "updated_at": "2024-04-30T07:51:21.468Z",
//           "created_at": "2024-04-29T11:19:14.214Z",
//           "version": 1714463481468,
//           "is_deleted": false,
//           "present_at_all_locations": true,
//           "item_variation_data": {
//             "item_id": "R2TZKGUEN7GSG3IB5DFLPQXM",
//             "name": "meru oak chair aged",
//             "ordinal": 0,
//             "pricing_type": "FIXED_PRICING",
//             "price_money": {
//               "amount": 500,
//               "currency": "USD"
//             },
//             "inventory_alert_threshold": 0,
//             "available_for_booking": false,
//             "sellable": false,
//             "stockable": true
//           }
//         }
//       ],
//       "product_type": "REGULAR",
//       "is_archived": false
//     }
//   }
// }