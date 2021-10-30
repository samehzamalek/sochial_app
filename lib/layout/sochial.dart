import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sochial_app/cubit/cubit.dart';
import 'package:sochial_app/cubit/states.dart';
import 'package:sochial_app/modules/new_post.dart';
import 'package:sochial_app/shared/constant.dart';
import 'package:sochial_app/shared/icon_broken.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if(state is NewPostState)
          {
            navigateTo(context,  NewPostScreen());
           }
      },
      builder: (context, state) {
        var cubit=SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title:   Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(onPressed: (){}, icon: const Icon(IconBroken.Notification)),
              IconButton(onPressed: (){}, icon: const Icon(IconBroken.Search)),
            ],
          ),
          body:cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottomNav(index);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(IconBroken.Home),label:'Home' ),
              BottomNavigationBarItem(icon: Icon(IconBroken.Chat),label: 'Chats'),
              BottomNavigationBarItem(icon: Icon(IconBroken.Paper_Upload),label: 'Post'),
              BottomNavigationBarItem(icon: Icon(IconBroken.Location),label: 'Users'),
              BottomNavigationBarItem(icon: Icon(IconBroken.Setting),label: 'Settings'),
            ],

          ),
          // Conditional.single(
          //   context: context,
          //   conditionBuilder: (BuildContext context) =>
          //       SocialCubit.get(context).model != null,
          //   widgetBuilder: (BuildContext context) {
          //    // var model = SocialCubit.get(context).model;
          //     return Column(
          //       children: [
          //         // if (!FirebaseAuth.instance.currentUser!.emailVerified)
          //         //   Container(
          //         //     color: Colors.amber.withOpacity(.6),
          //         //     child: Padding(
          //         //       padding: const EdgeInsets.symmetric(horizontal: 20),
          //         //       child: Row(
          //         //         children: [
          //         //           const Icon(Icons.info_outline),
          //         //           const SizedBox(
          //         //             width: 15,
          //         //           ),
          //         //           const Expanded(
          //         //             child: Text('Please verify your email'),
          //         //           ),
          //         //           const SizedBox(
          //         //             width: 20,
          //         //           ),
          //         //           TextButton(
          //         //               onPressed: () {
          //         //                 FirebaseAuth.instance.currentUser!
          //         //                     .sendEmailVerification()
          //         //                     .then((value) {
          //         //                       showToast(msg: 'check your email',state: ToastStates.SUCCESS);
          //         //                 })
          //         //                     .catchError((error) {});
          //         //               },
          //         //               child: const Text('SEND'))
          //         //         ],
          //         //       ),
          //         //     ),
          //         //   )
          //       ],
          //     );
          //   },
          //   fallbackBuilder: (BuildContext context) =>
          //       const Center(child: CircularProgressIndicator()),
          // ),
        );
      },
    );
  }
}
