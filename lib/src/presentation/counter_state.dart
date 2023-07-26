abstract class CounterState {
  final int counter;

  CounterState(this.counter);

  factory CounterState.set(int counter) => CounterStateImpl(counter);
}

class CounterStateImpl extends CounterState {
  CounterStateImpl(int counter): super(counter);
}