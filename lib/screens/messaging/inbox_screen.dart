import 'package:BuMo/screens/messaging/chat_screen.dart';
import 'package:BuMo/utils/widgets/message_item.dart';
import 'package:flutter/material.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  List<String> persons = ['Crisvin Habitsuela', 'Joshua Godalle', 'Pogi Ko'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          title: const Text(
            'Inbox',
            style: TextStyle(fontSize: 26),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
        child: ListView.builder(
          itemCount: persons.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(
                      personName: persons[index],
                    ),
                  ),
                );
              },
              child: MessageItem(
                personName: persons[index],
                onDelete: () {
                  setState(() {
                    persons.removeAt(index);
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
