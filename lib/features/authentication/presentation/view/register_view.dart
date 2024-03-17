import 'package:ebook/core/constant.dart';
import 'package:ebook/features/authentication/presentation/manger/auth_cubit.dart';
import 'package:ebook/features/authentication/presentation/manger/auth_state.dart';
import 'package:ebook/features/authentication/presentation/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_textfield.dart';
import '../../../../core/widgets/text_style.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.center,
                child: TextWidget(
                  title: "Create Account",
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Align(
                alignment: Alignment.center,
                child: TextWidget(
                  title: "Fill your information below",
                  color: Colors.grey,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const TextWidget(
                title: 'Name',
              ),
              CustomFormTextField(
                inputType: TextInputType.name,
                controller: _name,
                color: Colors.grey.withOpacity(.1),
                validator: (String? value) {
                 if(value!.isEmpty){
 return "Name can not be empty";
                 }
                 return null;
                 
                },
              ),
              const TextWidget(
                title: 'Email address',
              ),
              CustomFormTextField(
                inputType: TextInputType.emailAddress,
                controller: _emailController,
                color: Colors.grey.withOpacity(.1),
                validator: ((String? value) {
                  if (value!.isEmpty) {
                    return ("Email cant be empty");
                  }
                  return null;
                }),
              ),
              const SizedBox(
                height: 10,
              ),
              const TextWidget(
                title: 'Password',
              ),
              CustomFormTextField(
                inputType: TextInputType.name,
                controller: _passwordController,
                color: Colors.grey.withOpacity(.1),
                validator: ((String? value) {
                  if (value!.isEmpty) {
                    return ("password is too short");
                  }
                  return null;
                }),
              ),
              BlocConsumer<EbookAuthCubit, AuthEbookState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return CustomButton(
                    buttonColor: mainColor,
                    isLoading: state is RegisterLoadingState,
                    onTap: () {  if (_formkey.currentState?.validate() ?? false) {
                      EbookAuthCubit.get(context).userRegister(
                        email: _emailController.text,
                        password: _passwordController.text,
                        name: _name.text,
                      );}
                    },
                    text: "Register",
                    textColor: Colors.white,
                  );
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have account?"),
                  TextButton(
                    onPressed: () {
                      Get.off(
                        LoginScreen(),
                      );
                    },
                    child: const Text(
                      "Sign in",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue,
                        color: Colors.blue,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
