import 'dart:async';
import 'package:rxdart/rxdart.dart';

import '../../../core/bloc_provider.dart';

class TimerBloc extends BlocBase{
  final StreamController<int> _timerController =
      StreamController<int>.broadcast();

  BehaviorSubject<bool> timerStoppedSubject = BehaviorSubject.seeded(false);

  Stream<int> get timerStream => _timerController.stream;
  Timer _timer = Timer(const Duration(seconds: 1), () {});

  void decrementTimer(int seconds) {
    timerStoppedSubject.sink.add(false);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        seconds--;
        _timerController.add(seconds);
      } else {
        stopTimer();
      }
    });
  }

  void incrementTimer(int seconds) {
    timerStoppedSubject.sink.add(false);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        seconds--;
        _timerController.add(seconds);
      } else {
        stopTimer();
      }
    });
  }

  void resetTimer() {
    _timer.cancel();
    timerStoppedSubject.sink.add(false);
  }

  void stopTimer() {
    _timer.cancel();
    timerStoppedSubject.sink.add(true);
  }

  @override
  void dispose() {
    _timer.cancel();
    timerStoppedSubject.close();
  }
}
