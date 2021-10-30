import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sochial_app/cubit/cubit.dart';
import 'package:sochial_app/cubit/states.dart';
import 'package:sochial_app/model/user_model.dart';
import 'package:sochial_app/modules/chat_details.dart';
import 'package:sochial_app/shared/constant.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        return  SocialCubit.get(context).users!.length >0?


          ListView.separated(
          physics:const BouncingScrollPhysics() ,
            itemBuilder: (context, index) {
              return buildChatItem(SocialCubit.get(context).users![index],context);
            },
            separatorBuilder: (context, index) => Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey[300],
            ),
            itemCount: SocialCubit.get(context).users!.length):
           const Center(child: CircularProgressIndicator());
      },

    );
  }

  Widget buildChatItem(UserModel model,context) => InkWell(
    onTap: (){
      navigateTo(context, ChatDetailsScreen(userModel: model,));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
            children:   [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                    '${model.image}'),
              ),
              const SizedBox(
                width: 15,
              ),
              Text('${model.name}'),
            ],
          ),
    ),
  );
}
