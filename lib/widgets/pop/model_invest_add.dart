import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forex_290/bank/domain/bloc/bank_bloc.dart';
import 'package:forex_290/bank/domain/models/bank_model.dart';
import 'package:forex_290/const/color.dart';
import 'package:forex_290/nav_manager.dart';
import 'package:forex_290/widgets/calc_button.dart';
import 'package:forex_290/widgets/text_field.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future showModalSheetInvestAdd({
  required BuildContext context,
  required TextEditingController nameController,
  required TextEditingController riskController,
  required TextEditingController amountController,
}) async {
  return showCupertinoModalBottomSheet(
    context: context,
    builder: (context) => SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Material(
        color: Colors.transparent,
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                color: Colors.transparent),
            child: Padding(
              padding: const EdgeInsets.only(right: 12, left: 12, bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Center(child: Image.asset('assets/images/tire.png')),
                  const SizedBox(height: 10),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () => MyNavigatorManager.instance.simulatorPop(),
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
                      const Center(
                        child: Text(
                          'New contribution',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Company name',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 5),
                  VTextField(
                    controller: nameController,
                    hint: 'Enter',
                    key: const ValueKey('name'),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Invested amount',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 5),
                  VTextField(controller: amountController, hint: '\$10,000.00'),
                  const SizedBox(height: 10),
                  const Text(
                    'Deposit risk',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 5),
                  VTextField(
                    controller: riskController,
                    hint: '0%',
                  ),
                  const SizedBox(height: 20),
                  CalcButton(
                    function: () {
                      if (amountController.text.isEmpty ||
                          riskController.text.isEmpty ||
                          nameController.text.isEmpty) {
                        return;
                      }
                      final inv = BankInvest(
                          id: DateTime.now().millisecond,
                          date: DateTime.now(),
                          persent: double.tryParse(riskController.text) ?? 0,
                          price: double.tryParse(amountController.text) ?? 0,
                          title: nameController.text);
                      context
                          .read<BankBloc>()
                          .add(SaveInvestEvent(invest: inv));
                      MyNavigatorManager.instance.simulatorPop();
                    },
                    text: 'Add',
                    color: Colors.black,
                    gradic: gradientButton,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
