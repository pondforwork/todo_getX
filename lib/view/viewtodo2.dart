import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_todo_getx/controller/todocontroller.dart';
import 'package:project_todo_getx/models/todo.dart';
import 'package:project_todo_getx/view/viewfinishtodo.dart';

class ViewToDo extends StatefulWidget {
  final todocontroller = Get.put(ToDoController());

  ViewToDo({super.key});

  @override
  State<ViewToDo> createState() => _ViewToDoState();
}

class _ViewToDoState extends State<ViewToDo> {
  final todocontroller = Get.put(ToDoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To Do"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ViewFinishToDo()),
              );
            },
            icon: Icon(Icons.archive),
          ),
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(child: GetX<ToDoController>(
            builder: (controller) {
              return ListView.builder(
              
                  itemCount: controller.todo.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        print("Tap");
                        print(controller.todo[index].id);
                      },
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
                            // print(todo.id);
                            // _showDeleteDialog(todo.id);
                          },
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            // tileColor: controller.todo[index].color,
                            tileColor: Colors.red,

                            leading: Checkbox(
                              activeColor: Colors
                                  .white, // Set the color of the check mark when checked
                              checkColor: const Color.fromARGB(255, 8, 7,
                                  7), // Set the color of the check mark
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    8.0), // Set the border radius of the checkbox box
                                side: const BorderSide(
                                    color: Color.fromARGB(255, 9, 80,
                                        138)), // Set the border color and width
                              ),
                              value: controller.todo[index].isfinish,
                              onChanged: (bool? value) {
                                value = !value!;
                                print(value);
                                setState(() {
                                  controller.todo[index].isfinish =
                                      !controller.todo[index].isfinish;
                                  Future.delayed(const Duration(seconds: 3),
                                      () {
                                    controller.addData(
                                        controller.todo[index].id,
                                        controller.todo[index].topic,
                                        controller.todo[index].isfinish,
                                        controller.todo[index].color,
                                        controller.todo[index].order);
                                  });
                                });

                                // controller.fetchProducts();
                                // todo.isfinish = !todo.isfinish;

                                // setState(() {
                                //   addOrUpdateData(todo.id, todo.topic,
                                //       todo.isfinish, todo.color, todo.order);
                                //   // _data = dbHelper.getData();
                                // });
                              },
                            ),
                            title: Container(
                              width: 300,
                              height: 50,
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  controller.todo[index].topic,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ToDo newtd = ToDo("222112fgdsdfgs", "12345adfsdfgs", false,
              Colors.black, DateTime.now());

          todocontroller.addData(
              newtd.id, newtd.topic, newtd.isfinish, newtd.color, newtd.order);
          todocontroller.addToDo(newtd);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
