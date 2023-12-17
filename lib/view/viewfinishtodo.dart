import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_todo_getx/controller/todocontroller.dart';
import 'package:project_todo_getx/models/todo.dart';

class ViewFinishToDo extends StatefulWidget {
  final todocontroller = Get.put(ToDoController());

  ViewFinishToDo({super.key});

  @override
  State<ViewFinishToDo> createState() => _ViewFinishToDoState();
}

class _ViewFinishToDoState extends State<ViewFinishToDo> {
  final todocontroller = Get.put(ToDoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To Do"),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(child: GetX<ToDoController>(
            builder: (controller) {
              return ListView.builder(
                  itemCount: controller.finishedtodo.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Set the border radius
                          side: const BorderSide(
                              color: Color.fromARGB(255, 255, 0,
                                  0), // i need to apply my col here
                              width: 1), // Set the border color and width
                        ),
                        child: GestureDetector(
                          onLongPress: () {
                            print(controller.finishedtodo[index].id);
                            print(controller.finishedtodo[index].topic);
                            print(controller.finishedtodo[index].isfinish);
                            showDeleteConfirmationDialog(
                                controller.finishedtodo[index].id);
                            // print(todo.id);
                            // _showDeleteDialog(todo.id);
                          },
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            // tileColor: controller.todo[index].color,
                            tileColor: Colors.red,

                            title: Container(
                              width: 300,
                              height: 50,
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  controller.finishedtodo[index].topic,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            },
          )),
        ],
      )),
    );
  }

  Future<void> showDeleteConfirmationDialog(String id) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this ToDo item?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Delete the data and close the dialog
                todocontroller.deleteData(id);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
