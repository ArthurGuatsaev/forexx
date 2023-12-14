// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:forex_290/loading/view/ui/onboard/widgets/base_onb.dart';
import 'package:forex_290/nav_manager.dart';
import 'package:forex_290/widgets/telega_button.dart';

class VBoardTelega extends StatelessWidget {
  static const String routeName = '/tg';
  static Route route(VBoardParam param) {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => VBoardTelega(boardParam: param));
  }

  final VBoardParam boardParam;
  const VBoardTelega({
    required this.boardParam,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              boardParam.image,
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
                        boardParam.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w700,
                            color: Colors.blue),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        boardParam.body,
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
          Padding(
            padding: const EdgeInsets.only(bottom: 50, left: 12, right: 12),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 48,
                child: SizedBox(
                  height: 48,
                  child: VTelegaButton(adress: boardParam.tg ?? ''),
                ),
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
                  onPressed: boardParam.function,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final _gradient = LinearGradient(colors: [
  const Color(0xFF3C89CF).withOpacity(0.1),
  const Color(0xFF3C89CF).withOpacity(0.1),
]);

VBoardParam telegaParam(String url) => VBoardParam(
      tg: url,
      image: 'assets/images/telega.png',
      function: () => MyNavigatorManager.instance.simulatorPop(),
      title: 'Join and earn',
      body: 'Join our Telegram group trade with our team',
      buttonText: 'Skip',
    );
