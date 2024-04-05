import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class ToDoTile extends StatelessWidget {

  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;
  final String currentDate;

  ToDoTile({Key? key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  }) : currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now()),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion:const StretchMotion(),
          children: [
            SlidableAction(onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.white,
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(currentDate,style: TextStyle(color: Colors.white),),
            Container(
              padding: EdgeInsets.all(24.0),
              child: Row(
                children: [
                  Checkbox(
                      activeColor: Colors.black,
                      value: taskCompleted, onChanged: onChanged),
                  Text(
                    taskName,
                    style: TextStyle(decoration: taskCompleted? TextDecoration.lineThrough: TextDecoration.none,color: Colors.white),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
