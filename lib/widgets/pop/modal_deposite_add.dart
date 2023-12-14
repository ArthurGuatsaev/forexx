import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forex_290/bank/domain/bloc/bank_bloc.dart';
import 'package:forex_290/bank/domain/models/bank_model.dart';
import 'package:forex_290/const/color.dart';
import 'package:forex_290/nav_manager.dart';
import 'package:forex_290/widgets/calc_button.dart';
import 'package:forex_290/widgets/text_field.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future showModalSheetDepositeAdd({
  required BuildContext context,
  required TextEditingController nameController,
  required TextEditingController percentController,
}) async {
  return showCupertinoModalBottomSheet(
    context: context,
    builder: (context) => ConstrainedBox(
      constraints:
          BoxConstraints.loose(Size(MediaQuery.of(context).size.width, 350)),
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
                    'New deposit',
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
                MySlider(
                  controller: percentController,
                ),
                const SizedBox(height: 20),
                CalcButton(
                  function: () {
                    if (percentController.text.isEmpty ||
                        nameController.text.isEmpty) {
                      return;
                    }
                    final depo = BankDiposit(
                      id: DateTime.now().microsecond,
                      persent: double.tryParse(percentController.text) ?? 0,
                      name: nameController.text,
                      price: 0,
                    );
                    context.read<BankBloc>().add(SaveDepositeEvent(depo: depo));
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
  const MySlider({
    super.key,
    required this.controller,
  });

  @override
  State<MySlider> createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
      ],
    );
  }
}
