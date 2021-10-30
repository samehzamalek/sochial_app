import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:sochial_app/cubit/cubit.dart';
import 'package:sochial_app/cubit/states.dart';
import 'package:sochial_app/model/post_model.dart';
import 'package:sochial_app/modules/comment.dart';
import 'package:sochial_app/shared/constant.dart';
import 'package:sochial_app/shared/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){

        return
          SocialCubit.get(context).posts!.length > 0   ?
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5,
                  margin: const EdgeInsets.all(8),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      const Image(
                        image: NetworkImage(
                            'https://image.shutterstock.com/image-photo/female-runner-medal-celebrating-victory-600w-1760783186.jpg'),
                        fit: BoxFit.cover,
                        height: 200,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'communicate with friends',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics:const NeverScrollableScrollPhysics() ,
                  itemBuilder: (context, index) => buildPostItem(SocialCubit.get(context).posts![index],context,index),
                  itemCount: SocialCubit.get(context).posts!.length,
                  separatorBuilder: (BuildContext context, int index)=>const SizedBox(
                    height: 8,
                  ),
                ),
                const SizedBox(
                  height: 8,
                )
              ],
            ),
          ):
          const Center(child: CircularProgressIndicator());
        //   Conditional.single(context: context,
        //     conditionBuilder: SocialCubit.get(context).posts.length > 0,
        //     widgetBuilder: (context){
        //
        //     return  SingleChildScrollView(
        //         physics: const BouncingScrollPhysics(),
        //         child: Column(
        //           children: [
        //             Card(
        //               clipBehavior: Clip.antiAliasWithSaveLayer,
        //               elevation: 5,
        //               margin: const EdgeInsets.all(8),
        //               child: Stack(
        //                 alignment: AlignmentDirectional.bottomEnd,
        //                 children: [
        //                   const Image(
        //                     image: NetworkImage(
        //                         'https://image.shutterstock.com/image-photo/female-runner-medal-celebrating-victory-600w-1760783186.jpg'),
        //                     fit: BoxFit.cover,
        //                     height: 200,
        //                     width: double.infinity,
        //                   ),
        //                   Padding(
        //                     padding: const EdgeInsets.all(8.0),
        //                     child: Text(
        //                       'communicate with friends',
        //                       style: Theme.of(context)
        //                           .textTheme
        //                           .subtitle1!
        //                           .copyWith(color: Colors.white),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             ListView.separated(
        //               shrinkWrap: true,
        //               physics:const NeverScrollableScrollPhysics() ,
        //               itemBuilder: (context, index) => buildPostItem(context),
        //               itemCount: 10,
        //               separatorBuilder: (BuildContext context, int index)=>const SizedBox(
        //                 height: 8,
        //               ),
        //             ),
        //             const SizedBox(
        //               height: 8,
        //             )
        //           ],
        //         ),
        //       );
        //     },
        //     fallbackBuilder: (context)=>const Center(child: CircularProgressIndicator())
        // );
      },


    );
  }

  Widget buildPostItem(PostModel model,context,index) => Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                  CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                      '${model.image}'),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children:   [
                          Text('${model.name}'),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 16,
                          )
                        ],
                      ),
                      Text(
                        '${model.dateTime}',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
            ),
              Text(
              ' ${model.text}',
              style: const TextStyle(height: 1.2),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 5),
              child: Container(
                width: double.infinity,
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 6),
                      child: Container(
                        height: 20,
                        child: MaterialButton(
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: Text(
                            '#software',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 6),
                      child: Container(
                        height: 20,
                        child: MaterialButton(
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: Text(
                            '#software',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 6),
                      child: Container(
                        height: 20,
                        child: MaterialButton(
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: Text(
                            '#software',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if(model.postImage != '')
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 15.0),
              child: Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      image:   DecorationImage(
                        image: NetworkImage(
                            '${model.postImage}'),
                        fit: BoxFit.cover,
                      ))),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: [
                            const Icon(
                              IconBroken.Heart,
                              size: 16,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${SocialCubit.get(context).likes![index]}',
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                      ),
                      onTap: () {

                      },
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              IconBroken.Chat,
                              size: 16,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '0 comment',
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Row(
                      children: [
                          CircleAvatar(
                          radius: 18,
                          backgroundImage: NetworkImage(
                              '${SocialCubit.get(context).userModel!.image}'),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          'write a comment ...',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return CommentScreen();
                      }));
                     // navigateTo(context,CommentScreen());
                    },
                  ),
                ),
                InkWell(
                  child: Row(
                    children: [
                      const Icon(
                        IconBroken.Heart,
                        size: 16,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'like',
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                  onTap: () {
                    SocialCubit.get(context).likePost(SocialCubit.get(context).postsId![index]);
                  },
                )
              ],
            )
          ],
        ),
      ));
}
