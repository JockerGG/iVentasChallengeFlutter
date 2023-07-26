import 'package:iventas_challenge/src/presentation/counter_state.dart';
import '../common/bloc/bloc.dart';

final class CounterBloc extends Bloc<CounterState> {
  CounterBloc() {
    changeState(CounterState.set(0));
  }
  
  void add() {
    changeState(CounterState.set(state.counter + 1));
  }

  void reduce() {
    changeState(CounterState.set(state.counter - 1));
  }
}