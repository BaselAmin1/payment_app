import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_app/modules/payment/cubit/cubit.dart';
import 'package:payment_app/modules/payment/cubit/states.dart';
import 'package:payment_app/modules/payment/toggle_screen.dart';
import 'package:payment_app/shared/components/components.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var priceController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentCubit(),
      child:
          BlocConsumer<PaymentCubit, PaymentStates>(
          listener: (context, state) {
        if (state is getFirstTokenLoadingState) {}
        if (state is getFirstTokenSuccessState) {}
        if (state is getFirstTokenErrorState) {}
        if (state is getRefCodeSuccessState) {
          NavigateTo(context, ToggleScreen());
        }
      }, builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: const Text('Payment'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  defaultFormField(
                    controller: firstNameController,
                    type: TextInputType.name,
                    validate: (text) {},
                    label: 'First name',
                    prefix: Icons.person,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                    controller: lastNameController,
                    type: TextInputType.name,
                    validate: (text) {},
                    label: 'Last name',
                    prefix: Icons.person,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validate: (text) {},
                    label: 'Email',
                    prefix: Icons.email,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (text) {},
                    label: 'phone',
                    prefix: Icons.phone,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                    controller: priceController,
                    type: TextInputType.number,
                    validate: (text) {},
                    label: 'Amount',
                    prefix: Icons.money,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                    function: () {
                      if (formkey.currentState!.validate()) {
                        PaymentCubit.get(context).getFirstToken(
                          priceController.text,
                          firstNameController.text,
                          lastNameController.text,
                          emailController.text,
                          phoneController.text,
                        );
                      }
                    },
                    text: 'GO TO PAY',
                    radius: 12,
                    width: 160,
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
