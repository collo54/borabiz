import 'package:bizbora/models/address_model.dart';

class CreateCustomerRequestModel {
  CreateCustomerRequestModel({
    required this.idempotencyKey,
    required this.givenName,
    required this.familyName,
    required this.companyName,
    required this.nickName,
    required this.emailAddress,
    required this.phoneNumber,
    required this.referenceId,
    required this.note,
    required this.birthday,
    required this.address,
  });

  final String idempotencyKey;
  final String givenName;
  final String familyName;
  final String companyName;
  final String nickName;
  final String emailAddress;
  final String phoneNumber;
  final String referenceId;
  final String note;
  final String birthday;
  final AddressModel address;

  Map<String, dynamic> toMap() {
    return {
      'idempotency_key': idempotencyKey,
      'given_name': givenName,
      'family_name': familyName,
      'company_name': companyName,
      'nickname': nickName,
      'email_address': emailAddress,
      'address': address.toMap(),
      'phone_number': phoneNumber,
      'reference_id': referenceId,
      'note': note,
      'birthday': birthday,
    };
  }

  /*
  factory CreateCustomerRequestModel.fromMap(Map<String, dynamic> data) {
    final int id = data['Id'];
    final String name = data['Name'];
    final String tag = data['Tag'];
    final double netWeight = data['NetWeight'];
    final String measureUnit = data['MeasureUnit'];
    final int pieces = data['Pieces'];
    final int productTypeId = data['ProductType_Id'];
    final int labelId = data['Label_Id'];
    final String sku = data['SKU'];
    final String upc = data['UPC'];
    final double price = data['Price'];
    final String nutrientFact = data['NutrientFact'];
    final int expiredays = data['ExpireDays'];
    final bool active = data['Active'];
    final bool isInsert = data['IsInsert'];
    const bool favorite = false;
    const bool expand = false;

    return CreateCustomerRequestModel(
      id: id,
      name: name,
      tag: tag,
      netWeight: netWeight,
      measureUnit: measureUnit,
      pieces: pieces,
      productTypeId: productTypeId,
      labelId: labelId,
      sku: sku,
      upc: upc,
      price: price,
      nutrientFact: nutrientFact,
      expiredays: expiredays,
      active: active,
      isInsert: isInsert,
      favourite: favorite,
      expanded: expand,
    );
  }
  */

  @override
  String toString() {
    return toMap().toString();
  }
}
