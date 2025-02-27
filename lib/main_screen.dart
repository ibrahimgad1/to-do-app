import 'package:corelia_task2/add_task.dart';
import 'package:corelia_task2/details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'task_provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  void _navigateToAddTask(BuildContext context) async {
    final newTask = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddTaskScreen()),
    );

    if (newTask != null) {
      context.read<TaskProvider>().addTask(newTask);
    }
  }

  @override
  Widget build(BuildContext context) {
    var taskProvider = context.watch<TaskProvider>();

    return Scaffold(
      backgroundColor: Colors.blueGrey[50], // Light background
      appBar: AppBar(
        title: const Text("To-Do App"),
        backgroundColor: Colors.blueAccent,
        elevation: 5,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () => _navigateToAddTask(context),
          ),
        ],
      ),
      body: taskProvider.tasks.isEmpty
          ? const Center(
        child: Text(
          "No tasks added yet!",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: taskProvider.tasks.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: Key(taskProvider.tasks[index]["title"]!),
              direction: DismissDirection.startToEnd,
              onDismissed: (direction) {
                taskProvider.deleteTask(index);
              },
              background: Container(
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(Icons.delete, color: Colors.white, size: 30),
              ),
              child: Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  leading: Transform.scale(
                    scale: 1.2,
                    child: Checkbox(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      activeColor: Colors.blueAccent,
                      value: false,
                      onChanged: (bool? checked) {
                        if (checked == true) {
                          taskProvider.deleteTask(index);
                        }
                      },
                    ),
                  ),
                  title: Text(
                    taskProvider.tasks[index]["title"]!,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    "Duration: ${taskProvider.tasks[index]["duration"]} min | Category: ${taskProvider.tasks[index]["category"]}",
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(task: taskProvider.tasks[index]),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

