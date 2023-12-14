import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forex_290/bank/domain/bloc/bank_bloc.dart';
import 'package:forex_290/bank/domain/models/bank_model.dart';
import 'package:forex_290/const/color.dart';
import 'package:forex_290/nav_manager.dart';
import 'package:forex_290/widgets/calc_button.dart';
import 'package:forex_290/widgets/text_field.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future showModalSheetCreditPay({
  required BuildContext context,
  required TextEditingController payController,
}) async {
  return showCupertinoModalBottomSheet(
    context: context,
    builder: (context) => ConstrainedBox(
      constraints:
          BoxConstraints.loose(Size(MediaQuery.of(context).size.width, 280)),
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
                const Center(
                  child: Text(
                    'Deposit amount',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                VTextField(
                  keyboardType: TextInputType.phone,
                  autofocus: true,
                  controller: payController,
                  hint: '\$1000.00',
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      'Your balance',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withOpacity(0.7)),
                    )),
                    const Text(
                      '\$100,000.00',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                CalcButton(
                  function: () {
                    if (payController.text.isEmpty) return;
                    final hist = BankHistory(
                        date: DateTime.now(),
                        price: double.tryParse(payController.text));
                    context
                        .read<BankBloc>()
                        .add(SaveHistCreditEvent(hist: hist));
                    payController.clear();
                    MyNavigatorManager.instance.bankPop();
                  },
                  text: 'Top up',
                  color: Colors.black,
                  gradic: gradientButton,
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
