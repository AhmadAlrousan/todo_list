


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolist/BottomNavigationBarItem/Archived_tasks_screen.dart';
import 'package:todolist/BottomNavigationBarItem/Done_tasks_screen.dart';
import 'package:todolist/BottomNavigationBarItem/new_tasks_screen.dart';
import 'package:todolist/BottomNavigationBarItem/title_tasks_Screen.dart';

import 'package:todolist/modules/constants.dart';

import 'States_Home_Layout.dart';

// لم افهم دور ال Cubit بالتحديد
class AppCubit extends Cubit<AppState>{
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int i = 0;

  // Define the pages to display in BottomNavigationBarItem
  List<Widget> screen = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
    TitleTasksScreen(),
  ];
  List<String> title = [
    "NewTasksScreen",
    "DoneTasksScreen",
    "ArchivedTasksScreen",
    "TitleTasksScreen",
  ];

  // Define three list of Map according to the value of (a) if it is new, done or archive

  List<Map> newTasks =[];

  List<Map> doneTasks =[];

  List<Map> archiveTasks =[];


  void changeIndex(int index){

    i=index;
//Use emit when you want a new state for your bloc.
// Use add when you want your bloc to handle a new event.

    emit(AppChangeBottomState());
  }

  Database? database;

  // An local database has been created
  void createDataBase()  {

  openDatabase('todo.db1', version: 1,
        // sqflite is a local database
        // The meaning of an local database is data that exists in device 1 that does not exist in device 2
        onCreate: (database, version) {
          print("dataBase created");
          database // Here the database is built
          // The database is built only once
              .execute(
              "CREATE TABLE tasks (id INTEGER PRIMARY KEY , title TEXT , date TEXT ,"
                  " time TEXT , a TEXT )")
              .then((value) {
            print("table created");
            // Here to ensure that there is no error in the database construction process
          }).catchError((error) {
            print('Error when Creating Table${error.toString()}');
          });
        }
        , onOpen: (database) {
          getDataFromDatabase(database);
          // Here the database is opened
          print("dataBase opened");
        }).then((value) {
          database =value;
          emit(AppCreateDatabaseState());
  });
  }

   insertToDataBase({
     // Three variables are defined to save data coming from Text Form Filed
    required String title,
    required String time,
    required String date,



   }) async{
    await database?.transaction((txn) {
      txn.rawInsert(
      // Here to enter data into the Database

          'INSERT INTO tasks(title , date , time , a) VALUES("$title" , "$date" , "$time"  , "new" ) '
        // Here the data is stored in the database
      )
          .then((value) {

        print('$value insert successfully');

        emit(AppInsertDatabaseState());
        // After saving the data to the database, call data
        getDataFromDatabase(database);
      }).catchError((error) {
        print('Error ${error.toString()}');
      });
      return Future(
            () {},
      );
    });
  }



  void getDataFromDatabase(database)
  {
    // reset the values after moving the tasks from new tasks to done or archive
    newTasks=[];
    doneTasks=[];
    archiveTasks=[];

    // Here to display data from the Database
    database!.
    rawQuery('SELECT * FROM tasks').then((value)
    {
      print(value);

      // here the data is filtered according to the value of (a)
      value.forEach((element) {
       if(element['a']=='new')
         newTasks.add(element);
       else  if(element['a']=='done')
         doneTasks.add(element);
       else
         archiveTasks.add(element);

      });
      emit(AppGetDatabaseState());

    });
// Here to retrieve data from the database
  }



  void updateData({
  required String a,
    required int id,
})async{

    // here to update the data in the database but finish it
   database!.rawUpdate(
     // Here the value of (a) is modified according to its own id

      'UPDATE tasks SET a = ? WHERE id = ? ',
    ['$a' , id],
    ).then((value) {
     getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());


   });
  }

  void deleteData({
    required int id,
  })async{

    // here to modify the data in the database but finish it
    database!.rawUpdate(
      // Here the task is completely deleted by id
      'DELETE FROM tasks WHERE id = ? ',
      [id],
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());


    });
  }

  bool isBottomSheetShown = false;

  void showBottomSheetState({
  required bool isShow,

})
  {
    isBottomSheetShown=isShow;

    emit(AppShowBottomSheetState());
  }

}
















