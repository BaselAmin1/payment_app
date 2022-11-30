import 'package:flutter/material.dart';
import 'package:payment_app/modules/register/register.dart';
import 'package:payment_app/shared/network/dio.dart';

void main() async {
   DioHelperPayment.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: RegisterScreen(),
    );
  }
}
