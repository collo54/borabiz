import 'package:flutter/material.dart';

import '../layouts/order_layout.dart';
import '../layouts/products_layout.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return LayoutBuilder(
      key: UniqueKey(),
      builder: (context, constraints) {
        if (size.width >= 992) {
          return const DesktopOrderScreen();
        } else {
          return const MobileOrderScreen();
        }
      },
    );
  }
}

//Builds the tablet log in layout according to its constraints
class DesktopOrderScreen extends StatelessWidget {
  const DesktopOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const OrderMobileLayout(); // ProductsDesktopLayout();
  }
}

//Builds the mobile log in layout according to its constraints
class MobileOrderScreen extends StatelessWidget {
  const MobileOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const OrderMobileLayout();
  }
}
