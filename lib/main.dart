import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todolist/bloc/MyBlocObserver.dart';
import 'package:todolist/layout/Home_Layout.dart';

import 'layout/counter screen.dart';

void main() {
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do list',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home:  HomeLayout(),
      routes: {
        "HomeLayout":(context)=>HomeLayout(),
      },
    );
  }
}
