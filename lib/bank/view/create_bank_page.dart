import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forex_290/bank/domain/bloc/bank_bloc.dart';
import 'package:forex_290/bank/domain/models/bank_model.dart';
import 'package:forex_290/const/color.dart';
import 'package:forex_290/nav_manager.dart';
import 'package:forex_290/widgets/calc_button.dart';
import 'package:forex_290/widgets/text_field.dart';

class CreateBank extends StatefulWidget {
  static const String routeName = '/bank';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => const CreateBank());
  }

  const CreateBank({super.key});

  @override
  State<CreateBank> createState() => _CreateBankState();
}

class _CreateBankState extends State<CreateBank> {
  late final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 200),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            'New Bank',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Create your own bank, get a starting balance and start your development',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 40),
          VTextField(
            alignVertical: TextAlignVertical.center,
            controller: controller,
            hint: 'Enter',
            hight: 48,
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 48,
            child: CalcButton(
              text: 'Create',
              gradic: gradientButton,
              color: Colors.black,
              function: () {
                if (controller.text.isEmpty) return;
                final bank = BankModel()..name = controller.text;
                context.read<BankBloc>().add(CreateBankEvent(bank: bank));
                MyNavigatorManager.instance.homePush();
              },
            ),
          )
        ]),
      ),
    );
  }
}
