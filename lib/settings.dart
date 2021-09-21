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
  int updateWork;
  int updateShortBreak;
  int updateLongBreak;
  final txtWork = TextEditingController();
  final txtShort = TextEditingController();
  final txtLong = TextEditingController();
  TextStyle textStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  TextStyle inputStyle = TextStyle(fontSize: 24);
  TextField fields(dynamic c) {
    return TextField(
      controller: c,
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
      updateWork = int.parse(txtWork.text);
    });
  }

  void _updateShortBreak() {
    setState(() {
      updateShortBreak = int.parse(txtShort.text);
    });
  }

  void _updateLongBreak() {
    setState(() {
      updateLongBreak = int.parse(txtLong.text);
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
              mainAxisSpacing: 50,
              padding: EdgeInsets.all(20),
              children: [
                fields(txtWork),
                SettingsButton(Color(0xff009688), "Update Work", updateWork,
                    WORKTIME, updateSettings),
                fields(txtShort),
                SettingsButton(Color(0xff009688), "Update Short Break",
                    updateShortBreak, SHORTBREAK, updateSettings),
                fields(txtLong),
                SettingsButton(Color(0xff009688), "Update Long Break",
                    updateLongBreak, LONGBREAK, updateSettings),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
