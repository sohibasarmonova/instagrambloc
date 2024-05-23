import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngdemo17/bloc/home/home_bloc.dart';
import 'package:ngdemo17/bloc/home/home_event.dart';
import 'package:ngdemo17/bloc/home/home_state.dart';
import 'package:ngdemo17/bloc/my_feed/like_post_bloc.dart';
import 'package:ngdemo17/bloc/my_feed/my_feed_bloc.dart';
import 'package:ngdemo17/bloc/my_like/my_like_bloc.dart';
import 'package:ngdemo17/bloc/my_profile/axis_count_bloc.dart';
import 'package:ngdemo17/bloc/my_profile/my_photo_bloc.dart';
import 'package:ngdemo17/bloc/my_profile/my_posts_bloc.dart';
import 'package:ngdemo17/bloc/my_profile/my_profile_bloc.dart';
import 'package:ngdemo17/bloc/my_search/follow_member_bloc.dart';
import 'package:ngdemo17/bloc/my_search/my_search_bloc.dart';
import 'package:ngdemo17/bloc/my_upload/image_picker_bloc.dart';
import 'package:ngdemo17/bloc/my_upload/my_upload_bloc.dart';

import '../services/log_service.dart';
import 'my_feed_page.dart';
import 'my_likes_page.dart';
import 'my_profile_page.dart';
import 'my_search_page.dart';
import 'my_upload_page.dart';

class HomePage extends StatefulWidget {
  static const String id = "home_page";

  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc homeBloc;
  PageController? _pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeBloc = context.read<HomeBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        LogService.i(state.currentIndex.toString());
      },
      builder: (context, state) {
        return Scaffold(
          body: PageView(
            controller: _pageController,
            children: [
              MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => MyFeedBloc(),
                  ),
                  BlocProvider(
                    create: (context) => LikePostBloc(),
                  )
                ],
                child: MyFeedPage(
                  pageController: _pageController,
                ),
              ),

              MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => MySearchBloc(),
                  ),
                  BlocProvider(
                    create: (context) => FollowMemberBloc(),
                  ),
                ],
                child: const MySearchPage(),
              ),

              MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => MyUploadBloc(),
                  ),
                  BlocProvider(
                    create: (context) => ImagePickerBloc(),
                  ),
                ],
                child: MyUploadPage(
                  pageController: _pageController,
                ),
              ),
              BlocProvider(create: (context)=>MyLikedPostBloc(),
                child: MyLikesPage(),
              ),

             // const MyLikesPage(),

              MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => MyProfileBloc(),
                  ),
                  BlocProvider(
                    create: (context) => MyPostsBloc(),
                  ),
                  BlocProvider(
                    create: (context) => AxisCountBloc(),
                  ),
                  BlocProvider(
                    create: (context) => MyPhotoBloc(),
                  ),
                ],
                child: const MyProfilePage(),
              ),

            ],
            onPageChanged: (int index) {
              homeBloc.add(PageViewEvent(currentIndex: index));
            },
          ),
          bottomNavigationBar: CupertinoTabBar(
            onTap: (int index) {
              homeBloc.add(BottomNavEvent(currentIndex: index));
              _pageController!.animateToPage(index,
                  duration: Duration(milliseconds: 200), curve: Curves.easeIn);
            },
            currentIndex: state.currentIndex,
            activeColor: Color.fromRGBO(193, 53, 132, 1),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 32,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  size: 32,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_box,
                  size: 32,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                  size: 32,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_circle,
                  size: 32,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}