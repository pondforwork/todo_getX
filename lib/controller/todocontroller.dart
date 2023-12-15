import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_todo_getx/models/todo.dart';

class ToDoController extends GetxController {
  var todo = <ToDo>[].obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  addToDo(ToDo newtodo) {
    todo.add(newtodo);
  }

  void fetchProducts() {
    var todoResult = [
      ToDo("2222", "12345", false, Colors.black, DateTime.now()),
      ToDo("2222", "12345", false, Colors.black, DateTime.now()),
      ToDo("2222", "12345", false, Colors.black, DateTime.now()),
    ];

    todo.assignAll(todoResult);
  }
}
