import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sochial_app/cubit/cubit.dart';
import 'package:sochial_app/layout/sochial.dart';
import 'package:sochial_app/shared/bloc_observer.dart';
import 'package:sochial_app/shared/cach_helper.dart';
import 'package:sochial_app/shared/constant.dart';
import 'package:sochial_app/shared/themes.dart';
import 'modules/login.dart';

Future <void>firebaseMessagingBackgroundHandler(RemoteMessage message)async {
  print('on background message ');
  print(message.data.toString());
  showToast(state:ToastStates.SUCCESS,msg:'on background message' );
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
    var token= await FirebaseMessaging.instance.getToken();
    print(token);
    FirebaseMessaging.onMessage.listen((event) {
      print('on message');
      print(event.data.toString());
      showToast(state:ToastStates.SUCCESS,msg:'on message' );
    });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('on message opened app');
    print(event.data.toString());
    showToast(state:ToastStates.SUCCESS,msg:'on message opened app' );
  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  Widget widget;
   uId =CacheHelper.getData('uId');
  if(uId != null)
  {
    widget=const SocialLayout();
  }else{
    widget=LoginScreen();
  }
  runApp(  MyApp(
    startWidget:widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;
    MyApp({Key? key, this.startWidget}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:(BuildContext context)=>SocialCubit()..getUserData()..getPosts() )
      ],
      child: MaterialApp(
        theme: lightMode (),
        debugShowCheckedModeBanner: false,
        home: startWidget,
      ),
    );
  }
}
