import 'package:damma_project/core/utils/assets.dart';
import 'package:damma_project/features/friend_requests/presentation/widgets/friend_view_body.dart';
import 'package:damma_project/features/home/presentation/widgets/home_view_body.dart';
import 'package:damma_project/features/search/presentation/widgets/search_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/app_colors.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 1;

  final List<Widget> _screens = [
    const HomeViewBody(),
    const SearchViewBody(),
    const FriendViewBody(),
    const Center(child: Text("صفحتي")),
  ];

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
              _currentIndex == 0
                  ? Assets.svgHomeFilledBottomNavigationBar
                  : Assets.svgHomeBottomNavigationBar,
            ),
            label: "الرئيسية",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _currentIndex == 1
                  ? Assets.svgSearchFilledBottomNavigationBar
                  : Assets.svgSearchBottomNavigationBar,
            ),
            label: "البحث",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _currentIndex == 2
                  ? Assets.svgFriendFilledBottomNavigationBar
                  : Assets.svgFriendNavigationBar,
            ),
            label: " طلبات الصداقة",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _currentIndex == 3
                  ? Assets.svgProfileFilledBottomNavigationBar
                  : Assets.svgProfileBottomNavigationBar,
            ),
            label: "بروفايلي",
          ),
        ],
      ),
      body: SafeArea(
        child: _screens[_currentIndex],
      ),
    );
  }
}
