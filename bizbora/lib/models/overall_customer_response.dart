import 'customer_response.dart';

class OverrallCustomerResponse {
  OverrallCustomerResponse({
    required this.overrallResponse,
  });

  final CustomerResponseModel overrallResponse;

  Map<String, dynamic> toMap() {
    return {
      'customer': overrallResponse.toMap(),
    };
  }

  factory OverrallCustomerResponse.fromMap(Map<String, dynamic> data) {
    final CustomerResponseModel modeldata =
        CustomerResponseModel.fromMap(data['customer']);

    return OverrallCustomerResponse(
      overrallResponse: modeldata,
    );
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
