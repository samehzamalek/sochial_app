import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sochial_app/cubit/login/states.dart';

class LoginCubit extends Cubit <LoginStates>{
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context)=>BlocProvider.of(context);
  bool showPassword = false;
  IconData suffixIcon = Icons.visibility;
  void changeSuffixIcon(context){
    showPassword =! showPassword;
    if(showPassword) {
      suffixIcon = Icons.visibility_off;
    } else {
      suffixIcon = Icons.visibility;
    }
    emit(ChangeSuffixIconState());
  }
  void userLogin ({
  required String email,
  required String password,
}){
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value)
    {
  print(value.user!.email);
  print(value.user!.uid);

  emit(LoginSuccessState(value.user!.uid));
    }).catchError((error){
      emit(LoginErrorState(error.toString()));
    });


  }


}