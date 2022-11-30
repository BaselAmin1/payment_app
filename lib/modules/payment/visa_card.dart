import 'dart:async';
import 'package:flutter/material.dart';
import 'package:payment_app/shared/components/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VisaCardScreen extends StatelessWidget {
  VisaCardScreen({super.key});
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    print(
        ' ezz :https://accept.paymob.com/api/acceptance/iframes/704185?payment_token=$finalTokenCard');

    return SafeArea(
      child: Scaffold(
        body: WebView(
          initialUrl:
              'https://accept.paymob.com/api/acceptance/iframes/704185?payment_token=$finalTokenCard',
          javascriptMode: JavascriptMode.unrestricted,
          onProgress: (int progress) {
            print('WebView is loading (progress : $progress%)');
          },
          javascriptChannels: <JavascriptChannel>{
            _toasterJavascriptChannel(context),
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
          backgroundColor: const Color(0x00000000),
        ),
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}

// ZXlKMGVYQWlPaUpLVjFRaUxDSmhiR2NpT2lKSVV6VXhNaUo5LmV5SnZjbVJsY2w5cFpDSTZPRE00TnpnM016Z3NJbVY0ZEhKaElqcDdmU3dpY0cxclgybHdJam9pTVRVMExqRTNPUzR4TkRNdU1UZzVJaXdpYkc5amExOXZjbVJsY2w5M2FHVnVYM0JoYVdRaU9tWmhiSE5sTENKaGJXOTFiblJmWTJWdWRITWlPakV5TXpRc0ltSnBiR3hwYm1kZlpHRjBZU0k2ZXlKbWFYSnpkRjl1WVcxbElqb2lZbUZ6Wld3aUxDSnNZWE4wWDI1aGJXVWlPaUpoYldsdUlpd2ljM1J5WldWMElqb2lUa0VpTENKaWRXbHNaR2x1WnlJNklrNUJJaXdpWm14dmIzSWlPaUpPUVNJc0ltRndZWEowYldWdWRDSTZJazVCSWl3aVkybDBlU0k2SWs1Qklpd2ljM1JoZEdVaU9pSk9RU0lzSW1OdmRXNTBjbmtpT2lKT1FTSXNJbVZ0WVdsc0lqb2lZbUZ6Wld4QVoyMWhhV3d1WTI5dElpd2ljR2h2Ym1WZmJuVnRZbVZ5SWpvaU1ERXlNelExSWl3aWNHOXpkR0ZzWDJOdlpHVWlPaUpPUVNJc0ltVjRkSEpoWDJSbGMyTnlhWEIwYVc5dUlqb2lUa0VpZlN3aVkzVnljbVZ1WTNraU9pSkZSMUFpTENKbGVIQWlPakUyTmprM09EWTJPREVzSW1sdWRHVm5jbUYwYVc5dVgybGtJam96TVRJMU9URTFMQ0p6YVc1bmJHVmZjR0Y1YldWdWRGOWhkSFJsYlhCMElqcG1ZV3h6WlN3aWRYTmxjbDlwWkNJNk1UQTNOakF6TTMwLndKWS1XSzVBejBYSmN2ZWNEY1drMDFzRnQ0UlZ3MWM1LWpSLUNVLXVEbk1sRTh1ejdJb1lPVFZCTEF3RmhZZDUzdjJaVXlIdXJJQmFoWXJDUmFIbkNR