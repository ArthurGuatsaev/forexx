// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forex_290/loading/view/bloc/load_bloc.dart';
import 'package:forex_290/loading/view/ui/onboard/widgets/indicator.dart';
import 'package:forex_290/widgets/calc_button.dart';

class VBaseBoard extends StatelessWidget {
  final VBoardParam boardParam;
  final int entity;
  const VBaseBoard({
    Key? key,
    required this.entity,
    required this.boardParam,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              boardParam.image,
              alignment: Alignment.bottomCenter,
              fit: BoxFit.fitWidth,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.transparent),
                child: Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15, top: 60),
                  child: Column(
                    children: [
                      BlocBuilder<LoadBloc, LoadState>(
                        buildWhen: (previous, current) =>
                            previous.onboardIndex != current.onboardIndex,
                        builder: (context, state) {
                          return SizedBox(
                            height: 6,
                            width: MediaQuery.of(context).size.width,
                            child: MyCheckBox(
                              index: state.onboardIndex,
                              entity: entity,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 70),
                      Text(
                        boardParam.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Color(0xFFFEB81E),
                            fontSize: 34,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        child: DecoratedBox(
                          decoration: const BoxDecoration(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            child: Text(
                              boardParam.body,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50, left: 12, right: 12),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 48,
                child: CalcButton(
                    text: boardParam.buttonText,
                    color: Colors.black,
                    function: boardParam.function,
                    fontSize: 16,
                    gradic: _gradient,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VBoardParam {
  final String? tg;
  final String image;
  final String title;
  final String body;
  final String buttonText;
  final Function()? function;
  VBoardParam({
    this.tg,
    this.function,
    required this.image,
    required this.title,
    required this.body,
    required this.buttonText,
  });
}

const boxColor = Color(0xFF0D1116);
const _gradient = LinearGradient(colors: [
  Color(0xFFFEB81E),
  Color(0xFFFEB81E),
]);
