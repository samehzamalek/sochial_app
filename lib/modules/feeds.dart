import 'package:flutter/material.dart';
import 'package:sochial_app/shared/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
            itemBuilder: (context, index) => buildPostItem(context),
            itemCount: 10,
            separatorBuilder: (BuildContext context, int index)=>const SizedBox(
              height: 8,
            ),
          ),
          const SizedBox(
            height: 8,
          )
        ],
      ),
    );
  }

  Widget buildPostItem(context) => Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                      'https://image.shutterstock.com/image-photo/professional-female-soccer-players-celebrating-600w-1797492769.jpg'),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Text('sameh ali'),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 16,
                          )
                        ],
                      ),
                      Text(
                        'January 21,2021 at 11:00 pm',
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
            const Text(
              'Professional female soccer players celebrating a victory on a sports arena. Group of woman football players screaming and punch air after winning the championship on sports field.',
              style: TextStyle(height: 1.2),
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
            Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    image: const DecorationImage(
                      image: NetworkImage(
                          'https://image.shutterstock.com/image-photo/female-runner-medal-celebrating-victory-600w-1760783186.jpg'),
                      fit: BoxFit.cover,
                    ))),
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
                              '1200',
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                      ),
                      onTap: () {},
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
                              '1200 comment',
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
                        const CircleAvatar(
                          radius: 18,
                          backgroundImage: NetworkImage(
                              'https://image.shutterstock.com/image-photo/professional-female-soccer-players-celebrating-600w-1797492769.jpg'),
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
                    onTap: () {},
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
                  onTap: () {},
                )
              ],
            )
          ],
        ),
      ));
}
