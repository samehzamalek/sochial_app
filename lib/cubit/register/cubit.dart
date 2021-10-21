import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sochial_app/cubit/register/states.dart';
import 'package:sochial_app/model/user_model.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  bool showPassword = false;
  IconData suffixIcon = Icons.visibility;

  void changeSuffixIcon(context) {
    showPassword = !showPassword;
    if (showPassword) {
      suffixIcon = Icons.visibility_off;
    } else {
      suffixIcon = Icons.visibility;
    }
    emit(ChangeSuffixState());
  }

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCreate(name: name, email: email, phone: phone, uid: value.user!.uid);
    }).catchError((error) {
      emit(RegisterErrorState());
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uid,
  }) {
    UserModel model = UserModel(
        name: name,
        email: email,
        phone: phone,
        uid: uid,
        bio: 'write you bio ...',
        cover:
            'https://image.shutterstock.com/image-photo/two-american-woman-athletes-giving-600w-1797492772.jpg',
        image:
            'https://image.shutterstock.com/image-photo/two-american-woman-athletes-giving-600w-1797492772.jpg',
        isEmailVerified: false);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(model.toMap())
        .then((value) {
      emit(RegisterCreateUserSuccessState());
    }).catchError((error) {
      emit(RegisterCreateUserErrorState(error.toString()));
    });
  }
}
