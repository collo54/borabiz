//import 'dart:io';

import 'package:bizbora/models/list_catalogue_response.dart';
import 'package:bizbora/models/upsert_catalogobject_request.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

import '../../api/api_service.dart';
import '../../constants/colors.dart';
import '../../providers/providers.dart';
import '../api/web_client.dart';
import '../models/address_model.dart';
import '../models/create_customer_request.dart';

var list = [for (var i = 0; i <= 30; i++) i].map((element) {
  return element.toString();
});

// 1. extend [ConsumerStatefulWidget]
class OrderMobileLayout extends ConsumerStatefulWidget {
  const OrderMobileLayout({
    super.key,
  });

  @override
  ConsumerState<OrderMobileLayout> createState() => _OrderMobileLayoutState();
}

// 2. extend [ConsumerState]
class _OrderMobileLayoutState extends ConsumerState<OrderMobileLayout> {
  bool _loading = false;
  final webClient = WebClient();
  String? _accessToken;
  Uuid _uuid = const Uuid();
  bool isChecked = false;
  //bool? expanded = false;
  Future<ListCatalogResponse>? value;
  String? _dropdownvalue;

  // Other existing code...

  // Map to track expansion state for each CatalogItem
  Map<String, bool> expansionStates = {};

  @override
  void initState() {
    super.initState();
    value = webClient.listCatalog(
        accessToken:
            'EAAAl3EEQNoAnhcMhRZQxqkI9IFuvzTNbtJyPWQPqWiEMx6LSAT1-cuGhuDOW9dQ');
    _dropdownvalue = list.first;
    // Initialize expansion states map
    // _expansionStates =
    //     Map.fromIterable(, key: (e) => e.id, value: (_) => false);
    // ref.read(listCatalogItemsProvider.notifier).state.clear();
    // ref.read(removeCatalogItemsProvider.notifier).state.clear();
  }

  @override
  void dispose() {
    super.dispose();
  }

//

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final pageIndexProv = ref.watch(pageIndexProvider.notifier);
    bool isAndroid = Theme.of(context).platform == TargetPlatform.android;
    final listProducts = ref.watch(listCatalogItemsProvider);
    final removeProducts = ref.watch(removeCatalogItemsProvider);
    return SizedBox(
      height: size.height - (kBottomNavigationBarHeight + 13),
      width: size.width,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    //height: MediaQuery.of(context).size.height,
                    width: size.width,
                    child: getProducts(listProducts, removeProducts, size),
                  ),
                ],
              ),
            ),
          ),
          if (_loading)
            Align(
              alignment: Alignment.topCenter,
              child: Transform.translate(
                offset: const Offset(0, 200),
                child: const CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Widget getProducts(
      List<CatalogItem> model, List<CatalogItem> remove, Size size) {
    if (model.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: ExpansionPanelList(
          key: UniqueKey(),
          expansionCallback: (panelIndex, isExpand) async {},
          dividerColor: kgrey12212312510,
          elevation: 4,
          expandIconColor: kwhite24024024010,
          expandedHeaderPadding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 0,
          ),
          children: model
              .map<ExpansionPanel>((e) => ExpansionPanel(
                    backgroundColor: kwhite24024024010,
                    isExpanded: true,
                    headerBuilder: (BuildContext context, bool isexpanded) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: ListTile(
                          leading: Text(
                            e.type,
                            style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                color: kblack00008,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          horizontalTitleGap: 34,
                          title: Text(
                            e.itemData.name,
                            style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                color: kblack00008,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    body: Padding(
                      padding: const EdgeInsets.only(
                        left: 28,
                        right: 20,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              // Flexible(
                              //   flex: 2,
                              //   child: Padding(
                              //     padding: const EdgeInsets.only(
                              //       right: 40,
                              //     ),
                              //     child: TextButton(
                              //       onPressed: () async {
                              //         ProductModel p = ProductModel(
                              //           id: e.id,
                              //           name: e.name,
                              //           tag: e.tag,
                              //           netWeight: e.netWeight,
                              //           measureUnit: e.measureUnit,
                              //           pieces: e.pieces,
                              //           productTypeId: e.productTypeId,
                              //           labelId: e.labelId,
                              //           sku: e.sku,
                              //           upc: e.upc,
                              //           price: e.price,
                              //           nutrientFact: e.nutrientFact,
                              //           expiredays: e.expiredays,
                              //           active: e.active,
                              //           isInsert: e.isInsert,
                              //           timesToPrint: e.timesToPrint,
                              //           expanded: e.expanded,

                              //         );
                              //         await dbHelper.updateProduct(p);
                              //         setState(() {
                              //           value = dbHelper.queryProduct();
                              //         });
                              //       },
                              //       child: Image.asset(
                              //         e.favourite == true
                              //             ? 'assets/images/heart.png'
                              //             : 'assets/images/love.png',
                              //         width: 15,
                              //         height: 15,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              Flexible(
                                flex: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 7.5),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Units:',
                                            style: GoogleFonts.inter(
                                              textStyle: const TextStyle(
                                                color: kblack00008,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 57,
                                          ),
                                          Text(
                                            e.timesToPrint,
                                            style: GoogleFonts.inter(
                                              textStyle: const TextStyle(
                                                color: kblack00008,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 7.5,
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Currency:',
                                            style: GoogleFonts.inter(
                                              textStyle: const TextStyle(
                                                color: kblack00008,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 59,
                                          ),
                                          Text(
                                            'kes',
                                            // e
                                            //     .itemData
                                            //     .variations
                                            //     .first
                                            //     .itemVariationData
                                            //     .priceMoney
                                            //     .currency,
                                            style: GoogleFonts.inter(
                                              textStyle: const TextStyle(
                                                color: kblack00008,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 7.5,
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Total Price:',
                                            style: GoogleFonts.inter(
                                              textStyle: const TextStyle(
                                                color: kblack00008,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 68,
                                          ),
                                          Text(
                                            '${e.itemData.variations.first.itemVariationData.priceMoney.amount * int.tryParse(e.timesToPrint)!}',
                                            style: GoogleFonts.inter(
                                              textStyle: const TextStyle(
                                                color: kblack00008,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 1,
                            color: kgrey12212312510,
                          ),
                        ],
                      ),
                    ),
                  ))
              .toList(),
        ),
      );
    }
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: size.height / 2 - 100),
        child: Text(
          'no products selected',
          style: GoogleFonts.inter(
            textStyle: const TextStyle(
              color: kblack00008,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  void _dropDownCallback(String selectedvalue) {
    setState(() {
      _dropdownvalue = selectedvalue;
    });
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return kblue12915824210;
  }

  Future<void> _requestToken() async {
    try {
      final token = await webClient.fetchToken();
      debugPrint(token);
      debugPrint('callback called');
      setState(() {
        _accessToken = token;
      });
    } catch (e) {
      setState(() {
        _accessToken = e.toString();
      });
      debugPrint(e.toString());
    }
  }

  Future<void> _sendAPItest() async {
    try {
      String accesstoken = '';

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
        givenName: 'collins martin',
        familyName: 'menelik',
        companyName: 'new haven',
        nickName: 'marmen',
        emailAddress: 'memnelik@gmail.com',
        phoneNumber: '+254 766356976',
        referenceId: 'my id',
        note: 'flutter customer test',
        birthday: '2000-07-09',
        address: addressModel,
      );

      final response = await webClient.createandgetCustomerData(
        accessToken: accesstoken,
        customerRequestModel: requestModel,
      );
      showNoPermissionBluetoothDialog(response.toString());
    } catch (e) {
      showNoPermissionBluetoothDialog(e.toString());
    }
  }

  Future<void> showNoPermissionBluetoothDialog(String e) async =>
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error '),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(e),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Acknowledge'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
}
