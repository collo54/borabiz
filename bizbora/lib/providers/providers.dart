import 'package:bizbora/models/list_catalogue_response.dart';
import 'package:bizbora/providers/list_addcatalogitem.dart';
import 'package:bizbora/providers/remove_list_catalogitem.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'page_index.dart';
import 'previous_page_index.dart';

final pageIndexProvider = NotifierProvider<PageIndex, int>(PageIndex.new);
final previousPageIndexProvider =
    NotifierProvider<PreviousPageIndex, List<int>>(PreviousPageIndex.new);
final listCatalogItemsProvider =
    NotifierProvider<ListProvider, List<CatalogItem>>(ListProvider.new);
final removeCatalogItemsProvider =
    NotifierProvider<RemoveProvider, List<CatalogItem>>(RemoveProvider.new);
