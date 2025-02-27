import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final Map<String, String> task;

  const DetailScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Task Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Title: ${task["title"]}", style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Text("Duration: ${task["duration"]} min", style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Text("Category: ${task["category"]}", style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
