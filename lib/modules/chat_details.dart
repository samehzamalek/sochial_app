import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:sochial_app/cubit/cubit.dart';
import 'package:sochial_app/cubit/states.dart';
import 'package:sochial_app/model/message_model.dart';
import 'package:sochial_app/model/user_model.dart';
import 'package:sochial_app/shared/constant.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel? userModel;

  ChatDetailsScreen({this.userModel});

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext? context) {
        SocialCubit.get(context).getMessages(receiverId: userModel!.uid);
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                  titleSpacing: 0,
                  title: Row(
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage('${userModel!.image}'),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text('${userModel!.name}')
                    ],
                  ),
                ),
                body: SocialCubit.get(context).messages.length > 0
                    ? Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    var message=SocialCubit.get(context).messages[index];
                                    if(SocialCubit.get(context).userModel!.uid == message.senderId)
                                      {
                                        return buildMyMessage(message);
                                      }
                                    return buildMessage(message);
                                  },
                                  separatorBuilder: (context, index) => const SizedBox(
                                        height: 15.0,
                                      ),
                                  itemCount:
                                      SocialCubit.get(context).messages.length),
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: TextFormField(
                                  controller: messageController,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(60),
                                          borderSide: const BorderSide(
                                              style: BorderStyle.none)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(60),
                                          borderSide: const BorderSide(
                                              style: BorderStyle.none)),
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            SocialCubit.get(context)
                                                .sendMessage(
                                                    receiverId: userModel!.uid,
                                                    dateTime: DateTime.now()
                                                        .toString(),
                                                    text:
                                                        messageController.text);
                                          },
                                          icon: const Icon(
                                            Icons.send,
                                            color: Colors.blue,
                                          )),
                                      hintText: 'Write a message...'),
                                ))
                              ],
                            )
                          ],
                        ),
                      )
                    : const Center(child: CircularProgressIndicator())
                // Conditional.single(context: context,
                //     conditionBuilder
                //     : SocialCubit.get(context).messages.length > 0 ,
                //     widgetBuilder: (context) =>
                //         Padding(
                //           padding: const EdgeInsets.all(20.0),
                //           child: Column(
                //             children: [
                //               buildMessage(),
                //               buildMyMessage(),
                //               const Spacer(),
                //               Row(
                //                 children: [
                //                   Expanded(
                //                       child: TextFormField(
                //                         controller: messageController,
                //                         decoration: InputDecoration(
                //                             enabledBorder: OutlineInputBorder(
                //                                 borderRadius: BorderRadius
                //                                     .circular(60),
                //                                 borderSide: const BorderSide(
                //                                     style: BorderStyle.none)),
                //                             focusedBorder: OutlineInputBorder(
                //                                 borderRadius: BorderRadius
                //                                     .circular(60),
                //                                 borderSide: const BorderSide(
                //                                     style: BorderStyle.none)),
                //                             errorBorder: InputBorder.none,
                //                             disabledBorder: InputBorder.none,
                //                             filled: true,
                //                             fillColor: Colors.grey[200],
                //                             suffixIcon: IconButton(
                //                                 onPressed: () {
                //                                   SocialCubit.get(context)
                //                                       .sendMessage(
                //                                       receiverId: userModel!
                //                                           .uid,
                //                                       dateTime: DateTime.now()
                //                                           .toString(),
                //                                       text: messageController
                //                                           .text);
                //                                 },
                //                                 icon: const Icon(Icons.send,
                //                                   color: Colors.blue,)),
                //                             hintText: 'Write a message...'),
                //                       )
                //                   )
                //                 ],
                //               )
                //             ],
                //           ),
                //         ),
                //     fallbackBuilder:(context)=>const Center(child: CircularProgressIndicator()))

                );
          },
        );
      },
    );
  }

  Widget buildMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(10.0),
                  topEnd: Radius.circular(10.0),
                  topStart: Radius.circular(10.0),
                )),
            child:   Text('${model.text}')),
      );

  Widget buildMyMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            decoration: BoxDecoration(
                color: defaultColor.withOpacity(.2),
                borderRadius: const BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(10.0),
                  topEnd: Radius.circular(10.0),
                  topStart: Radius.circular(10.0),
                )),
            child:   Text('${model.text}')),
      );
}
