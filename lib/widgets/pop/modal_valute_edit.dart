import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forex_290/const/color.dart';
import 'package:forex_290/const/extention.dart';
import 'package:forex_290/valute/domain/bloc/valute_bloc.dart';
import 'package:forex_290/widgets/calc_button.dart';
import 'package:forex_290/widgets/pop/modal_choose_valute.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future showModalSheetValuteEdit(BuildContext context) async {
  return showCupertinoModalBottomSheet(
    context: context,
    builder: (context) => SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Material(
        color: Colors.transparent,
        child: Column(
          children: [
            Container(
                height: 72,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: bgSecondColor),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 12, right: 12, bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(child: Image.asset('assets/images/tire.png')),
                      const SizedBox(height: 15),
                      const Text(
                        'Editing quotes',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ],
                  ),
                )),
            const SizedBox(height: 10),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  BlocBuilder<ValuteBloc, ValuteState>(
                    builder: (context, state) {
                      return SliverList.builder(
                        itemCount: state.valutePair.length,
                        itemBuilder: (context, index) {
                          final pair = state.valutePair[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: bgSecondColor),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                              'assets/images/valute/${state.valutePair[index].pairValute.toSymbol}.png'),
                                          const SizedBox(width: 5),
                                          Text(
                                            pair.pairValute,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        '${state.valutePair[index].price}',
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        '${state.valutePair[index].changePrice < 0 ? '' : '+'}${state.valutePair[index].changePrice.toStringAsFixed(4)}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: state.valutePair[index]
                                                        .changePrice >=
                                                    0.0
                                                ? Colors.green
                                                : Colors.red),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 117,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color: Colors.white
                                                    .withOpacity(0.12))),
                                        child: CalcButton(
                                          text: 'Choose',
                                          color: Colors.white.withOpacity(0.7),
                                          gradic: gradientTransparent,
                                          function: () =>
                                              showModalSheetChooseValute(
                                                  context: context,
                                                  index: index,
                                                  updateVal: pair),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
