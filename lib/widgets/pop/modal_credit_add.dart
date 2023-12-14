import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forex_290/bank/domain/bloc/bank_bloc.dart';
import 'package:forex_290/bank/domain/models/bank_model.dart';
import 'package:forex_290/bank/domain/repo/bank_repository.dart';
import 'package:forex_290/const/color.dart';
import 'package:forex_290/nav_manager.dart';
import 'package:forex_290/widgets/calc_button.dart';
import 'package:forex_290/widgets/pop_cupertino_credit.dart';
import 'package:forex_290/widgets/text_field.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future showModalSheetCreditAdd({
  required BuildContext context,
  required TextEditingController priceController,
  required TextEditingController periodController,
  required TextEditingController percentController,
}) async {
  return showCupertinoModalBottomSheet(
    context: context,
    builder: (context) => ConstrainedBox(
      constraints:
          BoxConstraints.loose(Size(MediaQuery.of(context).size.width, 480)),
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
                    'New credit',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10),
                MySlider(
                  controller: percentController,
                  priceController: priceController,
                  periodController: periodController,
                ),
                const SizedBox(height: 15),
                CalcButton(
                  function: () {
                    if (priceController.text.isEmpty ||
                        percentController.text.isEmpty ||
                        periodController.text.isEmpty) {
                      return;
                    }
                    final cred = BankCredit(
                        hist: [],
                        id: DateTime.now().microsecond,
                        price: int.tryParse(priceController.text) ?? 0,
                        persent: double.tryParse(percentController.text) ?? 0,
                        period: int.tryParse(periodController.text) ?? 0);
                    context.read<BankBloc>().add(SaveCreditEvent(cred: cred));
                    percentController.clear();
                    priceController.clear();
                    periodController.clear();
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

class MySlider extends StatefulWidget {
  final TextEditingController controller;
  final TextEditingController? priceController;
  final TextEditingController? periodController;
  const MySlider({
    super.key,
    required this.controller,
    this.periodController,
    this.priceController,
  });

  @override
  State<MySlider> createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  @override
  void initState() {
    super.initState();
    widget.priceController!.addListener(() {
      setState(() {});
    });
    widget.periodController!.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    widget.priceController!.dispose();
    widget.periodController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VTextField(
          autofocus: true,
          keyboardType: TextInputType.phone,
          inputAction: TextInputAction.next,
          controller: widget.priceController!,
          hint: '\$100000',
        ),
        const SizedBox(height: 15),
        GestureDetector(
          onTap: () => showSheetCreditPeriod(
              context: context, controller: widget.periodController!),
          child: VTextField(
            keyboardType: TextInputType.phone,
            autofocus: true,
            enabled: false,
            controller: widget.periodController!,
            hint: 'Choose a period',
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
                child: Text(
              'Contribution percentage',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withOpacity(0.7)),
            )),
            Text(
              '${widget.controller.text.isEmpty ? 0 : double.parse(widget.controller.text).toStringAsFixed(2)}%',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            )
          ],
        ),
        Slider(
          thumbColor: Colors.white,
          inactiveColor: Colors.white.withOpacity(0.32),
          activeColor: primary,
          value: widget.controller.text.isEmpty
              ? 0
              : double.parse(widget.controller.text),
          min: 0,
          max: 50,
          onChanged: (value) {
            widget.controller.text = '$value';
            setState(() {});
          },
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
                child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Overpayment',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withOpacity(0.7)),
                  ),
                  Text(
                    '${BankRepository.overpayment(price: double.tryParse(widget.priceController!.text), persent: double.tryParse(widget.controller.text))}',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(0.3)),
                  ),
                ],
              ),
            )),
            Expanded(
                child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Daily payment',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withOpacity(0.7)),
                  ),
                  Text(
                    '\$${BankRepository.painmant(price: double.tryParse(widget.priceController!.text), persent: double.tryParse(widget.controller.text), period: int.tryParse(widget.periodController!.text))}',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(0.3)),
                  ),
                ],
              ),
            ))
          ],
        ),
      ],
    );
  }
}
