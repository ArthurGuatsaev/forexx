import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forex_290/const/color.dart';
import 'package:forex_290/valute/domain/bloc/valute_bloc.dart';
import 'package:forex_290/widgets/calc_button.dart';
import 'package:forex_290/widgets/pop_cupertino_entity.dart';
import 'package:forex_290/widgets/text_field.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future showModalSheetProductAdd({
  required BuildContext context,
  required TextEditingController nameController,
  required TextEditingController valuteController,
  required TextEditingController descrController,
  required TextEditingController tagsController,
  required TextEditingController priceController,
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
                      'New Item',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    )),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.14,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white.withOpacity(0.12)),
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white.withOpacity(0.06)),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                    onTap: () {},
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset('assets/images/image.png'),
                                        const SizedBox(height: 10),
                                        const Text(
                                          'Add image',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white),
                                        )
                                      ],
                                    )),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.14,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white.withOpacity(0.12)),
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white.withOpacity(0.06)),
                              child: Material(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.transparent,
                                child: InkWell(
                                    child: BlocBuilder<ValuteBloc, ValuteState>(
                                  builder: (context, state) {
                                    return const SizedBox();
                                  },
                                )),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Name',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 5),
                    VTextField(controller: nameController, hint: 'Enter'),
                    const SizedBox(height: 10),
                    const Text(
                      'Currency',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 5),
                    GestureDetector(
                      onTap: () => showSheetCustomEntity(
                          context: context, controller: valuteController),
                      child: VTextField(
                        controller: valuteController,
                        hint: 'Choose',
                        enabled: false,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Price',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 5),
                    VTextField(
                      controller: priceController,
                      hint: '1000.00',
                      key: const ValueKey('price'),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Amount',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 5),
                    VTextField(controller: amountController, hint: '100'),
                    const SizedBox(height: 10),
                    const Text(
                      'Tags',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 5),
                    VTextField(controller: tagsController, hint: 'Enter'),
                    const SizedBox(height: 10),
                    const Text(
                      'Description',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 5),
                    VTextField(
                        controller: descrController,
                        hight: 250,
                        hint: 'Enter',
                        maxLines: 10),
                    const SizedBox(height: 20),
                    CalcButton(
                      function: () {},
                      text: 'Add',
                      gradic: gradientButton,
                    )
                  ]),
            ),
          ),
        ),
      ),
    ),
  );
}
