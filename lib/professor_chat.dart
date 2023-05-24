import 'package:flutter/material.dart';

class ProfessorChatScreen extends StatelessWidget {
  final String name;
  final String person;

  const ProfessorChatScreen(
      {Key? key, required this.name, required this.person})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with $person'),
      ),
      body: Center(
        child: Text('Chat screen for $name with $person'),
      ),
    );
  }
}
