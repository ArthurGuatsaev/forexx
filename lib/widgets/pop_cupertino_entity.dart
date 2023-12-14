import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forex_290/bank/domain/bloc/bank_bloc.dart';
import 'package:forex_290/const/color.dart';

showSheetCustomEntity({
  required BuildContext context,
  required TextEditingController controller,
}) {
  return showCupertinoModalPopup(
    context: context,
    builder: (context) {
      return Material(
        child: Container(
          color: bgSecondColor,
          height: 400,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 12, top: 20, right: 12, bottom: 40),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      'Choose account',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 200,
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                      textTheme: CupertinoTextThemeData(
                          pickerTextStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.5)))),
                  child: BlocBuilder<BankBloc, BankState>(
                    buildWhen: (previous, current) =>
                        previous.bank!.accounts != current.bank!.accounts,
                    builder: (context, state) {
                      return CupertinoPicker(
                        magnification: 1.22,
                        squeeze: 1.2,
                        useMagnifier: true,
                        itemExtent: 31,
                        scrollController: FixedExtentScrollController(
                          initialItem: 0,
                        ),
                        onSelectedItemChanged: (value) => controller.text =
                            state.bank!.accounts![value].name!,
                        children: List.generate(
                          state.bank!.accounts!.length,
                          (index) => Center(
                            child: Text(state.bank!.accounts![index].name!),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ]),
          ),
        ),
      );
    },
  );
}
