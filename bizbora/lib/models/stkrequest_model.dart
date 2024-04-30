class StkRequest {
  String businessShortCode;
  String password;
  String timestamp;
  String transactionType;
  String amount;
  String partyA;
  String partyB;
  String phoneNumber;
  String callBackURL;
  String accountReference;
  String transactionDesc;

  StkRequest({
    required this.businessShortCode,
    required this.password,
    required this.timestamp,
    required this.transactionType,
    required this.amount,
    required this.partyA,
    required this.partyB,
    required this.phoneNumber,
    required this.callBackURL,
    required this.accountReference,
    required this.transactionDesc,
  });

  factory StkRequest.fromJson(Map<String, dynamic> json) {
    return StkRequest(
      businessShortCode: json['BusinessShortCode'],
      password: json['Password'],
      timestamp: json['Timestamp'],
      transactionType: json['TransactionType'],
      amount: json['Amount'],
      partyA: json['PartyA'],
      partyB: json['PartyB'],
      phoneNumber: json['PhoneNumber'],
      callBackURL: json['CallBackURL'],
      accountReference: json['AccountReference'],
      transactionDesc: json['TransactionDesc'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['BusinessShortCode'] = businessShortCode;
    data['Password'] = password;
    data['Timestamp'] = timestamp;
    data['TransactionType'] = transactionType;
    data['Amount'] = amount;
    data['PartyA'] = partyA;
    data['PartyB'] = partyB;
    data['PhoneNumber'] = phoneNumber;
    data['CallBackURL'] = callBackURL;
    data['AccountReference'] = accountReference;
    data['TransactionDesc'] = transactionDesc;
    return data;
  }
}
