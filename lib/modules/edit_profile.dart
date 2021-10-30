import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sochial_app/cubit/cubit.dart';
import 'package:sochial_app/cubit/states.dart';
import 'package:sochial_app/shared/component.dart';
import 'package:sochial_app/shared/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        nameController.text = userModel!.name!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;

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
                TextButton(
                    onPressed: () {
                      SocialCubit.get(context).updateUser(
                          name: nameController.text,
                          phone: phoneController.text,
                          bio: bioController.text);
                    },
                    child: const Text('UPDATE')),
                const SizedBox(
                  width: 15,
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (state is UserUpdateLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 10.0,
                    ),
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
                                            fit: BoxFit.cover,
                                            image: coverImage == null
                                                ? NetworkImage(
                                                    '${userModel.cover}')
                                                : FileImage(coverImage)
                                                    as ImageProvider))),
                                IconButton(
                                    onPressed: () {
                                      SocialCubit.get(context).getCoverImage();
                                    },
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
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    radius: 60.0,
                                    backgroundImage: profileImage == null
                                        ? NetworkImage('${userModel.image}')
                                        : FileImage(profileImage)
                                            as ImageProvider),
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
                    if (SocialCubit.get(context).profileImage != null ||
                        SocialCubit.get(context).coverImage != null)
                      Row(
                        children: [
                          if (SocialCubit.get(context).profileImage != null)
                            Expanded(
                                child: Column(
                              children: [
                                defaultButton(
                                    onTap: () {
                                      SocialCubit.get(context)
                                          .uploadProfileImage(
                                              name: nameController.text,
                                              phone: phoneController.text,
                                              bio: bioController.text);
                                    },
                                    text: 'upload profile'),
                                if (state is UserUpdateLoadingState)
                                  const SizedBox(
                                    height: 5,
                                  ),
                                if (state is UserUpdateLoadingState)
                                  const LinearProgressIndicator()
                              ],
                            )),
                          const SizedBox(
                            width: 5,
                          ),
                          if (SocialCubit.get(context).coverImage != null)
                            Expanded(
                                child: Column(
                              children: [
                                defaultButton(
                                    onTap: () {
                                      SocialCubit.get(context).uploadCoverImage(
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          bio: bioController.text);
                                    },
                                    text: 'upload cover'),
                                if (state is UserUpdateLoadingState)
                                  const SizedBox(
                                    height: 5,
                                  ),
                                if (state is UserUpdateLoadingState)
                                  const LinearProgressIndicator()
                              ],
                            )),
                        ],
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
                    const SizedBox(
                      height: 10,
                    ),
                    defaultFormField(
                        controller: phoneController,
                        context: context,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Phone is required';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        label: 'Phone',
                        prefix: IconBroken.Call),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
