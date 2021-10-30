import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sochial_app/cubit/cubit.dart';
import 'package:sochial_app/cubit/states.dart';
import 'package:sochial_app/modules/edit_profile.dart';
import 'package:sochial_app/shared/constant.dart';
 import 'package:sochial_app/shared/icon_broken.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        var userModel=SocialCubit.get(context).userModel;
        return  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 220,
                child: Stack(
                  alignment:AlignmentDirectional.bottomCenter ,
                  children: [
                    Align(
                      alignment:AlignmentDirectional.topCenter ,

                      child: Container(
                          height: 180,
                          width: double.infinity,
                          decoration:   BoxDecoration(
                              borderRadius: const BorderRadius.only(topLeft:Radius.circular(4.0),topRight:Radius.circular(4.0)),
                              image: DecorationImage(
                                image: NetworkImage(
                                    '${userModel!.cover}'),
                                fit: BoxFit.cover,
                              ))),
                    ),
                    CircleAvatar(
                      radius: 63.0,
                      child:   CircleAvatar(
                        radius: 60.0,
                        backgroundImage: NetworkImage(
                            '${userModel.image}'),
                      ),
                      backgroundColor:Theme.of(context).scaffoldBackgroundColor,
                    ),

                  ],
                ),
              ),
              const SizedBox(height: 5,),
              Text('${userModel.name}',
                style:Theme.of(context).textTheme.bodyText1,
              ),
              Text('${userModel.bio}',
                style:Theme.of(context).textTheme.caption,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('100',
                              style:Theme.of(context).textTheme.subtitle2,
                            ),
                            Text('Posts',
                              style:Theme.of(context).textTheme.caption,
                            ),

                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('264',
                              style:Theme.of(context).textTheme.subtitle2,
                            ),
                            Text('Photos',
                              style:Theme.of(context).textTheme.caption,
                            ),

                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('10k',
                              style:Theme.of(context).textTheme.subtitle2,
                            ),
                            Text('Followers',
                              style:Theme.of(context).textTheme.caption,
                            ),

                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('64',
                              style:Theme.of(context).textTheme.subtitle2,
                            ),
                            Text('Followings',
                              style:Theme.of(context).textTheme.caption,
                            ),

                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  //Expanded(child: defaultButton(onTap: (){}, text: 'Edit Profile'))
                  Expanded(child: OutlinedButton(onPressed: () {  }, child: const Text('Add Photo'),)),
                  const SizedBox(width: 10,),
                  OutlinedButton(onPressed: (){
                    navigateTo(context,   EditProfileScreen());

                  }, child: const Icon(IconBroken.Edit,size: 16,))

                ],
              )
            ],
          ),
        );
      },

    );
  }
}
