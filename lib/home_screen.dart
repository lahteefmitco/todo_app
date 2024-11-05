import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _taskController = TextEditingController();
  final FocusNode _taskFocusNode = FocusNode();

  final List<Map<String, dynamic>> _todoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TO DO APP"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Task add part
            Card(
              color: const Color.fromARGB(255, 157, 183, 204),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Task text field
                    TextField(
                      controller: _taskController,
                      focusNode: _taskFocusNode,
                      decoration: const InputDecoration(
                        label: Text("Task"),
                        border: OutlineInputBorder(),
                      ),
                    ),

                    // To give gap
                    const SizedBox(
                      height: 8,
                    ),

                    // Save button
                    ElevatedButton(
                      onPressed: () {
                        final task = {
                          "task": _taskController.text.trim(),
                          "status": false
                        };
                        _todoList.add(task);
                        _taskFocusNode.unfocus();
                        _taskController.clear();

                        setState(() {});
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber),
                      child: const Text("ADD"),
                    ),
                  ],
                ),
              ),
            ),

            // gap
            const SizedBox(
              height: 32,
            ),

            // Listview
            Expanded(
              // Expanded given to fill available space, to scroll  and to solve overflow issue.
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {

                  // getting todo list
                  final todo = _todoList[index];

                  // list card
                  return Card(
                    color: todo["status"] ? Colors.blue : null,
                    child: ListTile(
                      title: Text(
                        todo["task"],
                        style: TextStyle(
                          decoration: todo["status"]
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),

                      // Checkbox to show completed
                      trailing: Checkbox(
                        value: todo["status"],
                        onChanged: (value) {
                          if (value != null) {
                            _todoList[index]["status"] = value;
                            setState(() {});
                          }
                        },
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 16,
                  );
                },
                itemCount: _todoList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clear task controller
    _taskController.dispose();

    // Clear focusnode
    _taskFocusNode.dispose();
    super.dispose();
  }
}
