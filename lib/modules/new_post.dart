import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sochial_app/cubit/cubit.dart';
import 'package:sochial_app/cubit/states.dart';
import 'package:sochial_app/shared/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  NewPostScreen({Key? key}) : super(key: key);
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(IconBroken.Arrow___Left_2),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text('Create Post'),
            actions: [
              TextButton(
                  onPressed: () {
                    var now = DateTime.now();
                    if (SocialCubit.get(context).postImage == null) {
                      SocialCubit.get(context).createPost(
                          dateTime: now.toString(), text: textController.text);
                    } else {
                      SocialCubit.get(context).createNewPost(
                          dateTime: now.toString(), text: textController.text);
                    }
                  },
                  child: const Text('POST')),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if (state is CreatePostLoadingState)
                    const LinearProgressIndicator(),
                  if (state is CreatePostLoadingState)
                    const SizedBox(
                      height: 10.0,
                    ),
                  Row(
                    children: const [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                            'https://image.shutterstock.com/image-photo/professional-female-soccer-players-celebrating-600w-1797492769.jpg'),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(child: Text('sameh ali')),
                    ],
                  ),
                  TextFormField(
                      maxLines: 6,
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: ' what is on your mind ...',
                      border: InputBorder.none,
                    ),
                  ),
                  if(SocialCubit.get(context).postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                          height: 490,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius:   BorderRadius.circular(4.0
                                  ),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:FileImage(SocialCubit.get(context).postImage!)

                              ))),
                      IconButton(
                          onPressed: () {
                            SocialCubit.get(context).removePostImage();
                          },
                          icon: const CircleAvatar(
                              radius: 20.0,
                              child: Icon(
                                Icons.close,
                                size: 18,
                              ))),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                            onPressed: () {
                              SocialCubit.get(context).getPostImage();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(IconBroken.Image),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text('add photo')
                              ],
                            )),
                      ),
                      Expanded(
                          child: TextButton(
                              onPressed: () {}, child: const Text('# tags'))),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
