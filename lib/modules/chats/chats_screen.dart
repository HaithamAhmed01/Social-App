import 'package:flutter/material.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/social_app/social_user_model.dart';
import 'package:social_app/modules/chat_details/chat_details_screen.dart';
import 'package:social_app/shared/adaptive/adaptivw_indicator.dart';
import 'package:social_app/shared/components/componets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:social_app/shared/components/constants.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
        // SocialCubit.get(context).getUserData();
        // SocialCubit.get(context).getUsers();
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Conditional.single(
              context: context,
              conditionBuilder: (context) => SocialCubit.get(context).users.length > 0,
              widgetBuilder: (context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildChatItem(
                    SocialCubit.get(context).users[index], context),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: SocialCubit.get(context).users.length,
              ),
              fallbackBuilder: (context) => Center(
                  child: AdaptiveIndicator(
                    os: getOS(),
                  )),
            );
          },
        );

  }

  Widget buildChatItem(SocialUserModel model, context) => InkWell(
        onTap: () {
          navigateTo(
            context,
            ChatDetailsScreen(userModel: model),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                  '${model.image}',
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              Text(
                '${model.name}',
                style: TextStyle(
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      );
}
