import 'package:flutter/material.dart';
import 'MyHomePage.dart';
import 'GridViewLearning.dart';
import 'ListViewLearning.dart';
import '../../home/PostNews.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    MyHomePage(),
    Gridviewlearning(),
    ListWithCard(),
    PostNews(),
  ];

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Screen'),
        backgroundColor: Colors.cyan,
        centerTitle: true,
        elevation: 5, // Shadow for AppBar
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: _tabs,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
              _pageController.jumpToPage(index); // Navigate with animation
            });
          },
          selectedItemColor: Colors.cyan,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_3x3),
              label: 'GridView',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'ListView',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.post_add),
              label: 'Post Data',
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
