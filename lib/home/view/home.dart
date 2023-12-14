import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forex_290/home/domain/bloc/home_bloc.dart';
import 'package:forex_290/home/view/widget/bottom.dart';
import 'package:forex_290/pages/calc_page.dart';
import 'package:forex_290/pages/invest_page.dart';
import 'package:forex_290/pages/main_page.dart';
import 'package:forex_290/pages/newNav/bank_navi.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => const HomePage());
  }

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) =>
            previous.homeIndex != current.homeIndex,
        builder: (context, state) {
          return IndexedStack(index: state.homeIndex, children: const [
            MainPage(),
            CalcPage(),
            InvestPage(),
            BankNavi(),
          ]);
        },
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
