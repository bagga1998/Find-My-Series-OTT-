// ignore_for_file: file_names
import 'package:find_my_series/Screens/Home%20Screen/homeScreen.dart';
import 'package:find_my_series/Screens/News/All%20News/newsScreen.dart';
import 'package:find_my_series/Screens/Profile/Profile/profileScreen.dart';
import 'package:find_my_series/Screens/Releasing%20Today/releasingTodayScreen.dart';
import 'package:find_my_series/Screens/Search/SearchScreen.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Add google_fonts in pubspec.yaml

class bottomNavBar extends StatefulWidget {
  const bottomNavBar({super.key});

  @override
  State<bottomNavBar> createState() => _bottomNavBarState();
}

class _bottomNavBarState extends State<bottomNavBar> {
  int _selectedIndex = 0;
  late List<Widget> _screens;

@override
void initState() {
  super.initState();
  _screens = [
    const Homescreen(),
    const SearchScreen(),
    const NewScreen(),
    const NewsScreen(),
    const ProfileScreen(),
  ];
}


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Keeps screen state & prevents rebuild flicker
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),

      // Transparent background container for bottom bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          border: Border(
            top: BorderSide(
              color: const Color.fromARGB(255, 61, 61, 61).withOpacity(0.9),
              width: 1,
            ),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.black,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: OTTColors.buttoncolour,
          unselectedItemColor: OTTColors.preferredServices,
          // ✅ Change font family here using GoogleFonts
          selectedLabelStyle: GoogleFonts.dmSans( // You can replace 'Roboto' with any font
            fontWeight: FontWeight.w500,
            fontSize: 13,
            color: OTTColors.buttoncolour,
          ),
          unselectedLabelStyle: GoogleFonts.dmSans(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: OTTColors.preferredServices,
          ),
          items: [
            _buildNavItem(Icons.home_filled, "Home", 0),
            _buildNavItem(Icons.search_sharp, "Search", 1),
            _buildNavItem(Icons.local_fire_department, "New", 2),
            _buildNavItem(Icons.play_circle_outline_rounded, "News", 3),
            _buildNavItem(Icons.person_2_outlined, "Profile", 4),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
      IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;

    return BottomNavigationBarItem(
      icon: ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            colors: isSelected
                ? [OTTColors.buttoncolour, OTTColors.buttoncolour] // Gradient for selected
                : [OTTColors.preferredServices, OTTColors.preferredServices],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds);
        },
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
      label: label,
    );
  }
}
