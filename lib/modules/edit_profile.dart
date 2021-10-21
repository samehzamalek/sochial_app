import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sochial_app/cubit/cubit.dart';
import 'package:sochial_app/cubit/states.dart';
import 'package:sochial_app/shared/component.dart';
import 'package:sochial_app/shared/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        return Scaffold(
            appBar: AppBar(
              titleSpacing: 5.0,
              leading: IconButton(
                icon: const Icon(IconBroken.Arrow___Left_2),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: const Text('Edit Profile'),
              actions: [
                TextButton(onPressed: () {}, child: const Text('UPDATE')),
                const SizedBox(
                  width: 15,
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: 190,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                  height: 140,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0)),
                                      image: DecorationImage(
                                        image:
                                            NetworkImage('${userModel!.cover}'),
                                        fit: BoxFit.cover,
                                      ))),
                              IconButton(
                                  onPressed: () {},
                                  icon: const CircleAvatar(
                                      radius: 20.0,
                                      child: Icon(
                                        IconBroken.Camera,
                                        size: 18,
                                      ))),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 63.0,
                              child: CircleAvatar(
                                  backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                                  radius: 60.0,
                                  backgroundImage:
                                  profileImage == null ?
                                  NetworkImage('${userModel.image}'):FileImage(profileImage) as ImageProvider


                            ),
                            ),
                            IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getProfileImage();
                                },
                                icon: const CircleAvatar(
                                    radius: 20.0,
                                    child: Icon(
                                      IconBroken.Camera,
                                      size: 18,
                                    ))),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  defaultFormField(
                      controller: nameController,
                      context: context,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'name is required';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      label: 'Name',
                      prefix: IconBroken.User),
                  const SizedBox(
                    height: 10,
                  ),
                  defaultFormField(
                      controller: bioController,
                      context: context,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Bio is required';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      label: 'Bio',
                      prefix: IconBroken.Info_Circle),
                ],
              ),
            ));
      },
    );
  }
}
