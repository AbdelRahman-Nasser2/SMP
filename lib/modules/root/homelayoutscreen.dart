import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smp/shared/cubit/appcubit/appcubit.dart';
import 'package:smp/shared/cubit/appcubit/appstates.dart';
import 'package:smp/theme.dart';

// class HomeLayoutScreen extends StatefulWidget {
//   int currentScreen = 0;
//
//   HomeLayoutScreen({super.key, required this.currentScreen});
//
//   @override
//   State<HomeLayoutScreen> createState() => _HomeLayoutScreenState();
// }
//
// class _HomeLayoutScreenState extends State<HomeLayoutScreen> {
//   int _currentIndex = 0;
//   final screens = [
//     HomeScreen(),
//     const TransactionHistoryView(),
//     const SettingsView(),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _currentIndex = widget.currentScreen;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async => await _onBackPressed(),
//       child: Scaffold(
//         appBar: AppBar(
//           elevation: 0,
//           toolbarHeight: 0,
//           systemOverlayStyle: const SystemUiOverlayStyle(
//               statusBarColor: backgroundColor,
//               statusBarIconBrightness: Brightness.dark),
//         ),
//         backgroundColor: backgroundColor,
//         body: screens[_currentIndex],
//         bottomNavigationBar: CustomBottomNavBar(
//           defaultSelectedIndex: _currentIndex,
//           selectedItemIcon: const [
//             "assets/icons/home_fill.png",
//             "assets/icons/receipt_fill.png",
//             "assets/icons/settings_fill.png"
//           ],
//           unselectedItemIcon: const [
//             "assets/icons/home_outlined.png",
//             "assets/icons/receipt_outlined.png",
//             "assets/icons/settings_outlined.png"
//           ],
//           label: const ["Home", "Transaction", "Settings"],
//           onChange: (val) {
//             setState(() {
//               _currentIndex = val;
//             });
//           },
//         ),
//       ),
//     );
//   }
//
//   Future<bool> _onBackPressed() async {
//     return await showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: const Text('Exit the App'),
//             content: const Text('Do you want to exit the application?'),
//             actions: <Widget>[
//               // const SizedBox(height: 16),
//               TextButton(
//                   onPressed: () => Navigator.of(context).pop(false),
//                   child: const Text('No')),
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(true),
//                 child: const Text('Yes'),
//               ),
//             ],
//           ),
//         ) ??
//         false;
//   }
// }

class HomeLayoutScreen extends StatelessWidget {
  const HomeLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {},
      builder: (BuildContext context, AppStates state) {
        AppCubit cubit = AppCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 0,
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: backgroundColor,
                statusBarIconBrightness: Brightness.dark),
          ),
          backgroundColor: backgroundColor,
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: CustomBottomNavBar(
            defaultSelectedIndex: cubit.currentIndex,
            selectedItemIcon: const [
              "assets/icons/home_fill.png",
              "assets/icons/receipt_fill.png",
              "assets/icons/settings_fill.png"
            ],
            unselectedItemIcon: const [
              "assets/icons/home_outlined.png",
              "assets/icons/receipt_outlined.png",
              "assets/icons/settings_outlined.png"
            ],
            label: const ["Home", "Transaction", "Settings"],
            onChange: (value) {
              cubit.changeScreen(value);
            },
          ),
        );
      },
    );
  }
}

class CustomBottomNavBar extends StatefulWidget {
  final int defaultSelectedIndex;
  final List<String> selectedItemIcon;
  final List<String> unselectedItemIcon;
  final List<String> label;
  final Function(int) onChange;

  const CustomBottomNavBar(
      {super.key,
      this.defaultSelectedIndex = 0,
      required this.selectedItemIcon,
      required this.unselectedItemIcon,
      required this.label,
      required this.onChange});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0;
  List<String> _selectedItemIcon = [];
  List<String> _unselectedItemIcon = [];
  List<String> _label = [];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.defaultSelectedIndex;
    _selectedItemIcon = widget.selectedItemIcon;
    _unselectedItemIcon = widget.unselectedItemIcon;
    _label = widget.label;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> navBarItems = [];

    for (int i = 0; i < 3; i++) {
      navBarItems.add(bottomNavBarItem(
          _selectedItemIcon[i], _unselectedItemIcon[i], _label[i], i));
    }
    return Container(
      decoration: const BoxDecoration(
          color: colorWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(18))),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: navBarItems,
      ),
    );
  }

  Widget bottomNavBarItem(activeIcon, inactiveIcon, label, index) {
    return GestureDetector(
      onTap: () {
        widget.onChange(index);
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        height: kBottomNavigationBarHeight,
        width: MediaQuery.of(context).size.width / _selectedItemIcon.length,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(borderRadiusSize))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _selectedIndex == index
              ? Container(
                  decoration: BoxDecoration(
                      color: primaryColor100,
                      borderRadius: BorderRadius.circular(borderRadiusSize)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        activeIcon,
                        width: 22,
                        height: 22,
                        color: primaryColor500,
                      ),
                      Text(
                        label,
                        style: bottomNavTextStyle,
                      )
                    ],
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      inactiveIcon,
                      width: 22,
                      height: 22,
                      color: primaryColor300,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
