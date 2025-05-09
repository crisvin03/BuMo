import 'package:BuMo/screens/messaging/inbox_screen.dart';
import 'package:BuMo/screens/registration/number_verification_screen.dart';
import 'package:BuMo/screens/rider-side/rider_history_screen.dart';
import 'package:BuMo/screens/login_screen.dart'; // Import LoginScreen
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomNavigationDrawer extends ConsumerWidget {
  const CustomNavigationDrawer({super.key});

  void _logout(BuildContext context, WidgetRef ref) {
    // Perform logout logic here (e.g., clear user session, Firebase sign out, etc.)
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false, // Removes all previous routes
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final account = ref.watch(accountProvider);

    return Drawer(
      width: 264,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/sidebar_header.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Image.asset(
                      'assets/images/profile_placeholder.png',
                      width: 80,
                      height: 80,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        '${account.firstName!} ${account.lastName}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 5),
                      const Icon(Icons.arrow_forward_ios, size: 15),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('History'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PassengerHistoryScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.bookmark_border_outlined),
            title: const Text('Saved Places'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SavedPlacesScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.payment_outlined),
            title: const Text('Payment Options'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PaymentOptionsScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.headset_mic_outlined),
            title: const Text('Support'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SupportScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.chat_bubble_outline),
            title: const Text('Inbox'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const InboxScreen()),
              );
            },
          ),
          const Divider(), // Add a line separator
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              'Log Out',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            onTap: () => _logout(context, ref), // Call logout function
          ),
        ],
      ),
    );
  }
}

// Placeholder Screens for new features
class SavedPlacesScreen extends StatelessWidget {
  const SavedPlacesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saved Places')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            subtitle: Text('Zone 8, Bulan Sorsogon'),
          ),
          ListTile(
            leading: Icon(Icons.work),
            title: Text('Work'),
            subtitle: Text('456 Office Ave, Business District'),
          ),
        ],
      ),
    );
  }
}

class PaymentOptionsScreen extends StatelessWidget {
  const PaymentOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment Options')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select your preferred payment method:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.attach_money,
                          color: Colors.green, size: 30),
                      const SizedBox(width: 10),
                      const Text(
                        "Cash",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const Icon(Icons.check_circle, color: Colors.green),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Note: Currently, only cash payments are supported. "
              "Please ensure you have sufficient cash to pay for your ride.",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Support')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          ListTile(
            leading: Icon(Icons.help_outline),
            title: Text('FAQs'),
            subtitle: Text('Find answers to common questions.'),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('Contact Support'),
            subtitle: Text('Call or email our support team \n BuMo@gmail.com.'),
          ),
          ListTile(
            leading: Icon(Icons.report_problem),
            title: Text('Report an Issue'),
            subtitle: Text('Let us know about a problem.'),
          ),
        ],
      ),
    );
  }
}
