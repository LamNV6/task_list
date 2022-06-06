import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_list/data/service/task_service.dart';
import 'package:task_list/modules/complete/complete_controller.dart';
import 'package:task_list/modules/complete/complete_screen.dart';
import 'package:task_list/modules/home/home_controller.dart';
import 'package:task_list/modules/incomplete/incomplete_screen.dart';
import '../incomplete/incomplete_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(TaskService());
    Get.put(IncompleteController(taskService: Get.find()));
    Get.put(CompleteController(taskService: Get.find()));
    var tabController = PersistentTabController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TASK LIST',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await controller.askLogout();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: GetX<HomeController>(
        builder: (_) {
          if (_.isLoading.value) {
            return const Loader(type: GFLoaderType.circle);
          } else {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                  child: TableCalendar(
                      onFormatChanged: (format) {
                        _.onChangeFormat(format);
                      },
                      calendarFormat: controller.format.value,
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                      focusedDay: _.daySelected.value,
                      currentDay: _.daySelected.value,
                      onPageChanged: (focusedDay) {
                        _.onDaySelected(focusedDay);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        _.onDaySelected(selectedDay);
                      }),
                ),
                Expanded(
                    child: PersistentTabView(
                  context,
                  controller: tabController,
                  navBarHeight: Get.height * 0.1,
                  screens: _buildScreens(),
                  items: _navBarsItems(),
                  confineInSafeArea: true,
                  backgroundColor: Colors.pink, // Default is Colors.white.
                  handleAndroidBackButtonPress: true, // Default is true.
                  resizeToAvoidBottomInset:
                      true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
                  stateManagement: true, // Default is true.
                  hideNavigationBarWhenKeyboardShows:
                      true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
                  decoration: NavBarDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    colorBehindNavBar: Colors.red,
                  ),
                  popAllScreensOnTapOfSelectedTab: true,
                  popActionScreens: PopActionScreensType.all,
                  itemAnimationProperties: const ItemAnimationProperties(
                    // Navigation Bar's items animation properties.
                    duration: Duration(milliseconds: 200),
                    curve: Curves.ease,
                  ),
                  screenTransitionAnimation: const ScreenTransitionAnimation(
                    // Screen transition animation on change of selected tab.
                    animateTabTransition: true,
                    curve: Curves.ease,
                    duration: Duration(milliseconds: 200),
                  ),
                  navBarStyle: NavBarStyle
                      .style1, // Choose the nav bar style with this property.
                  floatingActionButton: RawMaterialButton(
                    onPressed: () {
                      controller.createTodo();
                    },
                    elevation: 3.0,
                    fillColor: Colors.white,
                    child: const Icon(
                      Icons.add,
                      size: 30.0,
                      color: Colors.pink,
                    ),
                    padding: const EdgeInsets.all(15.0),
                    shape: const CircleBorder(),
                  ),
                ))
              ],
            );
          }
        },
      ),
    );
  }

  List<Widget> _buildScreens() {
    return const [
      IncompleteScreen(),
      CompleteScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.work_outlined),
        title: ("Incomplete"),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: CupertinoColors.white,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.check_mark_circled),
        title: ("Complete"),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: CupertinoColors.white,
      ),
    ];
  }
}
