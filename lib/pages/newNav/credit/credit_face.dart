import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forex_290/bank/domain/bloc/bank_bloc.dart';
import 'package:forex_290/const/color.dart';
import 'package:forex_290/nav_manager.dart';
import 'package:forex_290/widgets/pop/modal_credit_pay.dart';
import 'package:forex_290/widgets/pop/modal_credit_redemption.dart';

class CreditFace extends StatefulWidget {
  static const String routeName = '/cred';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => const CreditFace());
  }

  const CreditFace({super.key});

  @override
  State<CreditFace> createState() => _CreditFaceState();
}

class _CreditFaceState extends State<CreditFace> {
  late final TextEditingController controller = TextEditingController();
  late final TextEditingController transferController = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    transferController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BankBloc, BankState>(
      buildWhen: (previous, current) {
        if (current.bank!.credits!.length <= current.index) return false;
        return previous.bank!.credits![previous.index] !=
            current.bank!.credits![current.index];
      },
      builder: (context, state) {
        if (state.bank!.credits!.length <= state.index) {
          return const SizedBox();
        }
        final cred = state.bank!.credits![state.index];
        return Scaffold(
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
              'Credit',
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
            ),
          ),
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  height: 160,
                  decoration: const BoxDecoration(
                    color: bgSecondColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Balance owed',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white.withOpacity(0.7)),
                            ),
                            Text(
                              '\$${cred.price!.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12.5),
                        Divider(
                          color: Colors.white.withOpacity(0.1),
                        ),
                        const SizedBox(height: 12.5),
                        Row(
                          children: [
                            Expanded(
                                child: SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Interest rate',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white.withOpacity(0.7)),
                                  ),
                                  Text(
                                    '${cred.persent!.toStringAsFixed(2)}%',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            )),
                            Expanded(
                                child: SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Daily payment',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white.withOpacity(0.7)),
                                  ),
                                  Text(
                                    '\$${cred.paimant.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 15)),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 78,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: AcItem(
                            image: 'assets/images/down.png',
                            text: 'Deposit amount',
                            func: () {
                              showModalSheetCreditPay(
                                context: context,
                                payController: controller,
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: AcItem(
                            text: 'Completely close',
                            image: 'assets/images/dollar.png',
                            func: () {
                              showModalSheetCreditRedemption(
                                cred: cred,
                                context: context,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 15)),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'Repayment history',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 15)),
              SliverList.builder(
                itemCount: state.bank!.credits!.isNotEmpty
                    ? state.bank!.credits![state.index].hist!.length
                    : 0,
                itemBuilder: (context, index) {
                  final hist = state.bank!.credits![state.index].hist![index];
                  return Container(
                    height: 46,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    margin:
                        const EdgeInsets.only(bottom: 10, left: 12, right: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: bgSecondColor),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            hist.dateString,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: primary,
                            ),
                          ),
                        ),
                        Text(
                          '-\$${hist.price}',
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}

class AcItem extends StatelessWidget {
  final String image;
  final Function() func;
  final String text;
  const AcItem(
      {super.key, required this.image, required this.func, required this.text});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12),
      color: Colors.transparent,
      child: InkWell(
        onTap: func,
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          decoration: BoxDecoration(
            color: bgSecondColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(image),
              const SizedBox(height: 5),
              Text(
                text,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withOpacity(0.7)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
