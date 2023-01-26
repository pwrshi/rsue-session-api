import 'package:flutter/material.dart';
import 'dart:async';

import 'package:rsue_session_api/api.dart';
import 'package:rsue_session_api/rsue_session_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<GroupSchedule?> _platformVersion = [];
  final _rsueSessionApiPlugin = RsueSessionApi();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    List<GroupSchedule?> platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    var ee = await _rsueSessionApiPlugin.getAllSchedules();
    platformVersion = ee;

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: ListView(
            children: _platformVersion
                .map<Text>((e) => Text(
                    "\n\n\nГруппа ${e?.name}\n${e!.exams.map((e) => "${e?.name} + ${e?.dateTime} + ${e?.mark} + ${e?.rooms?.join('\n')} + ${e?.teachers?.join('\n')}").join("\n")}"))
                .toList()),
      ),
    );
  }
}
