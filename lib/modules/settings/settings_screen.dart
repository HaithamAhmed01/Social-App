import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/edit_profile/edit_screen.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/shared/adaptive/adaptivw_indicator.dart';
import 'package:social_app/shared/components/componets.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        // if (SocialCubit.get(context).userModel == null) {
        //   SocialCubit.get(context).getUserData();
        // }
      },
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;
        return Conditional.single(
          context: context,
          conditionBuilder: (context) =>
              SocialCubit.get(context).userModel != null,
          widgetBuilder: (context) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 190,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        child: Container(
                          height: 140,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                4.0,
                              ),
                              topRight: Radius.circular(
                                4.0,
                              ),
                            ),
                            image: DecorationImage(
                              image: coverImage == null
                                  ? NetworkImage('${userModel!.cover}')
                                  : FileImage(coverImage) as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        alignment: AlignmentDirectional.topCenter,
                      ),
                      CircleAvatar(
                        radius: 64,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: profileImage == null
                              ? NetworkImage('${userModel!.image}')
                              : FileImage(profileImage) as ImageProvider,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '${userModel!.name}',
                  style: Theme.of(context).textTheme.bodyText1,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${userModel.bio}',
                  style: Theme.of(context).textTheme.caption,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '100',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              Text(
                                'Posts',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '265',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              Text(
                                'Photos',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '10k',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              Text(
                                'Followers',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '64',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              Text(
                                'Followings',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          navigateTo(context, NewPostScreen());
                        },
                        child: Text('Add Post'),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    OutlinedButton(
                        onPressed: () {
                          navigateTo(context, EditProfileScreen());
                        },
                        child: Icon(
                          IconBroken.Edit,
                          size: 16,
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    OutlinedButton(
                        onPressed: () {
                          SocialCubit.get(context).logOut(context);
                        },
                        child: Icon(
                          IconBroken.Logout,
                          size: 16,
                        )),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                // ListTile(
                //   title: Text(
                //     'Logout',
                //     style: TextStyle(color: defaultColor),
                //   ),
                //   // style: ListTileStyle.drawer,
                //   leading: Icon(
                //     IconBroken.Logout,
                //     color: defaultColor,
                //   ),
                //   onTap: () {
                //     SocialCubit.get(context).logOut(context);
                //   },
                // ),
              ],
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
}
