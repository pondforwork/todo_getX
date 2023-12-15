import 'package:flutter/material.dart';
import 'package:project_todo_getx/view/viewtodo.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: ViewToDo()
    );
  }
}
