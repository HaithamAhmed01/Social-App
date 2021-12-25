import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/components/componets.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialCreatePostSuccessState &&
            SocialCubit.get(context).postImage != null) {
          SocialCubit.get(context).removePostImage();
          textController.clear();
          Navigator.pop(context);
        }else if (state is SocialCreatePostSuccessState ){
          textController.clear();
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: 'Create Post', actions: [
            defaultTextButton(
                function: () {
                  var now = DateTime.now();
                  String formattedDate = DateFormat.MMMEd().add_jm().format(now);
                  if (SocialCubit.get(context).postImage == null) {
                    SocialCubit.get(context).createPost(
                      dateTime: formattedDate.toString(),
                      text: textController.text,
                    );
                  } else {
                    SocialCubit.get(context).uploadPostImage(
                      dateTime: formattedDate.toString(),
                      text: textController.text,
                    );
                  }
                },
                text: 'Post'),
          ]),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                if (state is SocialCreatePostLoadingState)
                  SizedBox(
                    height: 10.0,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                          '${SocialCubit.get(context).userModel!.image}'),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Text(
                        '${SocialCubit.get(context).userModel!.name}',
                        style: TextStyle(
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                    child: TextFormField(
                  controller: textController,
                  decoration: InputDecoration(
                      hintText:
                          'What is on your mind ${SocialCubit.get(context).userModel!.name}',
                      border: InputBorder.none),
                )),
                SizedBox(
                  height: 20.0,
                ),
                if (SocialCubit.get(context).postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 140.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            4.0,
                          ),
                          image: DecorationImage(
                            image:
                                FileImage(SocialCubit.get(context).postImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: CircleAvatar(
                          radius: 20,
                          child: Icon(
                            IconBroken.Delete,
                            size: 18,
                          ),
                        ),
                        onPressed: () {
                          SocialCubit.get(context).removePostImage();
                        },
                      )
                    ],
                  ),
                SizedBox(
                  height: 20.0,
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
                          children: [
                            Icon(
                              IconBroken.Image,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'add photo',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          '# tags',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
