import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:pin_app_challenge_post_sdk/pin_app_challenge_post_sdk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Comment>? _comments;
  final _plugin = PinAppChallengePostSdk();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    List<Comment>? comments;

    try {
      comments = await _plugin.getComments(2);
    } on PlatformException {
      comments = null;
    }

    if (!mounted) return;

    setState(() {
      _comments = comments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: ListView.builder(
          itemCount: _comments?.length ?? 0,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_comments![index].name),
              subtitle: Text(_comments![index].email),
              leading: Text(_comments![index].id.toString()),
              trailing: Text(_comments![index].postId.toString()),
            );
          },
        ),
      ),
    );
  }
}
