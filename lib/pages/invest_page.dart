import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forex_290/bank/domain/bloc/bank_bloc.dart';
import 'package:forex_290/bank/domain/repo/bank_repository.dart';
import 'package:forex_290/const/color.dart';
import 'package:forex_290/widgets/calc_button.dart';
import 'package:forex_290/widgets/pop/model_invest_open.dart';
import 'package:forex_290/widgets/pop/model_invest_add.dart';

class InvestPage extends StatelessWidget {
  const InvestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: BlocBuilder<BankBloc, BankState>(
          buildWhen: (previous, current) =>
              previous.bank?.invests != current.bank?.invests,
          builder: (context, state) {
            if (state.bank == null || state.bank!.invests!.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/invest_empty.png'),
                          const Text(
                            'Empty',
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                          Text(
                            "You don't have any Investing added yet",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.white.withOpacity(0.7)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                      height: 48,
                      child: CalcButton(
                        text: 'To invest money',
                        color: Colors.black,
                        gradic: gradientButton,
                        function: () => showModalSheetInvestAdd(
                            amountController: TextEditingController(),
                            context: context,
                            nameController: TextEditingController(),
                            riskController: TextEditingController()),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              );
            }
            return Stack(
              children: [
                CustomScrollView(slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      height: 144,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.transparent),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 90),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                            ),
                            const Text(
                              'Investing',
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverList.builder(
                      itemCount:
                          state.bank != null ? state.bank!.invests!.length : 0,
                      itemBuilder: (context, index) {
                        final invest = state.bank!.invests![index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          height: 69,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: bgSecondColor),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => showModalSheetInvestOpen(
                                  context: context, invest: invest),
                              child: Row(children: [
                                Expanded(
                                    child: Text(
                                  invest.title!,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                )),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '\$${invest.price}',
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      '+\$${BankRepository.overpayment(price: invest.price, persent: invest.persent)}',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.green),
                                    ),
                                  ],
                                )
                              ]),
                            ),
                          ),
                        );
                      })
                ]),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                        height: 48,
                        child: CalcButton(
                          text: 'To invest money',
                          color: Colors.black,
                          gradic: gradientButton,
                          function: () => showModalSheetInvestAdd(
                              amountController: TextEditingController(),
                              context: context,
                              nameController: TextEditingController(),
                              riskController: TextEditingController()),
                        )),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
