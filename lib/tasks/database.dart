import 'package:hive/hive.dart';

class ToDoDatabase{

  List toDoList = [];

  final _myBox = Hive.box('myBox');

  void createInitialData(){
    toDoList = [
      ["Default Task", false],
    ];
  }

  void loadData(){
    toDoList = _myBox.get("TODOLIST");
  }

  void updateDatabase(){
    _myBox.put("TODOLIST", toDoList);
  }

}