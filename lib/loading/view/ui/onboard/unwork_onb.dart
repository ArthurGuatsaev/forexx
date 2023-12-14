import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forex_290/loading/view/bloc/load_bloc.dart';
import 'package:forex_290/loading/view/ui/onboard/widgets/base_onb.dart';
import 'package:forex_290/nav_manager.dart';
import 'package:in_app_review/in_app_review.dart';

class VUnWorkOnb extends StatefulWidget {
  static const String routeName = '/work';

  static Route route() {
    return CupertinoPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) {
          return const VUnWorkOnb();
        });
  }

  const VUnWorkOnb({super.key});

  @override
  State<VUnWorkOnb> createState() => _VUnWorkOnbState();
}

class _VUnWorkOnbState extends State<VUnWorkOnb> {
  get finArt => null;

  final InAppReview inAppReview = InAppReview.instance;

  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoadBloc, LoadState>(
      listenWhen: (previous, current) =>
          previous.onboardIndex != current.onboardIndex,
      listener: (context, state) {
        if (state.onboardIndex == 0) {
          controller.animateToPage(0,
              duration: const Duration(milliseconds: 250),
              curve: Curves.linear);
        }
        if (state.onboardIndex == 1) {
          controller.animateToPage(1,
              duration: const Duration(milliseconds: 250),
              curve: Curves.linear);
        }
        if (state.onboardIndex == 2) {
          controller.animateToPage(2,
              duration: const Duration(milliseconds: 250),
              curve: Curves.linear);
        }
        if (state.onboardIndex == 3) {
          MyNavigatorManager.instance.simulatorPop();
        }
      },
      child: PageView(
        padEnds: false,
        pageSnapping: false,
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          VBaseBoard(
            entity: 3,
            boardParam: VBoardParam(
              image: 'assets/images/unwork_one.png',
              title: 'Bank simulator',
              body: 'Learn how the bank works in our game',
              buttonText: 'Next',
              function: () => context.read<LoadBloc>().add(
                    const ChangeOnbIndicatorEvent(index: 1),
                  ),
            ),
          ),
          VBaseBoard(
            entity: 3,
            boardParam: VBoardParam(
              image: 'assets/images/unwork_two.png',
              title: "Investing",
              body: 'Find out how banks make money from companies',
              buttonText: 'Next',
              function: () => context.read<LoadBloc>().add(
                    const ChangeOnbIndicatorEvent(index: 2),
                  ),
            ),
          ),
          VBaseBoard(
            entity: 3,
            boardParam: VBoardParam(
              image: 'assets/images/unwork_three.png',
              title: 'Manage',
              body: 'Learn to manage your money ',
              buttonText: 'Next',
              function: () => context.read<LoadBloc>().add(
                    const ChangeOnbIndicatorEvent(index: 3),
                  ),
            ),
          )
        ],
      ),
    );
  }
}
