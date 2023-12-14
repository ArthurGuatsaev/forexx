import 'package:flutter/material.dart';
import 'package:forex_290/bank/domain/repo/bank_repository.dart';
import 'package:forex_290/const/color.dart';
import 'package:forex_290/widgets/text_field.dart';

class CalcPage extends StatefulWidget {
  const CalcPage({super.key});

  @override
  State<CalcPage> createState() => _CalcPageState();
}

class _CalcPageState extends State<CalcPage> {
  late final TextEditingController controller = TextEditingController();
  late final TextEditingController percentController = TextEditingController();
  @override
  void initState() {
    percentController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    percentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: 144,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.transparent),
            child: Padding(
              padding: const EdgeInsets.only(top: 90),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                    ),
                    const Text(
                      'Calculator',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ]),
            ),
          ),
          const Text(
            'Enter the amount to calculate interest',
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w400, color: Colors.white),
          ),
          const SizedBox(height: 15),
          VTextField(
            maxSymbol: 10,
            controller: controller,
            hint: controller.text.isEmpty ? '0' : controller.text,
            enabled: false,
          ),
          const SizedBox(height: 10),
          MySlider(controller: percentController),
          const Text(
            'Result',
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w400, color: Colors.white),
          ),
          const SizedBox(height: 5),
          Text(
            '\$ ${(BankRepository.overpaymentDouble(price: double.tryParse(controller.text), persent: double.tryParse(percentController.text)) + (double.tryParse(controller.text) ?? 0)).toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w700,
              color: controller.text.isEmpty
                  ? Colors.white.withOpacity(0.3)
                  : Colors.white,
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Center(
              child: Wrap(
                direction: Axis.horizontal,
                spacing: (MediaQuery.of(context).size.width - 100) * 0.1,
                runSpacing: 20,
                children: [
                  for (var i = 1; i <= 11; i++)
                    Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(24),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(24),
                        onTap: () {
                          setState(() {
                            if (controller.text.length > 9 && i != 10) return;
                            if (controller.text.isEmpty && i >= 10) return;
                            if (i == 10 && controller.text.isNotEmpty) {
                              controller.text = controller.text
                                  .substring(0, controller.text.length - 1);
                            } else {
                              if (i == 10) controller.clear();
                              controller.text =
                                  '${controller.text}${i == 11 ? 0 : i}';
                            }
                          });
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: bgSecondColor),
                          height:
                              (MediaQuery.of(context).size.width - 100) * 0.2,
                          width:
                              (MediaQuery.of(context).size.width - 100) * 0.2,
                          child: Center(
                            child: Text(
                              '${i == 10 ? '' : i == 11 ? '0' : i}',
                              style: const TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
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
