import 'package:flutter/material.dart';
import 'package:forex_290/const/color.dart';
import 'package:forex_290/nav_manager.dart';

class ProfilePage extends StatefulWidget {
  static const String routeName = '/';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => const ProfilePage());
  }

  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    MyNavigatorManager.instance
        .navigatorInit(context.findAncestorStateOfType<NavigatorState>()!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) => false,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(children: [
            Container(
              height: 144,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.transparent),
              child: Padding(
                padding: const EdgeInsets.only(top: 90),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                      ),
                      const Text(
                        'Profile',
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ]),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: bgSecondColor),
              child: Column(children: [
                ProfileItem(
                  title: 'Account Management',
                  function: () {
                    MyNavigatorManager.instance.bankAccountsPush();
                  },
                ),
                ProfileItem(
                  title: 'Deposit management',
                  function: () {
                    MyNavigatorManager.instance.bankDepositesPush();
                  },
                ),
                ProfileItem(
                  isLast: true,
                  title: 'Credit management',
                  function: () {
                    MyNavigatorManager.instance.bankCreditPush();
                  },
                ),
              ]),
            ),
            const SizedBox(height: 20),
            ProfileItem(
              isLast: true,
              bgColor: bgSecondColor,
              title: 'Settings',
              function: () {
                MyNavigatorManager.instance.settingPush();
              },
            ),
          ]),
        ),
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  final String title;
  final Function() function;
  final bool? isLast;
  final Color? bgColor;
  const ProfileItem({
    super.key,
    required this.function,
    required this.title,
    this.bgColor,
    this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
          border: isLast == null
              ? Border(
                  bottom: BorderSide(color: Colors.white.withOpacity(0.12)))
              : null),
      child: Material(
        color: bgColor ?? Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: function,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              ),
              Icon(
                Icons.navigate_next,
                size: 25,
                color: Colors.white.withOpacity(0.3),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
