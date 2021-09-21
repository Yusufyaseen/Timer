import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'settings.dart';
import 'package:percent_indicator/percent_indicator.dart';
// import 'package:audioplayers/audio_cache.dart';
import 'timerModel.dart';
import 'timer.dart';
import 'Widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(Timer());
}

class Timer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      title: "Timer",
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: TimerHomePage(),
    );
  }
}

class TimerHomePage extends StatelessWidget {
  // var player = AudioCache();
  final CountDownTimer timer = CountDownTimer();
  final double defaultPadding = 5.0;
  void goToSettings(BuildContext ctx) {
    Navigator.push(
      ctx,
      MaterialPageRoute(builder: (ctx) => SettingsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<PopupMenuItem> menuItems = [];
    menuItems.add(
      PopupMenuItem(
        value: 'Settings',
        child: Text('Settings'),
      ),
    );

    timer.startWork();
    return Scaffold(
      appBar: AppBar(
        title: Text("Timer For Your Life."),
        actions: [
          PopupMenuButton(
            tooltip: 'Update Settings',
            icon: Icon(Icons.settings),
            itemBuilder: (ctx) => menuItems.toList(),
            onSelected: (s) {
              if (s == "Settings") goToSettings(context);
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double availableWidth = constraints.maxWidth;
          return Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ProductivityButton(
                        color: Color(0xff009688),
                        text: "Work",
                        onPressed: () => timer.startWork(),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ProductivityButton(
                        color: Color(0xff607D8B),
                        text: "Short Break",
                        onPressed: () => timer.startBreak(true),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ProductivityButton(
                        color: Color(0xff455A64),
                        text: "Long Break",
                        onPressed: () => timer.startBreak(false),
                      ),
                    ),
                  ],
                ),
                StreamBuilder(
                  initialData: '00:00',
                  stream: timer.stream(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    TimerModel timer =
                        (snapshot.connectionState == ConnectionState.waiting)
                            ? TimerModel(timer: '00:00', percentage: 1)
                            : snapshot.data;
                    // if (timer.timer == '00:00') {
                    //   player.play('clap.mp3');
                    // }
                    return Expanded(
                      child: CircularPercentIndicator(
                        radius: availableWidth / 2,
                        lineWidth: 8.0,
                        backgroundWidth: 5,
                        percent: timer.percentage,
                        center: Text(timer.timer,
                            style: Theme.of(context).textTheme.headline4),
                        progressColor: Color(0xff009688),
                        circularStrokeCap: CircularStrokeCap.round,
                      ),
                    );
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: ProductivityButton(
                        color: Color(0xff212121),
                        text: 'Stop',
                        onPressed: () => timer.stopTimer(),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ProductivityButton(
                        color: Color(0xff009688),
                        text: 'Restart',
                        onPressed: () => timer.startTimer(),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
