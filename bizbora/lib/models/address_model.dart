class AddressModel {
  AddressModel({
    required this.addressLine1,
    required this.addressLine2,
    required this.locality,
    required this.subLocality,
    required this.subLocality2,
    required this.administrativeDistrict1,
    required this.postalCode,
    required this.country,
  });

  final String addressLine1;
  final String addressLine2;
  final String locality;
  final String subLocality;
  final String subLocality2;
  final String administrativeDistrict1;
  final String postalCode;
  final String country;

  Map<String, dynamic> toMap() {
    return {
      'address_line_1': addressLine1,
      'address_line_2': addressLine2,
      'locality': locality,
      'sublocality': subLocality,
      'sublocality_2': subLocality2,
      'administrative_district_level_1': administrativeDistrict1,
      'postal_code': postalCode,
      'country': country,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> data) {
    final String addressline1 = data['address_line_1'] as String;
    final String addressline2 = data['address_line_2'] as String;
    final String locality = data['locality'] as String;
    final String sublocality = data['sublocality'] as String;
    final String sublocality2 = data['sublocality_2'] as String;
    final String administrativedistrict1 =
        data['administrative_district_level_1'] as String;
    final String postalcode = data['postal_code'] as String;
    final String country = data['country'] as String;

    return AddressModel(
      addressLine1: addressline1,
      addressLine2: addressline2,
      locality: locality,
      subLocality: sublocality,
      subLocality2: sublocality2,
      administrativeDistrict1: administrativedistrict1,
      postalCode: postalcode,
      country: country,
    );
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
