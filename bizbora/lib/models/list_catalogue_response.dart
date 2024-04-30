class ListCatalogResponse {
  final List<CatalogItem> objects;

  ListCatalogResponse({required this.objects});

  factory ListCatalogResponse.fromMap(Map<String, dynamic> json) {
    final List<CatalogItem> objects = List<CatalogItem>.from(
        json['objects'].map((x) => CatalogItem.fromMap(x)));
    return ListCatalogResponse(objects: objects);
  }

  Map<String, dynamic> toMap() {
    return {
      'objects': objects.map((item) => item.toMap()).toList(),
    };
  }
}

class CatalogItem {
  final String type;
  final String id;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int version;
  final bool isDeleted;
  final bool presentAtAllLocations;
  final ItemData itemData;
  bool expanded;
  String timesToPrint;

  // // Getter
  // bool get expanded => _expanded;

  // // Setter
  // set value(bool newValue) {
  //   _expanded = newValue;
  // }

  CatalogItem({
    this.expanded = false,
    this.timesToPrint = '0',
    required this.type,
    required this.id,
    required this.updatedAt,
    required this.createdAt,
    required this.version,
    required this.isDeleted,
    required this.presentAtAllLocations,
    required this.itemData,
  });

  factory CatalogItem.fromMap(Map<String, dynamic> json) {
    return CatalogItem(
      type: json['type'],
      id: json['id'],
      updatedAt: DateTime.parse(json['updated_at']),
      createdAt: DateTime.parse(json['created_at']),
      version: json['version'],
      isDeleted: json['is_deleted'],
      presentAtAllLocations: json['present_at_all_locations'],
      itemData: ItemData.fromMap(json['item_data']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'id': id,
      'updated_at': updatedAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
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

  factory ItemData.fromMap(Map<String, dynamic> json) {
    final List<Variation> variations = List<Variation>.from(
        json['variations'].map((x) => Variation.fromMap(x)));
    return ItemData(
      name: json['name'],
      abbreviation: json['abbreviation'],
      isTaxable: json['is_taxable'] ?? false,
      availableForPickup: json['available_for_pickup'],
      variations: variations,
      productType: json['product_type'],
      isArchived: json['is_archived'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'abbreviation': abbreviation,
      'is_taxable': isTaxable,
      'available_for_pickup': availableForPickup,
      'variations': variations.map((item) => item.toMap()).toList(),
      'product_type': productType,
      'is_archived': isArchived,
    };
  }
}

class Variation {
  final String type;
  final String id;
  final DateTime updatedAt;
  final DateTime createdAt;
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

  factory Variation.fromMap(Map<String, dynamic> json) {
    return Variation(
      type: json['type'],
      id: json['id'],
      updatedAt: DateTime.parse(json['updated_at']),
      createdAt: DateTime.parse(json['created_at']),
      version: json['version'],
      isDeleted: json['is_deleted'],
      presentAtAllLocations: json['present_at_all_locations'],
      itemVariationData: ItemVariationData.fromMap(json['item_variation_data']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'id': id,
      'updated_at': updatedAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
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

  factory ItemVariationData.fromMap(Map<String, dynamic> json) {
    final containsThreshold = json.containsKey('inventory_alert_threshold');
    return ItemVariationData(
      itemId: json['item_id'],
      name: json['name'],
      ordinal: json['ordinal'],
      pricingType: json['pricing_type'],
      priceMoney: Money.fromMap(json['price_money']),
      inventoryThreshold:
          containsThreshold ? json['inventory_alert_threshold'] as int : 0,
      availableForBooking: json['available_for_booking'],
      sellable: json['sellable'] ?? false,
      stockable: json['stockable'] ?? false,
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

  Money({required this.amount, required this.currency});

  factory Money.fromMap(Map<String, dynamic> json) {
    return Money(
      amount: json['amount'],
      currency: json['currency'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'currency': currency,
    };
  }
}


// {
//   "objects": [ 
//    {
//       "type": "ITEM",
//       "id": "UJW5CY37FPJGQIWVMJR73BSB",
//       "updated_at": "2024-04-29T11:05:55.013Z",
//       "created_at": "2024-04-29T11:05:55.013Z",
//       "version": 1714388755013,
//       "is_deleted": false,
//       "present_at_all_locations": true,
//       "item_data": {
//         "name": "furniture",
//         "abbreviation": "fnr",
//         "is_taxable": true,
//         "available_for_pickup": true,
//         "variations": [
//           {
//             "type": "ITEM_VARIATION",
//             "id": "D4CJTYQPU4EJSSHCGDXTEGXB",
//             "updated_at": "2024-04-29T11:05:55.013Z",
//             "created_at": "2024-04-29T11:05:55.013Z",
//             "version": 1714388755013,
//             "is_deleted": false,
//             "present_at_all_locations": true,
//             "item_variation_data": {
//               "item_id": "UJW5CY37FPJGQIWVMJR73BSB",
//               "name": "meru oak chair",
//               "ordinal": 0,
//               "pricing_type": "FIXED_PRICING",
//               "price_money": {
//                 "amount": 200,
//                 "currency": "USD"
//               },
//               "available_for_booking": false,
//               "sellable": false,
//               "stockable": true
//             }
//           }
//         ],
//         "product_type": "REGULAR",
//         "is_archived": false
//       }
//     }
//   ]
// }