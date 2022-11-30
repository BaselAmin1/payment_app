import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:payment_app/modules/payment/ref_code.dart';
import 'package:payment_app/modules/payment/visa_card.dart';
import 'package:payment_app/shared/components/components.dart';


class ToggleScreen extends StatelessWidget {
  const ToggleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          defaultButton(function: () {
            NavigateTo(context, VisaCardScreen());
          }, text: 'Pay with card'),
          SizedBox(
            height: 40,
          ),
          defaultButton(function: () {
            NavigateTo(context, RefCodeScreen());
          }, text: 'Pay with kiosk'),
        ],
      ),
    );
  }
}