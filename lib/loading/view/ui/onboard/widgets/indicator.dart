import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forex_290/loading/view/bloc/load_bloc.dart';

class MyCheckBox extends StatelessWidget {
  final int index;
  final int entity;
  const MyCheckBox({super.key, required this.index, required this.entity});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < entity; i++)
            Expanded(
              child: GestureDetector(
                onTap: () {
                  context
                      .read<LoadBloc>()
                      .add(ChangeOnbIndicatorEvent(index: i));
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: SizedBox(
                    height: 6,
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(23),
                            color: i <= index
                                ? const Color(0xFFFEB81E)
                                : Colors.white.withOpacity(0.12))),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

final _indicatorDisActive = LinearGradient(colors: [
  Colors.grey.withOpacity(0.3),
  Colors.grey.withOpacity(0.3),
]);
const _gradient = LinearGradient(colors: [
  Colors.white,
  Colors.white,
]);
