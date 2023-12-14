import 'package:flutter/material.dart';
import 'package:forex_290/nav_manager.dart';
import 'package:forex_290/widgets/calc_button.dart';
import 'package:permission_handler/permission_handler.dart';

class VBoardPush extends StatelessWidget {
  final String image;
  final String title;
  final String body;
  final String buttonText;
  const VBoardPush({
    Key? key,
    required this.image,
    required this.title,
    required this.body,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              image,
              alignment: Alignment.topCenter,
              fit: BoxFit.fitWidth,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.transparent),
                child: Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15, top: 90),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFFEB81E)),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        body,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 50, left: 12, right: 12),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 48,
                child: CalcButton(
                    text: 'Enable notification',
                    function: _pushActivate,
                    fontSize: 16,
                    gradic: _gradient,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, right: 12),
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1)),
                child: CloseButton(
                  color: Colors.white.withOpacity(0.6),
                  onPressed: MyNavigatorManager.instance.simulatorPop,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const _gradient = LinearGradient(colors: [
  Color(0xFFFEB81E),
  Color(0xFFFEB81E),
]);

void _pushActivate() async {
  final PermissionStatus status = await Permission.notification.request();
  if (status.isGranted) {
    // Notification permissions granted
  } else if (status.isDenied) {
    // Notification permissions denied
  } else if (status.isPermanentlyDenied) {
    await openAppSettings();
  }
}
