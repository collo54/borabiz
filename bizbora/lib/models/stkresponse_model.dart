class StkResponse {
  String merchantRequestID;
  String checkoutRequestID;
  String responseCode;
  String responseDescription;
  String customerMessage;

  StkResponse({
    required this.merchantRequestID,
    required this.checkoutRequestID,
    required this.responseCode,
    required this.responseDescription,
    required this.customerMessage,
  });

  factory StkResponse.fromJson(Map<String, dynamic> json) {
    return StkResponse(
      merchantRequestID: json['MerchantRequestID'],
      checkoutRequestID: json['CheckoutRequestID'],
      responseCode: json['ResponseCode'],
      responseDescription: json['ResponseDescription'],
      customerMessage: json['CustomerMessage'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MerchantRequestID'] = merchantRequestID;
    data['CheckoutRequestID'] = checkoutRequestID;
    data['ResponseCode'] = responseCode;
    data['ResponseDescription'] = responseDescription;
    data['CustomerMessage'] = customerMessage;
    return data;
  }
}
