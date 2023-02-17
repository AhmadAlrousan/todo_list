import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/Cubit_Home_Layout.dart';
import 'package:todolist/bloc/States_Home_Layout.dart';
import 'package:todolist/modules/component.dart';


class TitleTasksScreen extends StatelessWidget {
  const TitleTasksScreen({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppState>(

      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {

        var tasks =AppCubit.get(context).newTasks;

        return   ListView.separated
          (itemBuilder: (context,index)=>
        ///
        buildTaskTitle(tasks[index],context),
            separatorBuilder: (context , index)=>
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[300],
                ),

            itemCount: tasks.length);
      },

    );
  }
}
