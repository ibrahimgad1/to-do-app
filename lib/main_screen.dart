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
    var taskProvider = context.watch<TaskProvider>(); // Listen for changes

    return Scaffold(
      appBar: AppBar(
        title: const Text("To-Do App"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _navigateToAddTask(context),
          ),
        ],
      ),
      body: taskProvider.tasks.isEmpty
          ? const Center(child: Text("No tasks added"))
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
                color: Colors.red,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              child: Card(
                child: ListTile(
                  leading: Checkbox(
                    value: false,
                    onChanged: (bool? checked) {
                      if (checked == true) {
                        taskProvider.deleteTask(index);
                      }
                    },
                  ),
                  title: Text(taskProvider.tasks[index]["title"]!),
                  subtitle: Text(
                    "Duration: ${taskProvider.tasks[index]["duration"]} min | Category: ${taskProvider.tasks[index]["category"]}",
                  ),
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
