import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/Cubit_Home_Layout.dart';
import '../bloc/States_Home_Layout.dart';
import '../modules/component.dart';
class ArchivedTasksScreen extends StatelessWidget {
  const ArchivedTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppState>(

      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {

        var tasks =AppCubit.get(context).archiveTasks;

        return   ListView.separated
          (itemBuilder: (context,index)=>
        ///
        buildTaskItem(tasks[index],context),
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
