import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koran_karim/screens/main_page.dart';
import 'package:koran_karim/screens/quran_page_screen.dart';
import 'package:koran_karim/screens/tasbih_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List _pages = <Widget>[MainPage(), QuranPages(), TasbihScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: GoogleFonts.poppins(
          fontSize: 16,
        ),
        selectedItemColor: Colors.lightBlueAccent,
        backgroundColor: const Color.fromARGB(255, 240, 242, 250),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu_book_sharp,
              size: 30,
            ),
            label: 'Quran',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.insert_drive_file_sharp,
              size: 30,
            ),
            label: 'Quran pages',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.blur_circular_sharp,
              size: 30,
            ),
            label: 'Tasbih',
          ),
        ],
      ),
    );
  }
}
