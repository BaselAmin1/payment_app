// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class PaymentStates {}

class getFirstTokenLoadingState extends PaymentStates {}

class getFirstTokenSuccessState extends PaymentStates {}

class getFirstTokenErrorState extends PaymentStates {
  String error;
  getFirstTokenErrorState({
    required this.error,
  });
}

class getOrderIdLoadingState extends PaymentStates {}

class getOrderIdSuccessState extends PaymentStates {}

class getOrderIdErrorState extends PaymentStates {}

class getFinalTokenLoadingState extends PaymentStates {}

class getFinalTokenSuccessState extends PaymentStates {}

class getFinalTokenErrorState extends PaymentStates {}

class getFinalTokenKIOSKLoadingState extends PaymentStates {}

class getFinalTokenKIOSKSuccessState extends PaymentStates {}

class getFinalTokenKIOSKErrorState extends PaymentStates {}

class getRefCodeLoadingState extends PaymentStates {}

class getRefCodeSuccessState extends PaymentStates {}

class getRefCodeErrorState extends PaymentStates {}
