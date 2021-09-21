import 'dart:async';
import 'timerModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountDownTimer {
  int work = 30;
  int shortBreak = 5;
  int longBreak = 20;

  double _radius = 1;
  bool _isActive = true;
  Duration _time;
  Duration _fullTime;

  void startWork() async {
    await readSettings();
    this._isActive = true;
    _time = Duration(minutes: this.work, seconds: 0);
    _fullTime = _time;
  }

  void startBreak(bool isShort) async {
    await readSettings();
    this._isActive = true;
    _time = Duration(minutes: (isShort) ? shortBreak : longBreak, seconds: 0);
    _fullTime = _time;
  }

  void startTimer() {
    if (_time.inSeconds > 0) {
      this._isActive = true;
    }
  }

  Future readSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    work = prefs.getInt('workTime') == null ? work : prefs.getInt('workTime');

    shortBreak = prefs.getInt('shortBreak') == null
        ? shortBreak
        : prefs.getInt('shortBreak');

    longBreak = prefs.getInt('longBreak') == null
        ? longBreak
        : prefs.getInt('longBreak');
  }

  void stopTimer() {
    this._isActive = false;
  }

  String returnTime(Duration t) {
    String minutes = (t.inMinutes < 10)
        ? '0' + t.inMinutes.toString()
        : t.inMinutes.toString();
    int numSeconds = t.inSeconds - (t.inMinutes * 60);
    String seconds =
        (numSeconds < 10) ? '0' + numSeconds.toString() : numSeconds.toString();
    String formattedTime = minutes + ":" + seconds;
    return formattedTime;
  }

  Stream<TimerModel> stream() async* {
    yield* Stream.periodic(
      Duration(seconds: 1),
      (int a) {
        // print(a);
        String time;
        if (this._isActive) {
          _time = _time - Duration(seconds: 1);
          _radius = _time.inSeconds / _fullTime.inSeconds;
          if (_time.inSeconds <= 0) {
            _isActive = false;
          }
        }
        time = returnTime(_time);
        return TimerModel(timer: time, percentage: _radius);
      },
    );
  }
}
