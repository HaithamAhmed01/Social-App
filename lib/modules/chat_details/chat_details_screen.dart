import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/social_app/message_model.dart';
import 'package:social_app/models/social_app/social_user_model.dart';
import 'package:social_app/shared/adaptive/adaptivw_indicator.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

class ChatDetailsScreen extends StatelessWidget {
  SocialUserModel userModel;

  ChatDetailsScreen({
    required this.userModel,
  });

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMessages(receiverId: userModel.uId);
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var messages = SocialCubit.get(context).messages;
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(userModel.image),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(userModel.name),
                  ],
                ),
              ),
              body: Conditional.single(
                context: context,
                conditionBuilder: (context) => messages.length > 0,
                widgetBuilder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              var message = messages[index];
                              if (SocialCubit.get(context).userModel!.uId ==
                                  message.senderId)
                                return buildMyMessage(message);

                              return buildMessage(message);
                            },
                            separatorBuilder:
                                (BuildContext context, int index) => SizedBox(
                              height: 15,
                            ),
                            itemCount: messages.length,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            height: 50,
                            padding: EdgeInsetsDirectional.only(
                              start: 15,
                              end: 0,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.grey,
                                )),
                            child: TextFormField(
                              controller: messageController,
                              maxLines: 999,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Aa',
                                suffixIcon: MaterialButton(
                                  height: 10,
                                  padding: EdgeInsets.zero,
                                  onPressed: () async {
                                    SocialCubit.get(context).sendMessage(
                                      receiverId: userModel.uId,
                                      dateTime: DateTime.now().toString(),
                                      text: messageController.text,
                                    );
                                    messageController.clear();
                                  },
                                  color: defaultColor,
                                  elevation: 10,
                                  minWidth: 1,
                                  child: Icon(
                                    IconBroken.Send,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                fallbackBuilder: (context) => messages.length == 0
                    ? Column(
                        children: [
                          Spacer(),
                          Center(
                            child: Text('No Messages yet'),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              height: 50,
                              padding: EdgeInsetsDirectional.only(
                                start: 15,
                                end: 0,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.grey,
                                  )),
                              child: TextFormField(
                                controller: messageController,
                                maxLines: 999,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Aa',
                                  suffixIcon: MaterialButton(
                                    height: 10,
                                    padding: EdgeInsets.zero,
                                    onPressed: () async {
                                      SocialCubit.get(context).sendMessage(
                                        receiverId: userModel.uId,
                                        text: messageController.text,
                                        dateTime: TimeOfDay.now().toString(),
                                      );
                                      messageController.clear();
                                    },
                                    color: defaultColor,
                                    elevation: 10,
                                    minWidth: 1,
                                    child: Icon(
                                      IconBroken.Send,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: AdaptiveIndicator(
                        os: getOS(),
                      )),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(
                10.0,
              ),
              topStart: Radius.circular(
                10.0,
              ),
              topEnd: Radius.circular(
                10.0,
              ),
            ),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          child: Text(model.text),
        ),
      );

  Widget buildMyMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          decoration: BoxDecoration(
            color: defaultColor.withOpacity(
              .2,
            ),
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(
                10.0,
              ),
              topStart: Radius.circular(
                10.0,
              ),
              topEnd: Radius.circular(
                10.0,
              ),
            ),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          child: Text(
            model.text,
          ),
        ),
      );
}
