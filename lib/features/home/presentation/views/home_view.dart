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
  int _currentIndex = 0; // Changed from 1 to 0 to select Home tab first

  final List<Widget> _screens = [
    const HomeViewBody(), // Index 0 - Home
    const SearchViewBody(), // Index 1 - Search
    const FriendViewBody(), // Index 2 - Friends
    const Center(child: Text("صفحتي")), // Index 3 - Profile
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
                  ? Assets.svgsNavigationHomeSelected
                  : Assets.svgsNavigationHomeUnselected,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _currentIndex == 1
                  ? Assets.svgsNavigationSearchSelected
                  : Assets.svgsNavigationSerachUnselected,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _currentIndex == 2
                  ? Assets.svgsNavigationAddFriendSelected
                  : Assets.svgsNavigationAddFriendUnselected,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _currentIndex == 3
                  ? Assets.svgsNavigationProfileSelected
                  : Assets.svgsNavigationProfileUnselected,
            ),
            label: "",
          ),
        ],
      ),
      body: SafeArea(
        child: _screens[_currentIndex],
      ),
    );
  }
}
