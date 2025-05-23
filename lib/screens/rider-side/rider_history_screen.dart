import 'package:BuMo/utils/widgets/passenger_history_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PassengerHistoryScreen extends ConsumerWidget {
  const PassengerHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "History",
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const PassengerHistoryCard(
            destination: "Zone 8, Bulan Sorsogon",
            price: 40.00,
            status: false,
            startTime: "19 Mar 2025, 12:34 PM",
          ),
          const PassengerHistoryCard(
            destination: "Aquino, Bulan Sorsogon",
            price: 5.00,
            status: true,
            startTime: "01 Mar 2025, 2:34 PM",
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 10, right: 10),
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Theme.of(context).primaryColor),
            child: Center(
              child: Text(
                "View Older History",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
