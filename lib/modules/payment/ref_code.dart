import 'package:flutter/material.dart';
import 'package:payment_app/shared/components/constants.dart';
import 'package:payment_app/shared/style/colors.dart';

class RefCodeScreen extends StatelessWidget {
  const RefCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('go to pay'),
            SizedBox(
              height: 30,
            ),
            Card(
              elevation: 12,
              shape: Border.all(
                color: defaultColor,width: 1,
              ),
              child: Padding(padding:EdgeInsets.all(8),child: Text('$referenceCode'),),
            )
          ],
        ),
      ),
    );
  }
}