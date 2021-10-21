import 'package:flutter/material.dart';
 import 'package:sochial_app/shared/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar
         (leading: IconButton(icon: const Icon(IconBroken.Arrow___Left_2),
         onPressed: () {Navigator.pop(context);},
       ),
       title: const Text('Add Post'),
       )
    );
  }
}
