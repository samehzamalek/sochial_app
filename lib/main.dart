import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sochial_app/cubit/cubit.dart';
import 'package:sochial_app/layout/sochial.dart';
import 'package:sochial_app/shared/bloc_observer.dart';
import 'package:sochial_app/shared/cach_helper.dart';
import 'package:sochial_app/shared/constant.dart';
import 'package:sochial_app/shared/themes.dart';
import 'modules/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        BlocProvider(create:(BuildContext context)=>SocialCubit()..getUserData())
      ],
      child: MaterialApp(
        theme: lightMode (),
        debugShowCheckedModeBanner: false,
        home: startWidget,
      ),
    );
  }
}
