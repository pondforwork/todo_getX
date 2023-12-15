import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_todo_getx/controller/todocontroller.dart';
import 'package:project_todo_getx/models/todo.dart';

class ViewToDo extends StatelessWidget {
  ViewToDo({super.key});
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
                  itemCount: controller.todo.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      margin: EdgeInsets.all(12),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${controller.todo[index].topic}'),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  });
            },
          )),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ToDo newtd =
              ToDo("2222", "12345", false, Colors.black, DateTime.now());
          todocontroller.addToDo(newtd);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
