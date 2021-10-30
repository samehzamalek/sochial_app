import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sochial_app/cubit/states.dart';
import 'package:sochial_app/model/comment_model.dart';
import 'package:sochial_app/model/message_model.dart';
import 'package:sochial_app/model/post_model.dart';
import 'package:sochial_app/model/user_model.dart';
import 'package:sochial_app/modules/chats.dart';
import 'package:sochial_app/modules/feeds.dart';
import 'package:sochial_app/modules/new_post.dart';
import 'package:sochial_app/modules/settings.dart';
import 'package:sochial_app/modules/users.dart';
import 'package:sochial_app/shared/constant.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(InitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  void getUserData() {
    emit(GetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      emit(GetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserErrorState());
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    const FeedsScreen(),
    const ChatsScreen(),
    NewPostScreen(),
    const UsersScreen(),
    const SettingsScreen(),
  ];
  List<String> titles = [
    'News Feed',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index) {
    if (index == 1) {
      getUsers();
    }
    if (index == 2) {
      emit(NewPostState());
    } else {
      currentIndex = index;
      emit(ChangeBottomNavState());
    }
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
    } else {
      print('Ni image selected');
      emit(ProfileImagePickedErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(CoverImagePickedSuccessState());
    } else {
      print('Ni image selected');
      emit(CoverImagePickedErrorState());
    }
  }

  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(PostImagePickedSuccessState());
    } else {
      print('Ni image selected');
      emit(PostImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(UserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(UploadProfileImageSuccessState());
        print(value);
        updateUser(name: name, phone: phone, bio: bio, image: value);
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(UserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(UploadCoverImageSuccessState());
        print(value);
        updateUser(name: name, phone: phone, bio: bio, cover: value);
      }).catchError((error) {
        emit(UploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(UploadCoverImageErrorState());
    });
  }

  // void updateUserImages({
  //   required String name,
  //   required String phone,
  //   required String bio,
  // }) {
  //   emit(UserUpdateLoadingState());
  //   if (coverImage != null) {
  //     uploadCoverImage();
  //   } else if (profileImage != null) {
  //     uploadProfileImage();
  //   } else if (coverImage != null && profileImage != null) {
  //   } else {
  //     updateUser(name: name, phone: phone, bio: bio);
  //   }
  // }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? image,
    String? cover,
  }) {
    UserModel model = UserModel(
        name: name,
        phone: phone,
        bio: bio,
        cover: cover ?? userModel!.cover,
        email: userModel!.email,
        uid: userModel!.uid,
        image: image ?? userModel!.image,
        isEmailVerified: false);
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(UserUpdateErrorState());
    });
  }

  void createNewPost({
    required String dateTime,
    required String text,
  }) {
    emit(CreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(dateTime: dateTime, text: text, postImage: value);
        // emit(UploadCoverImageSuccessState());
        print(value);
      }).catchError((error) {
        emit(CreatePostErrorState());
      });
    }).catchError((error) {
      emit(CreatePostErrorState());
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    emit(CreatePostLoadingState());
    PostModel model = PostModel(
        name: userModel!.name,
        uid: userModel!.uid,
        image: userModel!.image,
        dateTime: dateTime,
        text: text,
        postImage: postImage ?? '');
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(CreatePostSuccessState());
    }).catchError((error) {
      emit(CreatePostErrorState());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(RemovePostImagePickedState());
  }

  List<PostModel>? posts = [];
  List<String>? postsId = [];
  List<int>? likes = [];
  List<dynamic>? comment = [];

  void getPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes!.add(value.docs.length);
          postsId!.add(element.id);
          posts!.add(PostModel.fromJson(element.data()));
        }).catchError((error) {});
        // element.reference.collection('comments').get().then((value) {
        //   comment!.add(value.docs.length);
        // }).catchError((error) {});
      });
      emit(GetPostsSuccessState());
    }).catchError((error) {
      emit(GetPostsErrorState());
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uid)
        .set({
      'like': true,
    }).then((value) {
      emit(LikePostSuccessState());
    }).catchError((error) {
      emit(LikePostErrorState());
    });
  }

  List<CommentModel> comments = [];

  void commentPost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      comment!.clear();
      event.docs.forEach((element) {
        comment!.add(CommentModel.fromJson(element.data()));
        emit(CommentPostSuccessState());
      });
    });
  }

  List<UserModel>? users = [];

  void getUsers() {
    if (users!.length == 0) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uid'] != userModel!.uid) {
            users!.add(UserModel.fromJson(element.data()));
          }
        });
        emit(GetAllUsersSuccessState());
      }).catchError((error) {
        emit(GetAllUsersErrorState());
      });
    }
  }

  void sendMessage({
    required String? receiverId,
    required String? dateTime,
    required String? text,
  }) {
    MessageModel model = MessageModel(
        text: text,
        senderId: userModel!.uid,
        receiverId: receiverId,
        dateTime: dateTime);

    /// set my chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });

    /// set receiver chat

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uid)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String? receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(GetMessagesSuccessState());
    });
  }
}
