// ignore_for_file: avoid_types_as_parameter_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'states.dart';


class ConterCubit extends Cubit<ConterStates>{
  ConterCubit() :super(CounterInitialStates());



  static ConterCubit get(context)
  {
  return  BlocProvider.of(context);
  }

  int counter=1;

  void minus(){
    counter--;
    emit(CounterMinusStates());

  }

  void plus(){
    counter++;
    emit(CounterPlusStates());

  }
}
