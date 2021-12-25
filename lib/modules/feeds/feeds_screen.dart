import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/social_app/post_model.dart';
import 'package:social_app/shared/adaptive/adaptivw_indicator.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Conditional.single(
          context: context,
          conditionBuilder: (context) =>
              SocialCubit.get(context).posts.length > 0 &&
              SocialCubit.get(context).userModel != null,
          widgetBuilder: (context) => LiquidPullToRefresh(
            key: _refreshIndicatorKey,
            onRefresh: SocialCubit.get(context).handleRefresh,
            showChildOpacityTransition: false,
            color: Theme.of(context).scaffoldBackgroundColor,
             backgroundColor: defaultColor,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 5,
                    margin: EdgeInsets.all(
                      8.0,
                    ),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Image(
                          image: NetworkImage(
                            'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg',
                          ),
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
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) => buildPostItem(
                          SocialCubit.get(context).posts[index],
                          context,
                          index),
                      separatorBuilder: (context, index) => SizedBox(
                            height: 5,
                          ),
                      itemCount: SocialCubit.get(context).posts.length),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
          fallbackBuilder: (context) => Center(
              child: AdaptiveIndicator(
            os: getOS(),
          )),
        );
      },
    );
  }

  Widget buildPostItem(PostModel model, context, index) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        margin: EdgeInsets.all(
          8.0,
        ),
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
                      '${model.image}',
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${model.name}',
                              style: TextStyle(height: 1.4),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                              size: 16.0,
                            ),
                          ],
                        ),
                        Text(
                          '${model.dateTime}',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(height: 1.4),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      IconBroken.More_Circle,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                ),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                '${model.text}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(
              //     bottom: 10.0,
              //     top: 5.0,
              //   ),
              //   child: Container(
              //     width: double.infinity,
              //     child: Wrap(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(
              //             end: 6.0,
              //           ),
              //           child: Container(
              //             height: 25.0,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               minWidth: 1.0,
              //               padding: EdgeInsets.zero,
              //               child: Text(
              //                 '#software',
              //                 style:
              //                     Theme.of(context).textTheme.caption.copyWith(
              //                           color: defaultColor,
              //                         ),
              //               ),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(
              //             end: 6.0,
              //           ),
              //           child: Container(
              //             height: 25.0,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               minWidth: 1.0,
              //               padding: EdgeInsets.zero,
              //               child: Text(
              //                 '#flutter',
              //                 style:
              //                     Theme.of(context).textTheme.caption.copyWith(
              //                           color: defaultColor,
              //                         ),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              if (model.postImage != '')
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 15),
                  child: Container(
                    height: 140,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        4.0,
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                          '${model.postImage}',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              Icon(
                                IconBroken.Heart,
                                size: 16,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${SocialCubit.get(context).likes[index]}',
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
                          padding: const EdgeInsets.symmetric(
                            vertical: 5.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                IconBroken.Chat,
                                size: 16.0,
                                color: Colors.amber,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                ' comment',
                                style: Theme.of(context).textTheme.caption,
                              ),
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
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                ),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
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
                              '${SocialCubit.get(context).userModel!.image}',
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'write a comment ...',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(),
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Heart,
                          size: 16.0,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Like',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    onTap: () {
                      SocialCubit.get(context)
                          .likePost(SocialCubit.get(context).postsId[index]);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
