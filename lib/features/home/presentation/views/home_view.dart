import 'package:damma_project/core/utils/assets.dart';
import 'package:damma_project/features/profile/presentation/views/profile_view.dart';
import 'package:damma_project/features/settings/presentation/views/settings_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../friend_requests/presentation/views/widgets/friend_view_body.dart';
import '../../../search/presentation/views/widgets/search_view_body.dart';
import 'widgets/home_view_body.dart';

class HomeView extends StatefulWidget {
  final int userId;
  const HomeView({super.key, required this.userId});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeViewBody(userId: widget.userId),
      const SearchViewBody(),
      const FriendViewBody(),
      //const ProfileView(),
      SettingsView(userId: widget.userId)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _currentIndex == 0 ? Assets.svgsHomeFilled : Assets.svgsHome,
            ),
            label: "الرئيسية",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _currentIndex == 1 ? Assets.svgsSearchFilled : Assets.svgsSearch,
            ),
            label: "البحث",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _currentIndex == 2
                  ? Assets.svgsFriendsFilled
                  : Assets.svgsFriendsOutlined,
            ),
            label: "الاصدقاء",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _currentIndex == 3
                  ? Assets.svgsProfileFilled
                  : Assets.svgsProfile,
            ),
            label: "بروفايل",
          ),
        ],
      ),
      body: SafeArea(
        child: _screens[_currentIndex],
      ),
    );
  }
}
