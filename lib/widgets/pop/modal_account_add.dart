import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forex_290/bank/domain/bloc/bank_bloc.dart';
import 'package:forex_290/bank/domain/models/bank_model.dart';
import 'package:forex_290/const/color.dart';
import 'package:forex_290/nav_manager.dart';
import 'package:forex_290/widgets/calc_button.dart';
import 'package:forex_290/widgets/text_field.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future showModalSheetAccountAdd({
  required BuildContext context,
  required TextEditingController nameController,
}) async {
  return showCupertinoModalBottomSheet(
    context: context,
    builder: (context) => ConstrainedBox(
      constraints:
          BoxConstraints.loose(Size(MediaQuery.of(context).size.width, 250)),
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
                    'New account',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                VTextField(
                  autofocus: true,
                  controller: nameController,
                  hint: 'Name',
                ),
                const SizedBox(height: 20),
                CalcButton(
                  function: () {
                    if (nameController.text.isEmpty) return;
                    final acc = BankAccount(
                      hist: [],
                      id: DateTime.now().microsecond,
                      name: nameController.text,
                      persent: 0,
                      price: 0,
                    );
                    context.read<BankBloc>().add(SaveAccountEvent(acc: acc));
                    MyNavigatorManager.instance.bankPop();
                  },
                  text: 'Create',
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
