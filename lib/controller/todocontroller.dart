import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_todo_getx/models/todo.dart';

class ToDoController extends GetxController {
  var todo = <ToDo>[].obs;
  var finishedtodo = <ToDo>[].obs;
  @override
  void onInit() {
    initHive();
    fetchToDo();
    fetchFinishedToDo();
    // clearData();
    super.onInit();
  }

  addToDo(ToDo newtodo) {
    todo.add(newtodo);
    fetchToDo();
  }

  Future<void> initHive() async {
    final documentDirectory = await getApplicationDocumentsDirectory();
    try {
      await Hive.initFlutter(documentDirectory.path);
      Hive.registerAdapter(ColorAdapter());
      await Hive.openBox('data');
      // await clearData();
    } catch (error) {
      print("Hive initialization error: $error");
    }
  }

  Future<void> fetchToDo() async {
    try {
      final documentDirectory = await getApplicationDocumentsDirectory();
      await Hive.initFlutter(documentDirectory.path);
      await Hive.openBox('data');
      var data = Hive.box('data');
      List<dynamic> values = data.values.toList();
      List<ToDo> allData = [];

      for (dynamic value in values) {
        if (value != null && value['isfinish'] == false) {
          allData.add(ToDo(
            value['id'],
            value['topic'],
            bool.parse(value['isfinish'].toString()),
            value['color'],
            value['order'],
          ));
        }
      }

      // Sort the list by the "order" property
      allData.sort((a, b) => a.order.compareTo(b.order));

      todo.assignAll(allData);
    } catch (error) {
      print("Error while accessing data: $error");
    }
  }

  Future<void> fetchFinishedToDo() async {
    // var todoResult = [
    //   ToDo("2222", "12345", false, Colors.black, DateTime.now()),
    //   ToDo("2222", "12345", false, Colors.black, DateTime.now()),
    //   ToDo("2222", "12345", false, Colors.black, DateTime.now()),
    // ];
    try {
      final documentDirectory = await getApplicationDocumentsDirectory();
      await Hive.initFlutter(documentDirectory.path);
      await Hive.openBox('data');
      var data = Hive.box('data');
      List<dynamic> values = data.values.toList();
      List<ToDo> allFinishedData = [];

      for (dynamic value in values) {
        if (value != null && value['isfinish'] == true) {
          allFinishedData.add(ToDo(
            value['id'],
            value['topic'],
            bool.parse(value['isfinish'].toString()),
            value['color'],
            value['order'],
          ));
        }
      }

      // Sort the list by the "order" property
      allFinishedData.sort((a, b) => a.order.compareTo(b.order));

      finishedtodo.assignAll(allFinishedData);
    } catch (error) {
      print("Error while accessing data: $error");
    }
  }

  Future<void> addData(String id, String topic, bool isfinish, Color color,
      DateTime order) async {
    var data = Hive.box('data');
    data.put(id, {
      'id': id,
      'topic': topic,
      'isfinish': isfinish,
      'color': color,
      'order': order
    });
    fetchToDo();
  }

  Future<void> deleteData(String id) async {
    var data = Hive.box('data');
    if (data.containsKey(id)) {
      await data.delete(id);
      fetchFinishedToDo();
      fetchToDo();
    } else {
      print('Data with ID $id not found.');
    }
  }

  Future<void> clearData() async {
    final documentDirectory = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(documentDirectory.path);
    await Hive.openBox('data');
    var data = Hive.box('data');
    await data.clear();
    fetchToDo(); // Refresh the list after clearing data
    print("Clear Data SUccess");
  }
}
