import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/cubit.dart';
import 'package:todolist/bloc/states.dart';
class CounterScreen extends StatelessWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) =>  ConterCubit(),

      child: BlocConsumer<ConterCubit, ConterStates>(
        listener: ( context, state) {
          if( state is CounterMinusStates)print("MinusStates");
          if( state is CounterPlusStates)print("PlusStates");

        },

        builder: (context,  state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Counter"),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      try{
                        ConterCubit.get(context).minus();

                      }catch(e){
                        print('${e.toString()} 00000000000');
                      }
                    },
                    child: Text("Minus"),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "${ConterCubit.get(context).counter}",
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.w900),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      ConterCubit.get(context).plus();

                    },
                    child: Text("Plus"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
