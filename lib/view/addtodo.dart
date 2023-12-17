import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:path_provider/path_provider.dart';
import 'package:project_todo_getx/controller/todocontroller.dart';
import 'package:project_todo_getx/models/todo.dart';
import 'package:project_todo_getx/utility/circlebutton.dart';
import 'package:uuid/uuid.dart';

class AddToDO extends StatefulWidget {
  const AddToDO({super.key});
  @override
  State<AddToDO> createState() => _AddToDOState();
}

class _AddToDOState extends State<AddToDO> {
    final todocontroller = Get.put(ToDoController());

  late int selectedColorIndex = 0; // Track the selected color index
  
  late FocusNode _focusNode;

  // Hive.init(documentDirectory.path);
  @override
  void initState() {
    super.initState();
       _focusNode = FocusNode();
      _focusNode.requestFocus(); // Request focus here

    // initHive();
    // selectedColorIndex = 0;
  }

  Future<void> initHive() async {
    final documentDirectory = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(documentDirectory.path);
    await Hive.openBox('data');
  }

  // Future<void> addData(String id, String topic, bool isfinish) async {
  //   var data = Hive.box('data');
  //   data.put(id, {'id': id, 'topic': topic, 'isfinish': isfinish});
  // }

  

  Future<void> clearData() async {
    var data = Hive.box('data');
    await data.clear();
    print('Data cleared successfully');
  }

  void selectColor(Color color) {
    setState(() {
      selectedColor = color;
    });
  }

  var topicController = TextEditingController();
  Color selectedColor = Colors.red; // Default color
  String colorString = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add To Do."),
      ),
      body: Container(
        color: Colors.white, // Set body background color

        child: Column(
          children: [
            SizedBox(
              height: 240,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Form(
                  child: TextFormField(
                    controller: topicController,
                    focusNode: _focusNode, // Add this line
                    decoration: const InputDecoration(
                      labelText: "What Things To Do ?",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Your To Do';
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleColorButton(
                    color: Colors.red,
                    isSelected: selectedColor == Colors.red,
                    onPressed: () {
                      selectColor(Colors.red);
                      colorString = 'red';
                    },
                  ),
                  const SizedBox(width: 16),
                  CircleColorButton(
                    color: Colors.green,
                    isSelected: selectedColor == Colors.green,
                    onPressed: () {
                      selectColor(Colors.green);
                      colorString = 'green';
                    },
                  ),
                  const SizedBox(width: 16),
                  CircleColorButton(
                    color: Colors.blue,
                    isSelected: selectedColor == Colors.blue,
                    onPressed: () {
                      selectColor(Colors.blue);
                      colorString = 'blue';
                    },
                  ),
                  const SizedBox(width: 16),
                  CircleColorButton(
                    color: Colors.yellow,
                    isSelected: selectedColor == Colors.yellow,
                    onPressed: () {
                      selectColor(Colors.yellow);
                      colorString = 'yellow';
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String id = const Uuid().v4();
          String enteredText = topicController.text;
          ToDo newtd = ToDo(
             id, enteredText, false, selectedColor, DateTime.now());
          todocontroller.addData(
              newtd.id, newtd.topic, newtd.isfinish, newtd.color, newtd.order);
          todocontroller.addToDo(newtd);
          
          Navigator.pop(context);
          // await Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (context) => ReadToDo()),
          // );
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
