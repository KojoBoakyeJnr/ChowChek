import 'package:chowchek/views/components/drawer_view.dart';
import 'package:chowchek/providers/user_details_provider.dart';
import 'package:chowchek/utils/app_colors.dart';
import 'package:chowchek/utils/app_strings.dart';
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
            appBar: AppBar(),
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
                  icon: Text(
                    AppStrings.todayIcon,
                    style: TextStyle(fontSize: 25),
                  ),
                  label: AppStrings.todayLabel,
                ),
                BottomNavigationBarItem(
                  icon: Text(
                    AppStrings.saveIcon,
                    style: TextStyle(fontSize: 25),
                  ),
                  label: AppStrings.savedLabel,
                ),
                BottomNavigationBarItem(
                  icon: Text(
                    AppStrings.blacklistIcon,
                    style: TextStyle(fontSize: 25),
                  ),
                  label: AppStrings.blacklistLabel,
                ),
              ],
            ),
            body: pages[currentPage],
          ),
    );
  }
}
