import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forex_290/const/color.dart';
import 'package:forex_290/nav_manager.dart';
import 'package:forex_290/valute/domain/bloc/valute_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future showModalSheet(BuildContext context, int index) async {
  return showCupertinoModalBottomSheet(
    context: context,
    builder: (context) => SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Material(
        color: Colors.transparent,
        child: Column(
          children: [
            Container(
              height: 142,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: bgSecondColor),
              child: BlocBuilder<ValuteBloc, ValuteState>(
                buildWhen: (previous, current) =>
                    previous.valutePair[index].pairValute !=
                    current.valutePair[index].pairValute,
                builder: (context, state) {
                  final pair = state.valutePair[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Center(child: Image.asset('assets/images/tire.png')),
                        const Spacer(),
                        Stack(
                          children: [
                            GestureDetector(
                              onTap: () =>
                                  MyNavigatorManager.instance.simulatorPop(),
                              child: const Row(
                                children: [
                                  const Icon(
                                    Icons.navigate_before,
                                    color: primary,
                                    size: 30,
                                  ),
                                  const Text(
                                    'Back',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400,
                                        color: primary),
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              child: Text(
                                pair.pairValute,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Text(
                            '${pair.price}',
                            style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Text(
                            '${pair.changePrice}',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: pair.changePrice < 0
                                    ? Colors.red
                                    : Colors.green),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12)),
                    color: bgSecondColor),
                child: BlocBuilder<ValuteBloc, ValuteState>(
                  buildWhen: (previous, current) =>
                      previous.valutePair[index].pairValute !=
                      current.valutePair[index].pairValute,
                  builder: (context, state) {
                    return Container(
                      padding: const EdgeInsets.only(bottom: 30),
                      color: bgSecondColor,
                      child: Image.asset('assets/images/chart.png'),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
