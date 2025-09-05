import 'package:chowchek/models/drawer_view.dart';
import 'package:chowchek/providers/user_details_provider.dart';
import 'package:chowchek/utils/app_colors.dart';
import 'package:chowchek/views/main/blacklist_page.dart';
import 'package:chowchek/views/main/saved_page.dart';
import 'package:chowchek/views/main/today_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserDetailsProvider>(context, listen: false).loadAllFromPrefs();
  }

  List pages = [TodayPage(), SavedPage(), BlacklistPage()];
  int currentPage = 0;

  void changePage(int pageNum) {
    setState(() {
      currentPage = pageNum;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserDetailsProvider>(
      builder:
          (context, model, child) => Scaffold(
            appBar: AppBar(
              // title: StreakBanner(), centerTitle: true
            ),
            drawer: DrawerView(),
            bottomNavigationBar: BottomNavigationBar(
              selectedLabelStyle: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 15,
              ),
              unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 10,
              ),
              selectedItemColor: AppColors.deepGreen,
              currentIndex: currentPage,

              onTap: (value) {
                setState(() {
                  currentPage = value;
                });
              },

              items: [
                BottomNavigationBarItem(
                  icon: Text("📆", style: TextStyle(fontSize: 25)),
                  label: "Today",
                ),
                BottomNavigationBarItem(
                  icon: Text("💚", style: TextStyle(fontSize: 25)),
                  label: "Saved",
                ),
                BottomNavigationBarItem(
                  icon: Text("❌", style: TextStyle(fontSize: 25)),
                  label: "Blacklist",
                ),
              ],
            ),
            body: pages[currentPage],
          ),
    );
  }
}
