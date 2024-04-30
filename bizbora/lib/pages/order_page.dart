import 'dart:convert';

import 'package:bizbora/api/api_service.dart';
import 'package:bizbora/api/http_api_service.dart';
import 'package:bizbora/api/web_client.dart';
import 'package:bizbora/models/square_create_order_request.dart';
import 'package:bizbora/models/stkrequest_model.dart';
import 'package:bizbora/screens/products_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

import '../constants/colors.dart';
import '../models/address_model.dart';
import '../models/create_customer_request.dart';
import '../models/list_catalogue_response.dart';
import '../models/square_create_order_response.dart';
import '../models/square_external_payment_request.dart';
import '../providers/providers.dart';
import '../screens/order_screen.dart';

class OrderPage extends ConsumerStatefulWidget {
  const OrderPage({super.key, required this.title});

  final String title;

  @override
  ConsumerState<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends ConsumerState<OrderPage> {
  final _textEditingController = TextEditingController();
  //final repository = Repository();
  final _webClient = WebClient();
  Uuid _uuid = const Uuid();
  final mpesa = Mpesa();
  final _shortCode = "174379";
  String? _phoneNumber;
  String? _name;
  String? _customerId;
  String? _orderId;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  SquareCreateOrderResponse? _squareCreateOrderResponse;

  @override
  Widget build(BuildContext context) {
    final listProducts = ref.watch(listCatalogItemsProvider);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: kgreen02075310,
        title: Text(
          widget.title,
          style: const TextStyle(color: kwhite25525525510),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              _scaffoldKey.currentState!.showBottomSheet(
                  enableDrag: true,
                  (context) => buildBottomsheet(listProducts, 0));
              // await showModalBottomSheet(
              //   context: context,
              //   builder: (BuildContext bc) {
              //     return buildBottomsheet(listProducts);
              //   },
              // );
            },
            child: const Row(
              children: [
                Icon(
                  Icons.add,
                  color: kwhite25525525510,
                  size: 25,
                ),
                SizedBox(
                  width: 3,
                ),
                Text(
                  'create order',
                  style: TextStyle(color: kwhite25525525510),
                ),
              ],
            ),
          ),
        ],
      ),
      body: OrderScreen(),
    );
  }

  bool _validateAndSaveForm() {
    final form = _formKey.currentState!;
    if (form.validate()) {
      form.save();
      // form.reset();
      return true;
    }
    return false;
  }

  Future<void> _createCustomer(
    List<CatalogItem> listProducts,
  ) async {
    if (_validateAndSaveForm()) {
      try {
        _scaffoldKey.currentState!.showBodyScrim(true, 0.5);
        final AddressModel addressModel = AddressModel(
          addressLine1: '00300',
          addressLine2: 'nakuru kenya',
          locality: 'nakuru locality',
          subLocality: 'nakuru sublocality',
          subLocality2: 'nakuru sublocality 2',
          administrativeDistrict1: 'nakuru county',
          postalCode: '0100',
          country: 'KE',
        );

        final CreateCustomerRequestModel requestModel =
            CreateCustomerRequestModel(
          idempotencyKey: _uuid.v1(),
          givenName: _name!,
          familyName: _name!,
          companyName: 'bizbora',
          nickName: _name!,
          emailAddress: 'bizbora@gmail.com',
          phoneNumber: _phoneNumber!,
          referenceId: 'my id',
          note: 'customer create',
          birthday: '2000-07-09',
          address: addressModel,
        );

        final response = await _webClient.createandgetCustomerData(
          accessToken:
              'EAAAl3EEQNoAnhcMhRZQxqkI9IFuvzTNbtJyPWQPqWiEMx6LSAT1-cuGhuDOW9dQ',
          customerRequestModel: requestModel,
        );
        final id = response.overrallResponse.id;

        await _createOrder(listProducts, id);
        setState(() {
          _customerId = response.overrallResponse.id;
        });

        //showNoPermissionBluetoothDialog(response.toString());
      } catch (e) {
        debugPrint(e.toString());
        //  showNoPermissionBluetoothDialog(e.toString());
      }
    }
  }

  Future<void> _createOrder(
      List<CatalogItem> listProducts, String customerId) async {
    // if (_customerId != null) {
    try {
      List<LineItem> lineItems = listProducts.map((e) {
        CreateOrderRequestMoney requestMoney = CreateOrderRequestMoney(
            amount:
                e.itemData.variations.first.itemVariationData.priceMoney.amount,
            currency: e.itemData.variations.first.itemVariationData.priceMoney
                .currency);
        return LineItem(
            quantity: e.timesToPrint,
            basePriceMoney: requestMoney,
            itemType: e.type,
            name: e.itemData.name);
      }).toList();

      Order order = Order(
        lineItems: lineItems,
        locationId: 'L0976QXCW7V28',
        customerId: customerId,
      );
      SquareCreateOrderRequest squareCreateOrderRequest =
          SquareCreateOrderRequest(order: order, idempotencyKey: _uuid.v1());

      final response = await _webClient.createOrder(
        accessToken:
            'EAAAl3EEQNoAnhcMhRZQxqkI9IFuvzTNbtJyPWQPqWiEMx6LSAT1-cuGhuDOW9dQ',
        requestModel: squareCreateOrderRequest,
      );
      setState(() {
        _squareCreateOrderResponse = response;
      });

      final stri = response.lineItems.map((e) => e.name).toList().toString();
      debugPrint(stri);
      Navigator.of(context).pop();

      _scaffoldKey.currentState!.showBodyScrim(false, 0.5);

      _scaffoldKey.currentState!.showBottomSheet(
          enableDrag: true, (context) => buildBottomsheet(listProducts, 1));

      //showNoPermissionBluetoothDialog(response.toString());
    } catch (e) {
      debugPrint(e.toString());
      //  showNoPermissionBluetoothDialog(e.toString());
    }
    //  }
  }

  Future<void> _createExternalPayment({
    required String orderId,
    required String customerId,
    required String amount,
  }) async {
    // if (_customerId != null) {
    try {
      ExternalDetails externalDetails = ExternalDetails(
        type: "EMONEY",
        source: "Mpesa",
        sourceFeeMoney: ExternalPaymentsRequestMoney(
            amount: int.tryParse(amount)!, currency: "USD"),
        sourceId: "EXTERNAL",
      );

      var squareExternalPaymentsRequest2 = SquareExternalPaymentsRequest(
          idempotencyKey: _uuid.v1(),
          sourceId: 'EXTERNAL',
          amountMoney: ExternalPaymentsRequestMoney(
              amount: int.tryParse(amount)!, currency: "USD"),
          customerId: customerId,
          externalDetails: externalDetails);
      SquareExternalPaymentsRequest squareExternalPaymentsRequest =
          squareExternalPaymentsRequest2;

      final response = await _webClient.createExternalSquarePayment(
        accessToken:
            'EAAAl3EEQNoAnhcMhRZQxqkI9IFuvzTNbtJyPWQPqWiEMx6LSAT1-cuGhuDOW9dQ',
        requestModel: squareExternalPaymentsRequest,
      );
      setState(() {
        // _squareCreateOrderResponse = response;
      });

      // Navigator.of(context).pop();

      _scaffoldKey.currentState!.showBodyScrim(false, 0.5);

      //showNoPermissionBluetoothDialog(response.toString());
    } catch (e) {
      debugPrint(e.toString());
      //  showNoPermissionBluetoothDialog(e.toString());
    }
    //  }
  }

  Future<void> _requestStKCallhttp(double amount) async {
    if (_phoneNumber != null) {
      try {
        _scaffoldKey.currentState!.showBodyScrim(true, 0.5);
        final number = removePlusAndSpaces(_phoneNumber!);
        await mpesa.lipaNaMpesa(
          phoneNumber: number,
          amount: amount,
        );
        setState(() {});
      } catch (e) {
        //setState(() {});
      }
    }
  }

  // Future<void> _requestStKCall() async {
  //   try {
  //     String timestamp = getTodayValidTimeStamp();
  //     final stkrequest = StkRequest(
  //       businessShortCode: _shortCode,
  //       password: generatePasswordForStk(timestamp),
  //       timestamp: timestamp,
  //       transactionType: "CustomerPayBillOnline",
  //       amount: "1",
  //       partyA: _textEditingController.text,
  //       partyB: _shortCode,
  //       phoneNumber: _textEditingController.text,
  //       callBackURL: "https://8fa4-196-250-210-167.ngrok-free.app",
  //       accountReference: "account",
  //       transactionDesc: "Lipa Na Mpesa Online",
  //     );
  //     final result =
  //         await repository.stkPushOnlineMerchant(request: stkrequest);
  //   } catch (e) {
  //     setState(() {});
  //   }
  // }

  /// this generates the password for the stk push request
  String generatePasswordForStk(String timestamp) {
    const stkPassword =
        "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919";

    final bytes = utf8.encode("$_shortCode$stkPassword$timestamp");
    return base64.encode(bytes);
  }

  /// this provides the valid date stamp to be used in password generation for stk
  String getTodayValidTimeStamp() {
    var datedefinedstamp = DateTime.now();
    return "${datedefinedstamp.year.toString()}${datedefinedstamp.month.toString().padLeft(2, '0')}${datedefinedstamp.day.toString().padLeft(2, '0')}${datedefinedstamp.hour.toString().padLeft(2, '0')}${datedefinedstamp.minute.toString().padLeft(2, '0')}${datedefinedstamp.second.toString().padLeft(2, '0')}";
  }

  Widget _buildOrder() {
    if (_squareCreateOrderResponse != null) {
      final _children = _squareCreateOrderResponse!.lineItems
          .map(
            (e) => Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${e.name}:',
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        color: kblack00008,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 57,
                  ),
                  Text(
                    '${e.grossSalesMoney.amount} kes',
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        color: kblack00008,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList();
      return Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                children: _children,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Order Id:',
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        color: kblack00008,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: 120,
                    child: Text(
                      '${_squareCreateOrderResponse!.id}',
                      style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                            color: kblack00008,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Total:',
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        color: kblack00008,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 57,
                  ),
                  Text(
                    '${_squareCreateOrderResponse!.netAmountDueMoney.amount} kes',
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        color: kblack00008,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kgreen02075310,
                // fixedSize: Size(40, 40),
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontStyle: FontStyle.normal,
                ),
              ),
              onPressed: () async {
                //await _createCustomer(list);

                await _requestStKCallhttp(_squareCreateOrderResponse!
                    .netAmountDueMoney.amount
                    .toDouble());

                await _createExternalPayment(
                    orderId: _squareCreateOrderResponse!.id,
                    customerId: _customerId!,
                    amount: _squareCreateOrderResponse!.netAmountDueMoney.amount
                        .toString());
              },
              child: const Text(
                'Mpesa pay',
                style: TextStyle(fontSize: 13, color: kwhite25525525510),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: kgreen02075310,
            //     // fixedSize: Size(40, 40),
            //     textStyle: const TextStyle(
            //       color: Colors.white,
            //       fontSize: 10,
            //       fontStyle: FontStyle.normal,
            //     ),
            //   ),
            //   onPressed: () async {
            //     // await _createCustomer(list);
            //   },
            //   child: const Text(
            //     'Cash pay',
            //     style: TextStyle(fontSize: 13, color: kwhite25525525510),
            //   ),
            // ),
          ],
        ),
      );
    } else {
      return Center(
        child: Text(
          'no order created',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: kblackgrey62606310,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }
  }

  Widget _buildForm(List<CatalogItem> list) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(list),
      ),
    );
  }

  List<Widget> _buildFormChildren(List<CatalogItem> list) {
    return [
      Text(
        'Name',
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: kblackgrey62606310,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'name';
          }
          return null;
        },
        initialValue: '',
        onSaved: (value) => _name = value!.trim(),
        style: GoogleFonts.roboto(
          textStyle: const TextStyle(
            color: kblackgrey62606310,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        decoration: InputDecoration(
          fillColor: kwhite25525525510,
          label: Text(
            ' name ',
            style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                color: kblackgrey62606310,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          filled: true,
          hintText: '',
          labelStyle: const TextStyle(
            color: kblackgrey62606310,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kwhite21421421410, width: 1),
            // borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(4.0),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: kwhite21421421410, width: 1),
            // borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(4.0),
          ),
          focusColor: const Color.fromRGBO(243, 242, 242, 1),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kwhite21421421410, width: 1),
            borderRadius: BorderRadius.circular(4.0),
          ),
          hintStyle: GoogleFonts.dmSans(
            textStyle: const TextStyle(
              color: kblackgrey62606310,
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        maxLines: 1,
        textAlign: TextAlign.start,
      ),
      const SizedBox(
        height: 15,
      ),
      Text(
        'Phone number',
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: kblackgrey62606310,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'phone number';
          }
          return null;
        },
        initialValue: '',
        onSaved: (value) => _phoneNumber = value!.trim(),
        style: GoogleFonts.roboto(
          textStyle: const TextStyle(
            color: kblackgrey62606310,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        decoration: InputDecoration(
          fillColor: kwhite25525525510,
          label: Text(
            ' phone number ',
            style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                color: kblackgrey62606310,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          filled: true,
          hintText: '',
          labelStyle: const TextStyle(
            color: kblackgrey62606310,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kwhite21421421410, width: 1),
            // borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(4.0),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: kwhite21421421410, width: 1),
            // borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(4.0),
          ),
          focusColor: const Color.fromRGBO(243, 242, 242, 1),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kwhite21421421410, width: 1),
            borderRadius: BorderRadius.circular(4.0),
          ),
          hintStyle: GoogleFonts.dmSans(
            textStyle: const TextStyle(
              color: kblackgrey62606310,
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        maxLines: 1,
        textAlign: TextAlign.start,
      ),
      const SizedBox(
        height: 15,
      ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: kgreen02075310,
          fixedSize: Size(40, 40),
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontStyle: FontStyle.normal,
          ),
        ),
        onPressed: () async {
          await _createCustomer(list);
        },
        child: const Text(
          'Create Order',
          style: TextStyle(fontSize: 13, color: kwhite25525525510),
        ),
      ),
    ];
  }

  Widget buildBottomsheet(List<CatalogItem> list, int index) {
    // final pageIndexProv = ref.watch(pageIndexProvider.notifier);
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(blurRadius: 10, color: kgrey21721721705, spreadRadius: 5)
        ],
      ),
      child: DraggableScrollableSheet(
          initialChildSize: 0.8,
          minChildSize: 0.25,
          maxChildSize: 0.8,
          expand: false,
          builder: (_, draggableScrollController) {
            // RenderObject? box = globalKey.currentContext!.findRenderObject();
            // Offset offset =
            //     box.localToGlobal(Offset.zero);
            // double animationHeight = draggableScrollController.offset +
            //     offset.dy -
            //     MediaQueryData.fromView(view).padding.top -
            //     56.0;
            if (draggableScrollController.hasClients) {
              draggableScrollController.animateTo(
                100,
                duration: Duration(milliseconds: 500),
                curve: Curves.decelerate,
              );
            }
            return DefaultTabController(
              length: 2,
              initialIndex: index,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TabBar(
                    onTap: (value) {},
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: kgreen02075310,
                    tabs: [
                      Tab(
                        child: Center(
                          child: Text(
                            'Create Order',
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                letterSpacing: 0,
                                color: kblack12121210,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: Center(
                          child: Text(
                            'Choose Payment',
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                letterSpacing: 0,
                                color: kblack12121210,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Center(
                  //   child: Text(
                  //     'Create Order',
                  //     overflow: TextOverflow.ellipsis,
                  //     style: GoogleFonts.roboto(
                  //       textStyle: const TextStyle(
                  //         letterSpacing: 0,
                  //         color: kblack12121210,
                  //         fontSize: 14,
                  //         fontWeight: FontWeight.w500,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 10,
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.9,
                    width: MediaQuery.of(context).size.width,
                    child: TabBarView(
                      //physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: _buildForm(list),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: _buildOrder(),
                        ),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 10),
                  //   child: _buildForm(list),
                  // ),
                  const SizedBox(
                    height: 10,
                  ),

                  // Expanded(
                  //   child:
                  // ),

                  // DecoratedTextField(
                  //   userData: _userData,
                  //   postId: _postId,
                  // ),
                ],
              ),
            );
          }),
    );
  }

  String removePlusAndSpaces(String phoneNumber) {
    // Remove the initial '+' sign and any spaces
    return phoneNumber.replaceAll(RegExp(r'^\+|\s'), '');
  }
}
