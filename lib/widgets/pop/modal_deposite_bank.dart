import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forex_290/bank/domain/bloc/bank_bloc.dart';
import 'package:forex_290/const/color.dart';
import 'package:forex_290/const/extention.dart';
import 'package:forex_290/nav_manager.dart';
import 'package:forex_290/pages/newNav/account/account_page.dart';
import 'package:forex_290/widgets/pop/modal_deposit_pay.dart';
import 'package:forex_290/widgets/pop/pop_up_ios_delete.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future showModalSheetDepositBank(BuildContext context) async {
  return showCupertinoModalBottomSheet(
    context: context,
    builder: (context) => SizedBox(
      height: 300,
      child: Material(
        color: Colors.transparent,
        child: BlocBuilder<BankBloc, BankState>(
          buildWhen: (previous, current) {
            if (current.bank!.deposits!.length <= current.index) {
              return false;
            }
            return previous.bank!.deposits![previous.index] !=
                current.bank!.deposits![current.index];
          },
          builder: (context, state) {
            final depo = state.bank!.deposits![state.index];
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                      padding: const EdgeInsets.only(top: 5),
                      height: 30,
                      color: bgSecondColor,
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: Image.asset('assets/images/tire.png'))),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    color: bgSecondColor,
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () => MyNavigatorManager.instance.bankPop(),
                          child: const Row(
                            children: [
                              Icon(Icons.navigate_before,
                                  color: primary, size: 30),
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
                        Center(
                          child: Text(
                            depo.name!.toFirstLetter,
                            style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: 100,
                    padding:
                        const EdgeInsets.only(top: 20, left: 12, right: 12),
                    decoration: const BoxDecoration(
                      color: bgSecondColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Text(
                              'Deposit balance',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white.withOpacity(0.7)),
                            )),
                            Text(
                              'Interest on deposit: ',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white.withOpacity(0.7)),
                            ),
                            Text(
                              '${depo.persent!.toStringAsFixed(2)}%',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '\$${depo.price}',
                          style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 15),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: SizedBox(
                      height: 78,
                      child: Row(
                        children: [
                          Expanded(
                            child: AcItem(
                              image: 'assets/images/down.png',
                              text: 'Top up',
                              func: () {
                                showModalSheetDepositPay(
                                    context: context,
                                    depo: depo,
                                    payController: TextEditingController());
                              },
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: AcItem(
                              text: 'Close deposit',
                              image: 'assets/images/trash.png',
                              func: () {
                                showMyIosDeleteDataPop(
                                  context,
                                  () {
                                    context.read<BankBloc>().add(
                                          DeleteDepositeEvent(depo: depo),
                                        );
                                    MyNavigatorManager.instance
                                        .bankPopUntil('/deposits');
                                  },
                                  'Deleting an deposit',
                                  'Your contribution will be permanently deleted',
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    ),
  );
}

class AccountItem extends StatelessWidget {
  final String title;
  final Function() function;
  final int index;
  final int length;
  final Color? bgColor;
  const AccountItem({
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
              Expanded(
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
                    BlocBuilder<BankBloc, BankState>(
                      buildWhen: (previous, current) {
                        if (current.bank!.deposits!.length <= current.index) {
                          return false;
                        }
                        return previous.bank!.deposits !=
                            current.bank!.deposits;
                      },
                      builder: (context, state) {
                        return Text(
                          '\$${state.bank!.deposits![state.index].price!}',
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: primary),
                        );
                      },
                    ),
                  ],
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
