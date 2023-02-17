import 'dart:ui';

import 'package:flutter/material.dart';

import '../bloc/Cubit_Home_Layout.dart';

// Here a variable is received from the value of Map in order to display the data
Widget buildTaskItem(Map model , context)=>Dismissible(

  // Here the task id is sent to the delete method to delete the task
    key: Key(model['id'].toString()),
    onDismissed: (direction){
      AppCubit.get(context).deleteData(id: model['id']);
    },
    child:  Padding(
  padding: const EdgeInsets.all(20),
  child: Row(
    children: [
      CircleAvatar(
        radius: 42,
        backgroundColor: Colors.black54,
        child: Text("${model['time']}" , style: TextStyle(
          color: Colors.white
        ),),
      ),
      SizedBox(width: 20,),
      Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

        Text("${model['title']}", style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,

            ),),
  Text("${model['date']}", style: TextStyle(
                color: Colors.grey

            ),),
          ],
        ),
      ),
      SizedBox(width: 20,),
      IconButton(onPressed: () {
        // Here the value of (a) is changed to done to display it in the done_task_screen page

        AppCubit.get(context).updateData(a: "done", id: model['id']);
      },
        icon: Icon(Icons.check_circle , color: Colors.green[500],),),
    IconButton(onPressed: () {
      // Here the value of (a) is changed to done to display it in the archive_task_screen page

      AppCubit.get(context).updateData(a: "archive", id: model['id']);

    },
      icon: Icon(Icons.archive_outlined , color: Colors.black54,),
    ),
],
  ),
));





Widget buildTaskTitle(Map model , context)=>  Padding(

    padding: const EdgeInsets.all(20),

    child: Row(

      children: [

        CircleAvatar(

          radius: 42,

          backgroundColor: Colors.black54,

          child: Text("${model['title']}" , style: TextStyle(

              color: Colors.white

          ),),

        ),





      ],

    ),


);