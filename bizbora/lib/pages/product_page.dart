import 'dart:convert';

import 'package:bizbora/api/api_service.dart';
import 'package:bizbora/api/http_api_service.dart';
import 'package:bizbora/models/stkrequest_model.dart';
import 'package:bizbora/screens/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

import '../api/web_client.dart';
import '../constants/colors.dart';
import '../models/upsert_catalogobject_request.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key, required this.title});

  final String title;

  @override
  ProductsPageState createState() => ProductsPageState();
}

class ProductsPageState extends State<ProductsPage> {
  final _textEditingController = TextEditingController();
  //final repository = Repository();
  final mpesa = Mpesa();
  final _shortCode = "174379";
  String? _name;
  String? _abbreviation;
  String? _amount;
  final _webClient = WebClient();
  Uuid _uuid = const Uuid();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {
              _scaffoldKey.currentState!.showBottomSheet(
                enableDrag: true,
                (context) => buildBottomsheet(),
              );
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
                  'add product',
                  style: TextStyle(color: kwhite25525525510),
                ),
              ],
            ),
          ),
        ],
      ),
      body: ProductsScreen(),
    );
  }

  Future<void> _createCatalogItem() async {
    if (_validateAndSaveForm()) {
      try {
        _scaffoldKey.currentState!.showBodyScrim(true, 0.5);

        UpsertRequestMoney priceMoney = UpsertRequestMoney(
            amount: int.tryParse(_amount!)!, currency: 'USD');

        UpsertRequestItemVariationData itemVariationData =
            UpsertRequestItemVariationData(
          availableForBooking: false,
          itemId: '#furniture',
          name: _name!,
          pricingType: 'FIXED_PRICING',
          sellable: true,
          priceMoney: priceMoney,
          inventoryThreshold: 0,
        );

        UpsertRequestVariation upsertRequestVariation = UpsertRequestVariation(
          id: '#small',
          type: 'ITEM_VARIATION',
          itemVariationData: itemVariationData,
          version: 1,
        );

        UpsertItemData upsertItemData = UpsertItemData(
          abbreviation: _abbreviation!,
          availableForPickup: true,
          name: _name!,
          variations: [upsertRequestVariation],
        );

        UpsertCatalogObjectRequest upsertCatalogObjectRequest =
            UpsertCatalogObjectRequest(
          idempotencyKey: _uuid.v1(),
          object: CatalogObject(
              id: '#furniture',
              type: 'ITEM',
              isDeleted: false,
              version: 1,
              itemData: upsertItemData),
        );

        final response = await _webClient.upsertCatalogObject(
          accessToken:
              'EAAAl3EEQNoAnhcMhRZQxqkI9IFuvzTNbtJyPWQPqWiEMx6LSAT1-cuGhuDOW9dQ',
          requestModel: upsertCatalogObjectRequest,
        );

        _scaffoldKey.currentState!.showBodyScrim(false, 0.5);

        setState(() {
          //   _customerId = response.overrallResponse.id;
        });
        Navigator.of(context).pop();
        //showNoPermissionBluetoothDialog(response.toString());
      } catch (e) {
        debugPrint(e.toString());
        //  showNoPermissionBluetoothDialog(e.toString());
      }
    }
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

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }

  List<Widget> _buildFormChildren() {
    return [
      Text(
        'Abbreviation',
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
            return 'abbreviation';
          }
          return null;
        },
        initialValue: '',
        onSaved: (value) => _abbreviation = value!.trim(),
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
            ' abbreviation ',
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
        'Amount',
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
            return 'amount';
          }
          return null;
        },
        initialValue: '',
        onSaved: (value) => _amount = value!.trim(),
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
            ' amount ',
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
          await _createCatalogItem();
        },
        child: const Text(
          'Create catalog item',
          style: TextStyle(fontSize: 13, color: kwhite25525525510),
        ),
      ),
    ];
  }

  Widget buildBottomsheet() {
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
            return ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    'Create catalog Item',
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

                const SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: _buildForm(),
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
            );
          }),
    );
  }
}
