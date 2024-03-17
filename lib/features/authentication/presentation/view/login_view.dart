import 'package:ebook/features/authentication/presentation/manger/auth_cubit.dart';
import 'package:ebook/features/authentication/presentation/manger/auth_state.dart';
import 'package:ebook/features/authentication/presentation/view/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../core/constant.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_textfield.dart';
import '../../../../core/widgets/text_style.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment.center,
                child: TextWidget(
                  title: "E book",
                  color: mainColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Align(
                alignment: Alignment.center,
                child: TextWidget(
                  title: "Sign in to browse books",
                  color: Colors.grey,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 20,
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
              BlocConsumer<EbookAuthCubit, AuthEbookState>(
                listener: (context, state) {
                  
                },
                builder: (context, state) {
                  return CustomFormTextField(
                    inputType: TextInputType.name,
                    controller: _passwordController,
                    obscureText:EbookAuthCubit.get(context).isPasswordShown ,
                    icon: EbookAuthCubit.get(context).suffix ,
                    color: Colors.grey.withOpacity(.1),
                    validator: ((String? value) {
                          if (value!.isEmpty) {
                            return ("password is too short");
                          }
                          return null;
                        }),
                  );
                }
              ),
              const SizedBox(
                height: 10,
              ),
              BlocConsumer<EbookAuthCubit, AuthEbookState>(
                listener: (context, state) {
                  
                },
                buildWhen:(_, state) =>
                  state is LoginLoadingState ||
                  state is LoginErrorState ||
                  state is LoginSucessState, 
                
                builder: (context, state) {
                  return CustomButton(
                    isLoading: state is LoginLoadingState ||
                        state is GetUserLoadingState,
                    buttonColor: mainColor,
                    onTap: () {
                      if (_formkey.currentState?.validate() ?? false) {
                        EbookAuthCubit.get(context).userLogin(
                            email: _emailController.text,
                            password: _passwordController.text);
                    }
                    },
                    text: "Sign in",
                    textColor: Colors.white,
                  );
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have account?"),
                  TextButton(
                    onPressed: () {
                      Get.to(
                         RegisterScreen(),
                      );
                    },
                    child: const Text(
                      "Sign up",
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
