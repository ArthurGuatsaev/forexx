import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forex_290/bank/domain/bloc/bank_bloc.dart';
import 'package:forex_290/const/color.dart';
import 'package:forex_290/nav_manager.dart';
import 'package:forex_290/widgets/pop/modal_account_pay.dart';
import 'package:forex_290/widgets/pop/modal_account_transfer.dart';
import 'package:forex_290/widgets/pop/pop_up_ios_delete.dart';

class AccountPage extends StatefulWidget {
  static const String routeName = '/account';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => const AccountPage());
  }

  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
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
          title: BlocBuilder<BankBloc, BankState>(
            buildWhen: (previous, current) {
              if (current.bank!.accounts!.length <= current.index) return false;
              return previous.bank!.accounts![previous.index] !=
                  current.bank!.accounts![previous.index];
            },
            builder: (context, state) {
              final acc = state.bank!.accounts![state.index];
              return Text(
                acc.name!,
                style: const TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              );
            },
          )),
      body: BlocBuilder<BankBloc, BankState>(
        buildWhen: (previous, current) {
          if (current.bank!.accounts!.length <= current.index) return false;
          return previous.bank!.accounts![previous.index] !=
              current.bank!.accounts![previous.index];
        },
        builder: (context, state) {
          final acc = state.bank!.accounts![state.index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 80,
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Text(
                            'Account balance',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.white.withOpacity(0.7)),
                          )),
                          // Text(
                          //   'Income:',
                          //   style: TextStyle(
                          //       fontSize: 13,
                          //       fontWeight: FontWeight.w400,
                          //       color: Colors.white.withOpacity(0.7)),
                          // ),
                          // Text(
                          //   ' ${acc.persent!}%',
                          //   style: const TextStyle(
                          //     fontSize: 13,
                          //     fontWeight: FontWeight.w400,
                          //     color: Colors.white,
                          //   ),
                          // ),
                        ],
                      ),
                      Text(
                        '\$${acc.price!}',
                        style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 78,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: AcItem(
                          image: 'assets/images/down.png',
                          text: 'Top up',
                          func: () {
                            showModalSheetAccountPay(
                              percentController: TextEditingController(),
                              context: context,
                              payController: TextEditingController(),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: AcItem(
                          text: 'Transfer',
                          image: 'assets/images/calc.png',
                          func: () {
                            showModalSheetAccountTransfer(
                                acc: acc,
                                context: context,
                                payController: controller,
                                transferController: transferController);
                          },
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: AcItem(
                          text: 'Delete',
                          image: 'assets/images/trash.png',
                          func: () {
                            showMyIosDeleteDataPop(context, () {
                              context
                                  .read<BankBloc>()
                                  .add(DeleteAccountEvent(acc: acc));
                              MyNavigatorManager.instance
                                  .bankPopUntil('/accounts');
                            }, 'Deleting an account',
                                'Your account will be permanently deleted');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'History',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: SizedBox(
                  child: ListView.builder(
                      itemExtent: 70,
                      itemCount: state.bank!.accounts!.isNotEmpty
                          ? state.bank!.accounts![state.index].hist!.length
                          : 0,
                      itemBuilder: (context, index) {
                        final acc =
                            state.bank!.accounts![state.index].hist![index];
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          margin: const EdgeInsets.only(
                              bottom: 10, left: 12, right: 12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: bgSecondColor),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      acc.dateString,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white.withOpacity(0.7),
                                      ),
                                    ),
                                    Text(
                                      acc.title!,
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '${acc.title == 'Transfer between accounts' ? '-' : '+'}\$${acc.price}',
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color:
                                      acc.title == 'Transfer between accounts'
                                          ? Colors.white.withOpacity(0.7)
                                          : Colors.green,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              )
            ],
          );
        },
      ),
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
