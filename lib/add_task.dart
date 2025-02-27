import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _catController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, {
        "title": _titleController.text,
        "duration": _durationController.text,
        "category": _catController.text,
      });
    }
  }

  String? validateField(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return "Enter a $fieldName";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Task")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Title"),
                validator: (value) => validateField(value, "title"),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _durationController,
                decoration: const InputDecoration(labelText: "Duration (minutes)"),
                validator: (value) => validateField(value, "duration"),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _catController,
                decoration: const InputDecoration(labelText: "Category"),
                validator: (value) => validateField(value, "category"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveTask,
                child: const Text("Save Task"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
