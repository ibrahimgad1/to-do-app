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
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: const Text("Add Task"),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: _inputDecoration("Title"),
                    validator: (value) => validateField(value, "title"),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _durationController,
                    decoration: _inputDecoration("Duration (minutes)"),
                    keyboardType: TextInputType.number,
                    validator: (value) => validateField(value, "duration"),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _catController,
                    decoration: _inputDecoration("Category"),
                    validator: (value) => validateField(value, "category"),
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: _saveTask,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Save Task",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
    );
  }
}

