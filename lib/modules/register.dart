import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sochial_app/cubit/register/cubit.dart';
import 'package:sochial_app/cubit/register/states.dart';
import 'package:sochial_app/layout/sochial.dart';
import 'package:sochial_app/shared/component.dart';
import 'package:sochial_app/shared/constant.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  var registerKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if(state is RegisterCreateUserSuccessState)
            {
              navigateAndKill(context,const SocialLayout());
            }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Form(
                  key: registerKey,
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        const Text(
                          'Create a Sochial account',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                            context: context,
                            controller: name,
                            label: 'Name',
                            prefix: Icons.person,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Name field is required';
                              }
                            }),
                        const SizedBox(
                          height: 40,
                        ),
                        defaultFormField(
                            context: context,
                            controller: phone,
                            label: 'Phone',
                            keyboardType: TextInputType.phone,
                            prefix: Icons.phone,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Phone field is required';
                              }
                            }),
                        const SizedBox(
                          height: 40,
                        ),
                        defaultFormField(
                            context: context,
                            controller: email,
                            keyboardType: TextInputType.emailAddress,
                            label: 'Email Address',
                            prefix: Icons.email,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Email Address must be filled';
                              }
                            }),
                        const SizedBox(
                          height: 40,
                        ),
                        defaultFormField(
                            context: context,
                            controller: password,
                            label: 'Password',
                            prefix: Icons.lock,
                            isPassword:
                            RegisterCubit
                                .get(context)
                                .showPassword ? false : true,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Password must be filled';
                              }
                            },
                            onSubmit: (value) {},
                            suffix: RegisterCubit
                                .get(context)
                                .suffixIcon,
                            suffixPressed: () {
                              RegisterCubit.get(context).changeSuffixIcon(
                                  context);
                            }),
                        const SizedBox(
                          height: 40,
                        ),
                        state is RegisterLoadingState
                            ? const Center(child: CircularProgressIndicator())
                            : defaultButton(
                            onTap: () {
                              if (registerKey.currentState!.validate()) {
                                RegisterCubit.get(context).userRegister(
                                    name:name.text ,
                                    email: email.text,
                                    password: password.text,
                                    phone: phone.text);
                              }
                            },
                            text: 'Sign Up'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },


      ),
    );
  }
}
