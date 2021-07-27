import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Widgets.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Container(
        child: Settings(),
      ),
    );
  }
}

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  SharedPreferences prefs;
  static const String WORKTIME = "workTime";
  static const String SHORTBREAK = "shortBreak";
  static const String LONGBREAK = "longBreak";
  int workTime;
  int shortBreak;
  int longBreak;
  int Uwork;
  int USbreak;
  int ULbreak;
  final txtWork = TextEditingController();
  final txtShort = TextEditingController();
  final txtLong = TextEditingController();
  TextStyle textStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  TextStyle inputStyle = TextStyle(fontSize: 24);
  TextField fields(dynamic c, {bool auto = false}) {
    return TextField(
      controller: c,
      autofocus: auto,
      style: this.inputStyle,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
    );
  }

  readSettings() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getInt(WORKTIME) == null) {
      await prefs.setInt(WORKTIME, 30);
    }
    workTime = prefs.getInt(WORKTIME);
    if (prefs.getInt(SHORTBREAK) == null) {
      await prefs.setInt(SHORTBREAK, 5);
    }
    shortBreak = prefs.getInt(SHORTBREAK);

    if (prefs.getInt(LONGBREAK) == null) {
      await prefs.setInt(LONGBREAK, 20);
    }
    longBreak = prefs.getInt(LONGBREAK);
    setState(() {
      txtWork.text = workTime.toString();
      txtShort.text = shortBreak.toString();
      txtLong.text = longBreak.toString();
    });
  }

  void updateSettings(String key, int value) async {
    prefs = await SharedPreferences.getInstance();
    switch (key) {
      case WORKTIME:
        {
          if (value >= 1 && value <= 180) {
            print(value);
            await prefs.setInt(WORKTIME, value);
          }
        }
        break;
      case SHORTBREAK:
        {
          if (value >= 1 && value <= 90) {
            print(value);
            await prefs.setInt(SHORTBREAK, value);
          }
        }
        break;
      case LONGBREAK:
        {
          if (value >= 1 && value <= 180) {
            print(value);
            await prefs.setInt(LONGBREAK, value);
          }
        }
        break;
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    readSettings();
    txtWork.addListener(_updateWork);
    txtShort.addListener(_updateShortBreak);
    txtLong.addListener(_updateLongBreak);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    txtWork.dispose();
    txtShort.dispose();
    txtLong.dispose();
    super.dispose();
  }

  void _updateWork() {
    setState(() {
      Uwork = int.parse(txtWork.text);
    });
  }

  void _updateShortBreak() {
    setState(() {
      USbreak = int.parse(txtShort.text);
    });
  }

  void _updateLongBreak() {
    setState(() {
      ULbreak = int.parse(txtLong.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Text(
              "Update Your Settings",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Divider(
            indent: 50,
            endIndent: 50,
            color: Colors.blueGrey,
          ),
          Flexible(
            child: GridView.count(
              scrollDirection: Axis.vertical,
              crossAxisCount: 2,
              childAspectRatio: 3,
              crossAxisSpacing: 20,
              mainAxisSpacing: 70,
              padding: EdgeInsets.all(20),
              children: [
                fields(txtWork, auto: true),
                SettingsButton(Color(0xff009688), "Update Work", Uwork,
                    WORKTIME, updateSettings),
                fields(txtShort),
                SettingsButton(Color(0xff009688), "Update Short Break", USbreak,
                    SHORTBREAK, updateSettings),
                fields(txtLong),
                SettingsButton(Color(0xff009688), "Update Long Break", ULbreak,
                    LONGBREAK, updateSettings),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'Widgets.dart';
//
// class SettingsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Settings"),
//       ),
//       body: Container(
//         child: Settings(),
//       ),
//     );
//   }
// }
//
// class Settings extends StatefulWidget {
//   @override
//   _SettingsState createState() => _SettingsState();
// }
//
// class _SettingsState extends State<Settings> {
//   SharedPreferences prefs;
//   static const String WORKTIME = "workTime";
//   static const String SHORTBREAK = "shortBreak";
//   static const String LONGBREAK = "longBreak";
//   int workTime;
//   int shortBreak;
//   int longBreak;
//
//   final txtWork = TextEditingController();
//   final txtShort = TextEditingController();
//   final txtLong = TextEditingController();
//   TextStyle textStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
//   TextStyle inputStyle = TextStyle(fontSize: 24);
//   TextField fields(dynamic c, {bool auto = false}) {
//     return TextField(
//       controller: c,
//       autofocus: auto,
//       style: this.inputStyle,
//       textAlign: TextAlign.center,
//       keyboardType: TextInputType.number,
//     );
//   }
//
//   readSettings() async {
//     prefs = await SharedPreferences.getInstance();
//     if (prefs.getInt(WORKTIME) == null) {
//       await prefs.setInt(WORKTIME, 30);
//     }
//     workTime = prefs.getInt(WORKTIME);
//     if (shortBreak == null) {
//       await prefs.setInt(SHORTBREAK, 5);
//     }
//     shortBreak = prefs.getInt(SHORTBREAK);
//
//     if (longBreak == null) {
//       await prefs.setInt(LONGBREAK, 20);
//     }
//     longBreak = prefs.getInt(LONGBREAK);
//     setState(() {
//       txtWork.text = workTime.toString();
//       txtShort.text = shortBreak.toString();
//       txtLong.text = longBreak.toString();
//     });
//   }
//
//   void updateSettings(String key, int value) {
//     switch (key) {
//       case WORKTIME:
//         {
//           if (value >= 1 && value <= 180) {
//             workTime = value;
//             prefs.setInt(WORKTIME, workTime);
//           }
//         }
//         break;
//       case SHORTBREAK:
//         {
//           if (value >= 1 && value <= 90) {
//             shortBreak = value;
//             prefs.setInt(SHORTBREAK, shortBreak);
//             setState(() {
//               txtShort.text = shortBreak.toString();
//             });
//           }
//         }
//         break;
//       case LONGBREAK:
//         {
//           if (value >= 1 && value <= 180) {
//             longBreak = value;
//             prefs.setInt(LONGBREAK, longBreak);
//             setState(() {
//               txtLong.text = longBreak.toString();
//             });
//           }
//         }
//         break;
//     }
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     readSettings();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: GridView.count(
//         scrollDirection: Axis.vertical,
//         crossAxisCount: 2,
//         childAspectRatio: 5,
//         crossAxisSpacing: 20,
//         mainAxisSpacing: 70,
//         padding: EdgeInsets.all(20),
//         children: [
//           fields(txtWork, auto: true),
//           SettingsButton(Color(0xff009688), "Update Work",
//               int.parse(txtWork.text), WORKTIME, updateSettings),
//           fields(txtShort),
//           SettingsButton(Color(0xff009688), "Update Short Break",
//               int.parse(txtShort.text), SHORTBREAK, updateSettings),
//           fields(txtLong),
//           SettingsButton(Color(0xff009688), "Update Long Break",
//               int.parse(txtLong.text), LONGBREAK, updateSettings),
//         ],
//       ),
//     );
//   }
// }
