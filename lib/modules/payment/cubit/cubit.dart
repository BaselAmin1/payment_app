import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_app/models/first_token.dart';
import 'package:payment_app/models/order_id_model.dart';
import 'package:payment_app/modules/payment/cubit/states.dart';
import 'package:payment_app/shared/components/constants.dart';
import 'package:payment_app/shared/network/dio.dart';

class PaymentCubit extends Cubit<PaymentStates> {
  PaymentCubit() : super(getFirstTokenLoadingState());

  static PaymentCubit get(context) => BlocProvider.of(context);
  FirstToken? firstToken;

  Future getFirstToken(
    String price,
    String firstName,
    String lastName,
    String email,
    String phone,
  ) async {
    DioHelperPayment.postData(url: 'auth/tokens', data: {
      'api_key': paymobApiKey,
    }).then((value) {
      paymobToken = value.data['token'];
      print('First Token : ${paymobToken}');
      getOrderId(firstName, lastName, email, phone, price);
      emit(getFirstTokenSuccessState());
    }).catchError((error) {
      emit(getFirstTokenErrorState(error: error));
    });
  }

  Future getOrderId(String firstName, String lastName, String email,
      String phone, String price) async {
    emit(getOrderIdLoadingState());
    await DioHelperPayment.postData(url: 'ecommerce/orders', data: {
      "auth_token": paymobToken,
      "delivery_needed": "false",
      "amount_cents": price,
      "currency": "EGP",
      "items": []
    }).then((value) {
      paymobOrderId = value.data['id'].toString();
      print('order id : $paymobOrderId');
      emit(getOrderIdSuccessState());
      getFinalTokenCard(firstName, lastName, email, phone, price);
      getFinalTokenKiosk(firstName, lastName, email, phone, price);
    }).catchError((error) {
      print(error.toString());
      emit(getOrderIdErrorState());
    });
  }

  Future getFinalTokenCard(String firstName, String lastName, String email,
      String phone, String amount) async {
    emit(getFinalTokenLoadingState());
    await DioHelperPayment.postData(url: 'acceptance/payment_keys', data: {
      "auth_token": paymobToken,
      "amount_cents": amount,
      "expiration": 3600,
      "order_id": paymobOrderId,
      "billing_data": {
        "apartment": "NA",
        "email": email,
        "floor": "NA",
        "first_name": firstName,
        "street": "NA",
        "building": "NA",
        "phone_number": phone,
        "shipping_method": "NA",
        "postal_code": "NA",
        "city": "NA",
        "country": "NA",
        "last_name": lastName,
        "state": "NA"
      },
      "currency": "EGP",
      "integration_id": integrationIdCard
    }).then((value) {
      finalTokenCard = value.data['token'];
      print('final token card $finalTokenCard');
      emit(getFinalTokenSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(getFinalTokenErrorState());
    });
  }

  Future getFinalTokenKiosk(String firstName, String lastName, String email,
      String phone, String amount) async {
    emit(getFinalTokenKIOSKLoadingState());
    await DioHelperPayment.postData(url: 'acceptance/payment_keys', data: {
      "auth_token": paymobToken,
      "amount_cents": amount,
      "expiration": 3600,
      "order_id": paymobOrderId,
      "billing_data": {
        "apartment": "NA",
        "email": email,
        "floor": "NA",
        "first_name": firstName,
        "street": "NA",
        "building": "NA",
        "phone_number": phone,
        "shipping_method": "NA",
        "postal_code": "NA",
        "city": "NA",
        "country": "NA",
        "last_name": lastName,
        "state": "NA"
      },
      "currency": "EGP",
      "integration_id": integrationIdKiosk
    }).then((value) {
      finalTokenKiosk = value.data['token'];
      print('final token kiosk $finalTokenKiosk');
      emit(getFinalTokenKIOSKSuccessState());
      getReferenceCode();
    }).catchError((error) {
      print(error.toString());
      emit(getFinalTokenKIOSKErrorState());
    });
  }

  Future getReferenceCode() async {
    emit(getRefCodeLoadingState());
    await DioHelperPayment.postData(url: 'acceptance/payments/pay', data: {
      "source": {"identifier": "AGGREGATOR", "subtype": "AGGREGATOR"},
      "payment_token": finalTokenKiosk
    }).then((value) {
      referenceCode = value.data['id'].toString();
      print('REF code $referenceCode');
      emit(getRefCodeSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(getRefCodeErrorState());
    });
  }
}
