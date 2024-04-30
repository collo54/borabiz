import 'package:flutter/material.dart';

import '../layouts/products_layout.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return LayoutBuilder(
      key: UniqueKey(),
      builder: (context, constraints) {
        if (size.width >= 992) {
          return const DesktopProductsScreen();
        } else {
          return const MobileProductsScreen();
        }
      },
    );
  }
}

//Builds the tablet log in layout according to its constraints
class DesktopProductsScreen extends StatelessWidget {
  const DesktopProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProductsMobileLayout(); // ProductsDesktopLayout();
  }
}

//Builds the mobile log in layout according to its constraints
class MobileProductsScreen extends StatelessWidget {
  const MobileProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProductsMobileLayout();
  }
}
