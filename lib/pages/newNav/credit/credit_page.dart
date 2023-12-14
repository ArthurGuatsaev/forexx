import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forex_290/bank/domain/bloc/bank_bloc.dart';
import 'package:forex_290/const/color.dart';
import 'package:forex_290/nav_manager.dart';
import 'package:forex_290/widgets/calc_button.dart';
import 'package:forex_290/widgets/pop/modal_credit_add.dart';

class BankCredit extends StatefulWidget {
  static const String routeName = '/credit';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => const BankCredit());
  }

  const BankCredit({super.key});

  @override
  State<BankCredit> createState() => _BankCreditState();
}

class _BankCreditState extends State<BankCredit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            'Credit management',
            style: TextStyle(
                fontSize: 17, color: Colors.white, fontWeight: FontWeight.w400),
          )),
      body: Stack(
        children: [
          BlocBuilder<BankBloc, BankState>(
            buildWhen: (previous, current) =>
                previous.bank!.credits! != current.bank!.credits!,
            builder: (context, state) {
              if (state.bank!.credits!.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 200),
                          Image.asset('assets/images/credit_empty.png'),
                          const SizedBox(height: 30),
                          const Text(
                            'Empty',
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                          Text(
                            "You don't have any added credits yet",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.white.withOpacity(0.7)),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return CustomScrollView(
                slivers: [
                  SliverList.builder(
                      itemCount: state.bank!.credits!.length,
                      itemBuilder: (context, index) {
                        final cred = state.bank!.credits![index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: CreditItem(
                            function: () {
                              MyNavigatorManager.instance.bankCreditFacePush();
                            },
                            title: '${cred.price}',
                            index: index,
                            length: state.bank!.credits!.length - 1,
                          ),
                        );
                      })
                ],
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40, left: 12, right: 12),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CalcButton(
                text: 'New credit',
                gradic: gradientButton,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                function: () {
                  showModalSheetCreditAdd(
                    context: context,
                    priceController: TextEditingController(),
                    percentController: TextEditingController(),
                    periodController: TextEditingController(),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CreditItem extends StatelessWidget {
  final String title;
  final Function() function;
  final int index;
  final int length;
  final Color? bgColor;
  const CreditItem({
    super.key,
    required this.function,
    required this.title,
    required this.length,
    required this.index,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: bgSecondColor,
          borderRadius: BorderRadius.only(
              topLeft: index == 0 ? const Radius.circular(12) : Radius.zero,
              topRight: index == 0 ? const Radius.circular(12) : Radius.zero,
              bottomLeft:
                  index == length ? const Radius.circular(12) : Radius.zero,
              bottomRight:
                  index == length ? const Radius.circular(12) : Radius.zero),
          border: index != length
              ? Border(
                  bottom: BorderSide(color: Colors.white.withOpacity(0.12)))
              : null),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: function,
          child: Padding(
            padding: const EdgeInsets.only(left: 12, right: 8),
            child: Row(children: [
              BlocBuilder<BankBloc, BankState>(
                buildWhen: (previous, current) {
                  if (current.bank!.credits!.length <= current.index) {
                    return false;
                  }
                  return previous.bank!.credits![previous.index] !=
                      current.bank!.credits![previous.index];
                },
                builder: (context, state) {
                  final cred = state.bank!.credits![state.index];
                  return Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                        Text(
                          'Daily payment: \$${cred.paimant.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Colors.white.withOpacity(0.7)),
                        ),
                      ],
                    ),
                  );
                },
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
