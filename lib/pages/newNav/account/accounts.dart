import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forex_290/bank/domain/bloc/bank_bloc.dart';
import 'package:forex_290/const/color.dart';
import 'package:forex_290/nav_manager.dart';
import 'package:forex_290/widgets/calc_button.dart';
import 'package:forex_290/widgets/pop/modal_account_add.dart';

class BankAccounts extends StatefulWidget {
  static const String routeName = '/accounts';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => const BankAccounts());
  }

  const BankAccounts({super.key});

  @override
  State<BankAccounts> createState() => _BankAccountsState();
}

class _BankAccountsState extends State<BankAccounts> {
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
            'Account Management',
            style: TextStyle(
                fontSize: 17, color: Colors.white, fontWeight: FontWeight.w400),
          )),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              BlocBuilder<BankBloc, BankState>(
                buildWhen: (previous, current) => previous.bank != current.bank,
                builder: (context, state) {
                  if (state.bank!.accounts!.isEmpty) {
                    return SliverToBoxAdapter(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 200),
                                Image.asset('assets/images/account_empty.png'),
                                const SizedBox(height: 30),
                                const Text(
                                  'Empty',
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                                Text(
                                  "You don't have any accounts created yet",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white.withOpacity(0.7)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return SliverList.builder(
                      itemCount: state.bank!.accounts!.length,
                      itemBuilder: (context, index) {
                        final account = state.bank!.accounts![index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          child: AccountItem(
                            function: () {
                              context
                                  .read<BankBloc>()
                                  .add(ChangeIndexBankEvent(index: index));
                              MyNavigatorManager.instance.bankAccountPush();
                            },
                            title: account.name!,
                            index: index,
                            length: state.bank!.accounts!.length - 1,
                          ),
                        );
                      });
                },
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40, left: 12, right: 12),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CalcButton(
                text: 'New Account',
                gradic: gradientButton,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                function: () {
                  showModalSheetAccountAdd(
                      context: context, nameController: controller);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
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
                        if (current.bank!.accounts!.length <= index) {
                          return false;
                        }
                        return previous.bank!.accounts![index] !=
                            current.bank!.accounts![index];
                      },
                      builder: (context, state) {
                        final acc = state.bank!.accounts![index];
                        return Text(
                          '\$${acc.price}',
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
