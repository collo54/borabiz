import 'package:bizbora/models/list_catalogue_response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListProvider extends Notifier<List<CatalogItem>> {
  @override
  List<CatalogItem> build() {
    return [];
  }

  void increment(CatalogItem product) {
    debugPrint('add items previous items is ${state.length}');
    state.add(product);
    debugPrint('add items current items is ${state.length}');
  }

  void clearList(CatalogItem product) {
    debugPrint('previous items is ${state.length}');
    state.clear();
    debugPrint('current items is ${state.length}');
  }
}
