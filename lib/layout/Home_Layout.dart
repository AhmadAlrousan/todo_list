
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/modules/constants.dart';

import '../bloc/Cubit_Home_Layout.dart';
import '../bloc/States_Home_Layout.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  var scaffolodKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var aController = TextEditingController();

  @override
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDataBase(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (BuildContext context, AppState state) {
          if(state is AppInsertDatabaseState){
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffolodKey,
            appBar: AppBar(
              title: Text(cubit.title[cubit.i]),
              backgroundColor: Colors.black54,
            ),
            body: cubit.screen[cubit.i],
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              // Here the bytes are called to display in the screen
              onPressed: () {
                if (cubit.isBottomSheetShown) {
                  if (formKey.currentState!.validate()) {
                    // The value found from the Text Form Field is sent and stored in database
                    cubit.insertToDataBase(
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text,
                    );
                  }
                } else {
                  // A showBottomSheet is created, then three TextFormFields appear to enter the title,
                  // time, and date
                  scaffolodKey.currentState
                      ?.showBottomSheet(
                        (context) => Form(
                          key: formKey,
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            TextFormField(
                              decoration: InputDecoration(
                                label: Text(
                                  "Task Title",
                                ),
                                prefixIcon: Icon(Icons.title),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.8),
                                ),
                              ),
                              controller: titleController,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "is Empty";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                label: Text("Task Time"),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.8),
                                ),
                                prefixIcon: Icon(Icons.watch_later_outlined),
                              ),
                              keyboardType: TextInputType.none,
                              controller: timeController,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "is Empty";
                                }
                                return null;
                              },
                              onTap: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value) {
                                  timeController.text = value!.format(context);
                                });
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                label: Text("Task Date"),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.8),
                                ),
                                prefixIcon: Icon(Icons.date_range),
                              ),
                              keyboardType: TextInputType.none,
                              controller: dateController,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "is Empty";
                                }
                                return null;
                              },
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse("2023-05-03"),
                                ).then((value) {
                                  dateController.text =
                                      DateFormat.yMMMd().format(value!);
                                });
                              },
                            ),
                          ]),
                        ),
                      )
                      .closed
                      .then((value) {
                    cubit.showBottomSheetState(isShow: false);
                  });
                  cubit.showBottomSheetState(isShow: true);
                }
              },
              backgroundColor: Colors.black54,
            ),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: AppCubit.get(context).i,
                onTap: (index) {
                  // Bottom Navigation Bar contains three items to display Screen when clicked
                  AppCubit.get(context).changeIndex(index);
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.menu), label: "Tasks"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.check_box_sharp), label: "Done"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.archive_outlined), label: "Archived"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.title), label: "title"),
                ]),
          );
        },
      ),
    );
  }
}
