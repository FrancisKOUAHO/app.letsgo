import 'package:flutter/material.dart';

import '../not_available_yet.dart';

class PastBookings extends StatefulWidget {
  const PastBookings({Key? key}) : super(key: key);

  @override
  State<PastBookings> createState() => _PastBookingsState();
}

class _PastBookingsState extends State<PastBookings> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: NotAvailableYet());
  }
}
