import 'package:flutter/material.dart';
import 'package:paygo_fit/core/common/res/colours.dart';
import 'package:paygo_fit/src/home/presentation/pages/home_page.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final PageController _pageController = PageController();
  // late final TabController _pageController;

  final ValueNotifier<int> _currentPage = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: PageView(
        controller: _pageController,
        onPageChanged: (page) {
          _currentPage.value = page;
        },
        children: [
          HomePage(),
          HomePage(),
          HomePage(),
          HomePage(),
        ],
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: _currentPage,
        builder: (context, currentPage, _) {
          return BottomNavigationBar(
            currentIndex: _currentPage.value,
            onTap: (currentIndex) {
              _currentPage.value = currentIndex;
              // _pageController.jumpToPage(currentIndex);
              _pageController.jumpToPage(currentIndex);
            },
            type: BottomNavigationBarType.fixed,
            enableFeedback: false,
            backgroundColor: AppColours.white,
            elevation: 0,
            selectedItemColor: AppColours.primary,
            selectedLabelStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            unselectedItemColor: AppColours.iconGrey,
            unselectedLabelStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColours.iconGrey,
            ),
            showUnselectedLabels: true,
            items: [
              _bottomNavBarWidget(
                label: 'Home',
                unSelectedIcon: Icons.home_outlined,
                selectedIcon: Icons.home_rounded,
                index: 0,
              ),
              _bottomNavBarWidget(
                label: 'Bookings',
                unSelectedIcon: Icons.data_thresholding_outlined,
                selectedIcon: Icons.data_thresholding_rounded,
                index: 1,
              ),
              _bottomNavBarWidget(
                label: 'Bookings',
                unSelectedIcon: Icons.pie_chart_outline,
                selectedIcon: Icons.pie_chart_rounded,
                index: 2,
              ),
              _bottomNavBarWidget(
                label: 'Profile',
                unSelectedIcon: Icons.person_2_outlined,
                selectedIcon: Icons.person_2_rounded,
                index: 3,
              ),
            ],
          );
        },
      ),
    );
  }

  BottomNavigationBarItem _bottomNavBarWidget({
    required int index,
    required IconData unSelectedIcon,
    required IconData selectedIcon,
    required String label,
  }) {
    final selected = _currentPage.value == index;
    return BottomNavigationBarItem(
      icon: Icon(
        unSelectedIcon,
      ),
      activeIcon: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        // decoration: BoxDecoration(
        //   // shape: BoxShape.rectangle,
        //   borderRadius: BorderRadius.circular(16),
        //   color: selected ? AppColours.primary : AppColours.iconGrey ,
        // ),
        child: Icon(
          selectedIcon,
          size: 24,
          color: AppColours.primary,
        ),
      ),
      label: label,
    );
  }
}
