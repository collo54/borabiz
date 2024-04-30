import 'package:bizbora/models/address_model.dart';
import 'package:bizbora/models/preference_model.dart';

class CustomerResponseModel {
  CustomerResponseModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
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
    required this.creationSource,
    required this.version,
    required this.preferenceModel,
  });

  final String id;
  final String createdAt;
  final String updatedAt;
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
  final String creationSource;
  final PreferenceModel preferenceModel;
  final int version;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'given_name': givenName,
      'family_name': familyName,
      'company_name': companyName,
      'nickname': nickName,
      'email_address': emailAddress,
      'address': address.toMap(),
      'phone_number': phoneNumber,
      'reference_id': referenceId,
      'note': note,
      'preferences': preferenceModel.toMap(),
      'birthday': birthday,
      'creation_source': creationSource,
      'version': version,
    };
  }

  factory CustomerResponseModel.fromMap(Map<String, dynamic> data) {
    final String id = data['id'];
    final String createdat = data['created_at'];
    final String updatedat = data['updated_at'];
    final String givenname = data['given_name'];
    final String familyname = data['family_name'];
    final String companyname = data['company_name'];
    final String nickname = data['nickname'];
    final String emailaddress = data['email_address'];
    final String phonenumber = data['phone_number'];
    final String referenceid = data['reference_id'];
    final String note = data['note'];
    final String birthday = data['birthday'];
    final PreferenceModel preferencemodeldata =
        PreferenceModel.fromMap(data['preferences']);
    final AddressModel addressmodeldata = AddressModel.fromMap(data['address']);
    final String creationsource = data['creation_source'];
    final int version = data['version'];

    return CustomerResponseModel(
      id: id,
      createdAt: createdat,
      updatedAt: updatedat,
      givenName: givenname,
      familyName: familyname,
      companyName: companyname,
      nickName: nickname,
      emailAddress: emailaddress,
      phoneNumber: phonenumber,
      referenceId: referenceid,
      note: note,
      birthday: birthday,
      preferenceModel: preferencemodeldata,
      address: addressmodeldata,
      creationSource: creationsource,
      version: version,
    );
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
