import 'package:flutter/material.dart';
import 'package:forex_290/pages/newNav/account/account_page.dart';
import 'package:forex_290/pages/newNav/account/accounts.dart';
import 'package:forex_290/pages/newNav/credit/credit_face.dart';
import 'package:forex_290/pages/newNav/credit/credit_page.dart';
import 'package:forex_290/pages/newNav/deposite/deposits.dart';
import 'package:forex_290/pages/newNav/settings.dart';
import 'package:forex_290/pages/profile_page.dart';

class BankNavi extends StatelessWidget {
  const BankNavi({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/account':
            return AccountPage.route();
          case '/deposits':
            return BankDeposites.route();
          case '/credit':
            return BankCredit.route();
          case '/setting':
            return SettingsPage.route();
          case '/':
            return ProfilePage.route();
          case '/accounts':
            return BankAccounts.route();
          case '/cred':
            return CreditFace.route();
          default:
            return ProfilePage.route();
        }
      },
    );
  }
}
