import 'package:badges/badges.dart';
import 'package:cia/screens/screens.dart';
import 'package:cia/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static Page page() => const MaterialPage(child: HomeScreen());

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _pageIndex = 0;

  final PageController _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: PageView(
          controller: _controller,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              _pageIndex = index;
            });
          },
          children: const [
            _GetHomePage(),
            AnnouncementScreen(),
            NotificationScreen(),
            SettingsScreen()
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: const Color(0xFFFFFFFF),
          elevation: 4,
          child: SizedBox(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if(_pageIndex != 0) {
                        _pageIndex = 0;
                        _controller.animateToPage(_pageIndex, duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
                      }
                    });
                  },
                  iconSize: 30.0,
                  color: _pageIndex == 0 ? const Color(0xFF295be9) : const Color(0xFF3B3B3B),
                  icon: const Icon(Icons.home),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      if(_pageIndex != 1) {
                        _pageIndex = 1;
                        _controller.animateToPage(_pageIndex, duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
                      }
                    });
                  },
                  iconSize: 30.0,
                  color: _pageIndex == 1 ? const Color(0xFF295be9) : const Color(0xFF3B3B3B),
                  icon: const Icon(Icons.campaign),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      if(_pageIndex != 2) {
                        _pageIndex = 2;
                        _controller.animateToPage(_pageIndex, duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Badge(
                        badgeContent: const Text('3', style: TextStyle(color: Colors.white),),
                        child:  Icon(Icons.notifications, size: 30.0,
                          color: _pageIndex == 2 ? const Color(0xFF295be9) : const Color(0xFF3B3B3B),)),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      if(_pageIndex != 3) {
                        _pageIndex = 3;
                        _controller.animateToPage(_pageIndex, duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
                      }
                    });
                  },
                  iconSize: 30.0,
                  color: _pageIndex == 3 ? const Color(0xFF295be9) : const Color(0xFF3B3B3B),
                  icon: const Icon(Icons.settings),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GetHomePage extends StatelessWidget {

  const _GetHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        SizedBox(height: 20.0,),
        TopBar(isProfileLeading: false,),
        SizedBox(height: 20.0,),
        PromotionCarousel(),
        HomepageSearchBox(),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Text("Quick Access",
              style: TextStyle(
                fontSize: 21.6,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3B3B3B)
            ),
          ),
        ),
        SizedBox(height: 10.0,),
        SlotsContainer(),
      ],
    );
  }

}


