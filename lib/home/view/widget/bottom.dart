import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forex_290/const/color.dart';
import 'package:forex_290/home/domain/bloc/home_bloc.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) =>
            previous.homeIndex != current.homeIndex,
        builder: (context, state) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (value) => context
                .read<HomeBloc>()
                .add(ChangeHomeIndexEvent(homeIndex: value)),
            currentIndex: state.homeIndex,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: primary,
            unselectedItemColor: Colors.white.withOpacity(0.5),
            selectedLabelStyle: const TextStyle(
                color: primary, fontSize: 10, fontWeight: FontWeight.w500),
            unselectedLabelStyle: TextStyle(
                color: Colors.white.withOpacity(0.3),
                fontSize: 10,
                fontWeight: FontWeight.w500),
            items: [
              BottomNavigationBarItem(
                icon: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset('assets/images/main.png',
                        color: Colors.white.withOpacity(0.3))),
                label: 'Main',
                activeIcon: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset(
                      'assets/images/main.png',
                      color: primary,
                    )),
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset('assets/images/calc.png',
                        color: Colors.white.withOpacity(0.3))),
                label: 'Calculator',
                activeIcon: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset(
                      'assets/images/calc.png',
                      color: primary,
                    )),
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset('assets/images/invest.png',
                        color: Colors.white.withOpacity(0.3))),
                label: 'Investing',
                activeIcon: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset(
                      'assets/images/invest.png',
                      color: primary,
                    )),
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset('assets/images/person.png',
                        color: Colors.white.withOpacity(0.3))),
                label: 'Personal Area',
                activeIcon: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset(
                      'assets/images/person.png',
                      color: primary,
                    )),
              ),
            ],
          );
        },
      ),
    );
  }
}
