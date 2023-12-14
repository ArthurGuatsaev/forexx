import 'package:flutter/material.dart';
import 'package:forex_290/const/color.dart';
import 'package:forex_290/const/strings.dart';
import 'package:forex_290/nav_manager.dart';
import 'package:forex_290/widgets/pop/pop_up_ios_delete.dart';
import 'package:in_app_review/in_app_review.dart';

class SettingsPage extends StatefulWidget {
  static const String routeName = '/setting';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => const SettingsPage());
  }

  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final InAppReview inAppReview = InAppReview.instance;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) => false,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: bgSecondColor,
            leadingWidth: 100,
            leading: Row(
              children: [
                GestureDetector(
                  onTap: () => MyNavigatorManager.instance.bankPop(),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.navigate_before,
                        color: primary,
                        size: 30,
                      ),
                      SizedBox(
                        width: 0,
                      ),
                      Text(
                        'Back',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: primary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            centerTitle: true,
            title: const Text(
              'Account name',
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
            )),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.transparent),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                      ),
                      const Text(
                        'Setting',
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
                SettingsItem(
                  title: 'Usage Policy',
                  function: () {
                    launchPolicy();
                  },
                ),
                SettingsItem(
                  title: 'Share App',
                  function: () {
                    shareApp(
                        context: context,
                        text:
                            'https://apps.apple.com/us/app/quater-fx/id6474067897');
                  },
                ),
                SettingsItem(
                  isLast: true,
                  title: 'Rate Us',
                  function: () {
                    inAppReview.requestReview();
                  },
                ),
              ]),
            ),
            const SizedBox(height: 20),
            SettingsItem(
              isLast: true,
              bgColor: bgSecondColor,
              title: 'Reset progress',
              function: () {
                showMyIosResetDataPop(context);
              },
            ),
          ]),
        ),
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  final String title;
  final Function() function;
  final bool? isLast;
  final Color? bgColor;
  const SettingsItem({
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
