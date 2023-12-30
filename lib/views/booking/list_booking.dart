import 'package:flutter/material.dart';
import 'package:LetsGo/theme/LetsGo_theme.dart';

import '../../widgets/booking/bookings_coming.dart';
import '../../widgets/booking/past_bookings.dart';
import '../../widgets/custom_app_bar/custom_whitout_appbar.dart';

class ListBooking extends StatefulWidget {
  const ListBooking({
    Key? key,
  }) : super(key: key);

  @override
  State<ListBooking> createState() => _ListBookingState();
}

class _ListBookingState extends State<ListBooking>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 60),
        child: CustomWhitoutAppBar(
            'Vos réservations', Colors.transparent, LetsGoTheme.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                const SizedBox(height: 40),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: TabBar(
                          unselectedLabelColor: LetsGoTheme.black,
                          labelColor: LetsGoTheme.white,
                          indicatorColor: Colors.white,
                          indicatorWeight: 2,
                          indicator: BoxDecoration(
                            color: LetsGoTheme.main,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          controller: tabController,
                          tabs: const [
                            Tab(
                              child: Text(
                                'À venir',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Passée',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: const [
                      BookingsComing(),
                      PastBookings(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
