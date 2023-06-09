import 'package:flutter/material.dart';
import 'package:my_app/model/task.dart';

import 'task_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Task> tasks = Task.getFiveTasks();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Hello',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            const Text(
                'Current Tasks',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20)
            ),
            for (Task task in tasks)
              TaskWidget(task: task)
          ],
        )
      )
    );
  }
}