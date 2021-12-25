import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/edit_profile/edit_screen.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/shared/adaptive/adaptivw_indicator.dart';
import 'package:social_app/shared/components/componets.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        // if (state is SocialLogOutErrorState) {
        //   showToast(
        //     text: state.error,
        //     state: ToastStates.ERROR,
        //   );
        // }
        // if(state is SocialLogOutSuccessState)
        // {
        //   CacheHelper.removeData(
        //     key: 'uId',
        //   ).then((value)
        //   {
        //     navigateAndFinish(
        //       context,
        //       SocialLoginScreen(),
        //     );
        //   });
        // }
        if (state is SocialNewPostState) {
          navigateTo(
            context,
            NewPostScreen(),
          );
        }
        // if (state is SocialLogOutSuccessState){
        //   CacheHelper.removeData(key: 'uId',);
        // }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              // IconButton(
              //   icon: Icon(IconBroken.Notification),
              //   onPressed: () {},
              // ),
              // IconButton(
              //   icon: Icon(IconBroken.Search),
              //   onPressed: () {},
              // ),
              // IconButton(
              //   icon: Icon(IconBroken.Logout),
              //   onPressed: () {
              //     // signOut(context);
              //     cubit.logOut(context);
              //   },
              // ),
              cubit.userModel != null
                  ? InkWell(
                      onTap: () {
                        navigateTo(context, EditProfileScreen());
                      },
                      child: CircleAvatar(
                        radius: 24,
                        child: CircleAvatar(
                          radius: 22.0,
                          backgroundImage:
                              NetworkImage('${cubit.userModel!.image}'),
                        ),
                      ),
                    )
                  : Center(
                    child: AdaptiveIndicator(
                        os: getOS(),
                      ),
                  ),
              SizedBox(
                width: 5,
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Chat,
                ),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Paper_Upload,
                ),
                label: 'Post',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Location,
                ),
                label: 'Users',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Setting,
                ),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
