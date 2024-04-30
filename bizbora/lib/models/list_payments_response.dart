import 'square_cash_payment_response.dart';
import 'square_external_payments_response.dart';

class ListPaymentsResponse {
  final List<SquareExternalPaymentsResponse> externalPayments;
  final List<SquareCashPaymentsResponse> cashPayments;

  ListPaymentsResponse({
    required this.externalPayments,
    required this.cashPayments,
  });

  Map<String, dynamic> toMap() {
    return {
      'externalPayments':
          externalPayments.map((payment) => payment.toMap()).toList(),
      'cashPayments': cashPayments.map((payment) => payment.toJson()).toList(),
    };
  }

  factory ListPaymentsResponse.fromMap(Map<String, dynamic> map) {
    return ListPaymentsResponse(
      externalPayments: List<SquareExternalPaymentsResponse>.from(map[
              'payments']
          .where((payment) => payment['source_type'] == 'EXTERNAL')
          .map((payment) => SquareExternalPaymentsResponse.fromMap(payment))),
      cashPayments: List<SquareCashPaymentsResponse>.from(map['payments']
          .where((payment) => payment['source_type'] == 'CASH')
          .map((payment) => SquareCashPaymentsResponse.fromJson(payment))),
    );
  }

  // String toJson() => json.encode(toMap());

  // factory ListPaymentsResponse.fromJson(String source) =>
  //     ListPaymentsResponse.fromMap(json.decode(source));
}

// {
//   "payments": [
//     {
//       "id": "tcx9TQGt8pEWDY1KDOK4xZPGO4NZY",
//       "created_at": "2024-04-29T09:31:46.230Z",
//       "updated_at": "2024-04-29T09:31:46.383Z",
//       "amount_money": {
//         "amount": 110,
//         "currency": "USD"
//       },
//       "status": "COMPLETED",
//       "source_type": "EXTERNAL",
//       "location_id": "L0976QXCW7V28",
//       "order_id": "FmHJWVLnea8Xh0Q1SUxicPYl1wCZY",
//       "customer_id": "MHTPXJSBE0BQKJA8YVD8HQM330",
//       "total_money": {
//         "amount": 110,
//         "currency": "USD"
//       },
//       "capabilities": [
//         "EDIT_AMOUNT_UP",
//         "EDIT_AMOUNT_DOWN",
//         "EDIT_TIP_AMOUNT_UP",
//         "EDIT_TIP_AMOUNT_DOWN"
//       ],
//       "external_details": {
//         "type": "EMONEY",
//         "source": "Mpesa ",
//         "source_id": "EXTERNAL",
//         "source_fee_money": {
//           "amount": 0,
//           "currency": "USD"
//         }
//       },
//       "receipt_number": "tcx9",
//       "receipt_url": "https://squareupsandbox.com/receipt/preview/tcx9TQGt8pEWDY1KDOK4xZPGO4NZY",
//       "application_details": {
//         "square_product": "ECOMMERCE_API",
//         "application_id": "sandbox-sq0idb-XsiCUTkMwkWYeZnyn8-wbQ"
//       },
//       "version_token": "atjrmg4oP6lABzqkEokL01N0ZnCot9GfC5qg0pNWTIR6o"
//     },
//        {
//       "id": "L3jjXK4U5EuzL3m55kxVwqpFEw5YY",
//       "created_at": "2024-04-28T19:26:43.180Z",
//       "updated_at": "2024-04-28T19:26:43.333Z",
//       "amount_money": {
//         "amount": 40,
//         "currency": "USD"
//       },
//       "status": "COMPLETED",
//       "source_type": "CASH",
//       "location_id": "L0976QXCW7V28",
//       "order_id": "dSXDJs9erYJT6go8Hv3TKy4UUtWZY",
//       "customer_id": "MHTPXJSBE0BQKJA8YVD8HQM330",
//       "total_money": {
//         "amount": 40,
//         "currency": "USD"
//       },
//       "capabilities": [
//         "EDIT_AMOUNT_UP",
//         "EDIT_AMOUNT_DOWN",
//         "EDIT_TIP_AMOUNT_UP",
//         "EDIT_TIP_AMOUNT_DOWN"
//       ],
//       "cash_details": {
//         "buyer_supplied_money": {
//           "amount": 40,
//           "currency": "USD"
//         },
//         "change_back_money": {
//           "amount": 0,
//           "currency": "USD"
//         }
//       },
//       "receipt_number": "L3jj",
//       "receipt_url": "https://squareupsandbox.com/receipt/preview/L3jjXK4U5EuzL3m55kxVwqpFEw5YY",
//       "application_details": {
//         "square_product": "ECOMMERCE_API",
//         "application_id": "sandbox-sq0idb-XsiCUTkMwkWYeZnyn8-wbQ"
//       },
//       "version_token": "EHHWPRiUHWI2N9c89OCqelSicsSpy38pbQokz0BBrPp6o"
//     },
//  ]
// }