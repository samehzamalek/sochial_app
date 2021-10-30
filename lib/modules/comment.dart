import 'dart:ui';

import 'package:flutter/material.dart';

class CommentScreen extends StatelessWidget {
  CommentScreen({Key? key}) : super(key: key);
  var commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
        Positioned(
            bottom: 0,
            child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              border:
                                  Border(top: BorderSide(color: Colors.grey))),
                          child: TextFormField(
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(60),
                                    borderSide: const BorderSide(
                                        style: BorderStyle.none)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(60),
                                    borderSide: const BorderSide(
                                        style: BorderStyle.none)),
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                filled: true,
                                fillColor: Colors.grey[200],
                                suffixIcon: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.send)),
                                hintText: 'Write a comment...'),
                          ),
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(5),
                        ),
                      ],
                    )
                  ],
                ))),
        Positioned(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 70,
            child: Container(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [],
                  ),
                ),
              ),
            )),
        Positioned(
          top: 30,
            child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 70 ,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                ListTile(
                  leading: CircleAvatar(child: Icon(Icons.person),),

                  title: Text('sameh'),
                  subtitle: Text('how are you'),
                )

              ],
            ),
          ),
        ))
      ],
    )

        // Center(
        //   child: Text(
        //     'write a comment ...',
        //     style: Theme.of(context).textTheme.caption,
        //   ),
        // ),
        );
  }
}
