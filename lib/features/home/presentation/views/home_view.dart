import 'package:damma_project/core/utils/assets.dart';
import 'package:damma_project/features/requstes_recieved/presentation/views/requests_received_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../profile/presentation/views/profile_view.dart';
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
      const HomeViewBody(),
      const SearchViewBody(),
      const RequestsReceivedView(),
      ProfileView(
        userId: widget.userId,
      ),
      //SettingsView(userId: widget.userId)
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
              _currentIndex == 0 ? Assets.svgsHome : Assets.svgsHomeFilled,
            ),
            label: "الرئيسية",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _currentIndex == 1 ? Assets.svgsSearch : Assets.svgsSearchFilled,
            ),
            label: "البحث",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _currentIndex == 2
                  ? Assets.svgsFriendsFilled
                  : Assets.svgsFriendsOutlined,
            ),
            label: "طلبات الصداقة",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _currentIndex == 3
                  ? Assets.svgsProfile
                  : Assets.svgsProfileFilled,
            ),
            label: "البروفايل",
          ),
        ],
      ),
      body: SafeArea(
        child: _screens[_currentIndex],
      ),
    );
  }
}
