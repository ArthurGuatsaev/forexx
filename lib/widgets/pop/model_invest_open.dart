import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forex_290/bank/domain/bloc/bank_bloc.dart';
import 'package:forex_290/bank/domain/models/bank_model.dart';
import 'package:forex_290/bank/domain/repo/bank_repository.dart';
import 'package:forex_290/const/color.dart';
import 'package:forex_290/nav_manager.dart';
import 'package:forex_290/widgets/calc_button.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future showModalSheetInvestOpen({
  required BuildContext context,
  required BankInvest invest,
}) async {
  return showCupertinoModalBottomSheet(
    context: context,
    builder: (context) => SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9), color: bgSecondColor),
          child: Padding(
            padding: const EdgeInsets.only(right: 12, left: 12, bottom: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Center(child: Image.asset('assets/images/tire.png')),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    invest.title!,
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  '\$${invest.price}',
                  style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                const SizedBox(height: 5),
                Text(
                  '+\$${BankRepository.overpayment(price: invest.price, persent: invest.persent)}',
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.green),
                ),
                const SizedBox(height: 20),
                CalcButton(
                  function: () {
                    context
                        .read<BankBloc>()
                        .add(DeleteInvestEvent(inv: invest));
                    MyNavigatorManager.instance.simulatorPop();
                  },
                  text: 'Close deposit',
                  color: Colors.black,
                  gradic: gradientButton,
                ),
                const SizedBox(height: 15),
                // Text(
                //   'Money will be credited to the main balance',
                //   style: TextStyle(
                //       fontSize: 15,
                //       fontWeight: FontWeight.w400,
                //       color: Colors.white.withOpacity(0.7)),
                // ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
