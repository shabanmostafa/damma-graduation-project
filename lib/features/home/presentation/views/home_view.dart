import 'package:damma_project/core/utils/assets.dart';
import 'package:damma_project/features/friend_requests/presentation/widgets/friend_view_body.dart';
import 'package:damma_project/features/home/presentation/widgets/home_view_body.dart';
import 'package:damma_project/features/search/presentation/widgets/search_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/utils/app_colors.dart';

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
      const Center(child: Text("صفحتي")),
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


// class _HomeViewState extends State<HomeView> {
//   int _currentIndex = 0; // Changed from 1 to 0 to select Home tab first

//   final List<Widget> _screens = [
//      HomeViewBody(userId: widget.userId), // Index 0 - Home
//     const SearchViewBody(), // Index 1 - Search
//     const FriendViewBody(), // Index 2 - Friends
//     const Center(child: Text("صفحتي")), // Index 3 - Profile
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.whiteColor,
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         selectedItemColor: Colors.black,
//         unselectedItemColor: Colors.grey,
//         type: BottomNavigationBarType.fixed,
//         backgroundColor: Colors.white,
//         items: [
//           BottomNavigationBarItem(
//             icon: SvgPicture.asset(
//               _currentIndex == 0
//                   ? Assets.svgsNavigationHomeSelected
//                   : Assets.svgsNavigationHomeUnselected,
//             ),
//             label: "",
//           ),
//           BottomNavigationBarItem(
//             icon: SvgPicture.asset(
//               _currentIndex == 1
//                   ? Assets.svgsNavigationSearchSelected
//                   : Assets.svgsNavigationSerachUnselected,
//             ),
//             label: "",
//           ),
//           BottomNavigationBarItem(
//             icon: SvgPicture.asset(
//               _currentIndex == 2
//                   ? Assets.svgsNavigationAddFriendSelected
//                   : Assets.svgsNavigationAddFriendUnselected,
//             ),
//             label: "",
//           ),
//           BottomNavigationBarItem(
//             icon: SvgPicture.asset(
//               _currentIndex == 3
//                   ? Assets.svgsNavigationProfileSelected
//                   : Assets.svgsNavigationProfileUnselected,
//             ),
//             label: "",
//           ),
//         ],
//       ),
//       body: SafeArea(
//         child: _screens[_currentIndex],
//       ),
//     );
//   }
// }




// class HomeView extends StatefulWidget {
//   const HomeView({super.key});

//   @override
//   State<HomeView> createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   int _currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<LoginCubit, LoginState>(
//       builder: (context, state) {
//         if (state is LoginSuccess) {
//           final userId = state.response.id;

//           final screens = [
//             HomeViewBody(userId: userId),
//             const SearchViewBody(),
//             const FriendViewBody(),
//             const Center(child: Text("صفحتي")),
//           ];

//           return Scaffold(
//             backgroundColor: AppColors.whiteColor,
//             bottomNavigationBar: BottomNavigationBar(
//               currentIndex: _currentIndex,
//               onTap: (index) {
//                 setState(() {
//                   _currentIndex = index;
//                 });
//               },
//               selectedItemColor: Colors.black,
//               unselectedItemColor: Colors.grey,
//               type: BottomNavigationBarType.fixed,
//               backgroundColor: Colors.white,
//               items: [
//                 BottomNavigationBarItem(
//                   icon: SvgPicture.asset(
//                     _currentIndex == 0
//                         ? Assets.svgsNavigationHomeSelected
//                         : Assets.svgsNavigationHomeUnselected,
//                   ),
//                   label: "",
//                 ),
//                 BottomNavigationBarItem(
//                   icon: SvgPicture.asset(
//                     _currentIndex == 1
//                         ? Assets.svgsNavigationSearchSelected
//                         : Assets.svgsNavigationSerachUnselected,
//                   ),
//                   label: "",
//                 ),
//                 BottomNavigationBarItem(
//                   icon: SvgPicture.asset(
//                     _currentIndex == 2
//                         ? Assets.svgsNavigationAddFriendSelected
//                         : Assets.svgsNavigationAddFriendUnselected,
//                   ),
//                   label: "",
//                 ),
//                 BottomNavigationBarItem(
//                   icon: SvgPicture.asset(
//                     _currentIndex == 3
//                         ? Assets.svgsNavigationProfileSelected
//                         : Assets.svgsNavigationProfileUnselected,
//                   ),
//                   label: "",
//                 ),
//               ],
//             ),
//             body: SafeArea(child: screens[_currentIndex]),
//           );
//         }

//         // عرض شاشة انتظار أو إعادة توجيه لشاشة تسجيل الدخول في حال عدم وجود LoginSuccess
//         return const Scaffold(
//           body: Center(child: CircularProgressIndicator()),
//         );
//       },
//     );
//   }
// }
