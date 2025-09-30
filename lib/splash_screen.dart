import 'dart:async';

import 'package:flutter/material.dart';
import 'package:manajemen_keuangan/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Timer(const Duration(seconds: 4), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyHomePage()),
      );
    });
  }


Widget build(BuildContext context){
  return Scaffold(
    backgroundColor: Colors.green,
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/logo.png",
          width: 120,
          height: 120,
          ),
          const SizedBox(height: 30),
          const Text(
            "Manajemen Keuangan",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          const CircularProgressIndicator(
            color: Colors.white,
          )
        ],
      ),
    ),
  );
}
}