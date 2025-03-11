

import 'dart:async';

import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});


  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  _navegaLogin() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("doc/images/fundo.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  startTimer() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, _navegaLogin);
  }
}