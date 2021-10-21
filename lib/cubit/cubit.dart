import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sochial_app/cubit/states.dart';
import 'package:sochial_app/model/user_model.dart';
import 'package:sochial_app/modules/chats.dart';
import 'package:sochial_app/modules/feeds.dart';
import 'package:sochial_app/modules/new_post.dart';
import 'package:sochial_app/modules/settings.dart';
import 'package:sochial_app/modules/users.dart';
import 'package:sochial_app/shared/constant.dart';

class SocialCubit extends Cubit<SocialStates>{
  SocialCubit() : super(InitialState());
  static SocialCubit get(context)=>BlocProvider.of(context);

  UserModel? userModel;
void getUserData(){
  emit(GetUserLoadingState());
  FirebaseFirestore.instance.collection('users').doc(uId).get().then((value)
  {
    userModel=UserModel.fromJson(value.data()!);
     emit(GetUserSuccessState());
  }).catchError((error){
    print(error.toString());
    emit(GetUserErrorState());
  });
}
int currentIndex=0;
List<Widget>screens=[
  const FeedsScreen(),
  const ChatsScreen(),
  const NewPostScreen(),
  const UsersScreen(),
  const SettingsScreen(),
];
List<String>titles=[
  'News Feed',
  'Chats',
  'Post',
  'Users',
  'Settings',
];

void changeBottomNav(int index){

  if(index == 2) {
    emit(NewPostState());
  }
  else {
    currentIndex=index;
    emit(ChangeBottomNavState());
  }
}
   File? profileImage;
  var picker= ImagePicker();
  Future<void> getProfileImage()async{
    final pickedFile=await picker.getImage(source: ImageSource.gallery);
    if(pickedFile !=null)
    {
      profileImage=File(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
    }else{
      print('Ni image selected');
      emit(ProfileImagePickedErrorState());

    }

  }

}