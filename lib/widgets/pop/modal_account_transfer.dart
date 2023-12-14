import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forex_290/bank/domain/bloc/bank_bloc.dart';
import 'package:forex_290/bank/domain/models/bank_model.dart';
import 'package:forex_290/const/color.dart';
import 'package:forex_290/nav_manager.dart';
import 'package:forex_290/widgets/calc_button.dart';
import 'package:forex_290/widgets/pop_cupertino_entity.dart';
import 'package:forex_290/widgets/text_field.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future showModalSheetAccountTransfer({
  required BuildContext context,
  required BankAccount acc,
  required TextEditingController payController,
  required TextEditingController transferController,
}) async {
  return showCupertinoModalBottomSheet(
    context: context,
    builder: (context) => ConstrainedBox(
      constraints:
          BoxConstraints.loose(Size(MediaQuery.of(context).size.width, 400)),
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
                    'Transfer',
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
                      'Account balance',
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
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () => showSheetCustomEntity(
                      context: context, controller: transferController),
                  child: VTextField(
                    keyboardType: TextInputType.phone,
                    autofocus: true,
                    enabled: false,
                    controller: transferController,
                    hint: 'Choose account',
                  ),
                ),
                const SizedBox(height: 20),
                CalcButton(
                  function: () {
                    if (payController.text.isEmpty ||
                        transferController.text.isEmpty) {
                      return;
                    }
                    final trAcc = transferController.text;
                    if (trAcc == acc.name) {
                      return;
                    }
                    if (int.tryParse(payController.text) == null ||
                        acc.price! < int.tryParse(payController.text)!) {
                      return;
                    }
                    context.read<BankBloc>().add(TransferAccountEvent(
                        acc: acc,
                        trAcc: trAcc,
                        price: int.tryParse(payController.text) ?? 0));
                    payController.clear();
                    MyNavigatorManager.instance.bankPop();
                  },
                  text: 'Transfer',
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
