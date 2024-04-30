import 'package:bizbora/main.dart';
import 'package:bizbora/pages/order_page.dart';
import 'package:bizbora/pages/product_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/colors.dart';
import '../providers/providers.dart';

class HomeScaffold extends ConsumerWidget {
  const HomeScaffold({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.sizeOf(context);
    final currentTab = ref.watch(pageIndexProvider);
    ref.watch(previousPageIndexProvider);
    return DefaultTabController(
      length: 2,
      initialIndex: currentTab,
      child: Scaffold(
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            ProductsPage(title: 'Products'),
            OrderPage(title: 'Order'),
            // ProductsPage(title: 'page4'),
            // ProductsPage(title: 'page5'),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(
              left: 15, right: 15, bottom: kIsWeb ? 5 : 5),
          child: Card(
            elevation: 4,
            color: kwhite25525525510,
            child: TabBar(
              onTap: (value) {
                ref.read(pageIndexProvider.notifier).currentIndex(value);
                ref
                    .read(previousPageIndexProvider.notifier)
                    .currentIndex(value);
              },
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: kgreen02075310,
              tabs: [
                Tab(
                  icon: Icon(Icons.home,
                      color: currentTab == 0 ? kgreen02075310 : kblack00005),
                ),
                // Tab(
                //   icon: Icon(Icons.search,
                //       color: currentTab == 1 ? kgreen02075310 : kblack00005),
                // ),
                Tab(
                  icon: Icon(Icons.add_circle,
                      color: currentTab == 1 ? kgreen02075310 : kblack00005),
                ),
                // Tab(
                //   icon: Icon(Icons.person,
                //       color: currentTab == 2 ? kgreen02075310 : kblack00005),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
