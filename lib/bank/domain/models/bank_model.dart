// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar/isar.dart';

part 'bank_model.g.dart';

@collection
class BankModel {
  Id? id = Isar.autoIncrement;
  String? name;
  List<BankAccount>? accounts;
  List<BankInvest>? invests;
  List<BankDiposit>? deposits;
  List<BankCredit>? credits;
  BankModel({
    this.name,
    this.id,
    this.accounts,
    this.credits,
    this.deposits,
    this.invests,
  });
  @ignore
  String get balance {
    if (accounts!.isEmpty && invests!.isNotEmpty) {
      return invests!
          .map((e) => e.price)
          .toList()
          .reduce((value, element) => value! + element!)!
          .toStringAsFixed(2);
    }
    if (accounts!.isNotEmpty && invests!.isEmpty) {
      return accounts!
          .map((e) => e.price)
          .toList()
          .reduce((value, element) => value! + element!)!
          .toStringAsFixed(2);
    }
    if (accounts!.isEmpty && invests!.isEmpty) {
      return '0';
    }
    final acc = accounts!
        .map((e) => e.price)
        .toList()
        .reduce((value, element) => value! + element!);
    final invest = invests!
        .map((e) => e.price)
        .toList()
        .reduce((value, element) => value! + element!);
    return (acc! + invest!).toStringAsFixed(2);
  }

  BankModel copyWith({
    Id? id,
    String? name,
    List<BankAccount>? accounts,
    List<BankDiposit>? deposits,
    List<BankInvest>? invests,
    List<BankCredit>? credits,
  }) {
    return BankModel(
      id: id ?? this.id,
      name: name ?? this.name,
      invests: invests ?? this.invests,
      accounts: accounts ?? this.accounts,
      deposits: deposits ?? this.deposits,
      credits: credits ?? this.credits,
    );
  }
}

@embedded
class BankAccount {
  int? id;
  String? name;
  double? persent;
  int? price;
  List<BankHistory>? hist;
  BankAccount({this.name, this.persent, this.price, this.hist, this.id});

  BankAccount copyWith({
    int? id,
    String? name,
    double? persent,
    int? price,
    List<BankHistory>? hist,
  }) {
    return BankAccount(
      id: id ?? this.id,
      name: name ?? this.name,
      persent: persent ?? this.persent,
      price: price ?? this.price,
      hist: hist ?? this.hist,
    );
  }
}

@embedded
class BankDiposit {
  int? id;
  String? name;
  double? persent;
  int? price;
  BankDiposit({this.name, this.persent, this.price, this.id});

  BankDiposit copyWith({
    int? id,
    String? name,
    double? persent,
    int? price,
  }) {
    return BankDiposit(
      id: id ?? this.id,
      name: name ?? this.name,
      persent: persent ?? this.persent,
      price: price ?? this.price,
    );
  }
}

@embedded
class BankCredit {
  int? id;
  double? persent;
  int? price;
  int? period;
  List<BankHistory>? hist;
  @ignore
  double get paimant {
    return ((price! * persent! / 100) + price!) / (period! * 12);
  }

  BankCredit({this.period, this.persent, this.price, this.hist, this.id});

  BankCredit copyWith({
    int? id,
    double? persent,
    int? price,
    int? period,
    List<BankHistory>? hist,
  }) {
    return BankCredit(
      id: id ?? this.id,
      persent: persent ?? this.persent,
      price: price ?? this.price,
      period: period ?? this.period,
      hist: hist ?? this.hist,
    );
  }
}

@embedded
class BankHistory {
  DateTime? date;
  double? price;
  String? title;
  BankHistory({this.date, this.price, this.title});
  @ignore
  String get dateString {
    final month =
        '${date!.month}'.length < 2 ? '0${date!.month}' : '${date!.month}';
    final day = '${date!.day}'.length < 2 ? '0${date!.day}' : '${date!.day}';
    return '$day.$month.${date!.year}';
  }
}

@embedded
class BankInvest {
  DateTime? date;
  int? id;
  double? price;
  String? title;
  double? persent;
  BankInvest({this.date, this.price, this.title, this.id, this.persent});
  @ignore
  String get dateString {
    final month =
        '${date!.month}'.length < 2 ? '0${date!.month}' : '${date!.month}';
    final day = '${date!.day}'.length < 2 ? '0${date!.day}' : '${date!.day}';
    return '$day.$month.${date!.year}';
  }

  BankInvest copyWith({
    int? id,
    DateTime? date,
    double? price,
    String? title,
    double? persent,
  }) {
    return BankInvest(
      date: date ?? this.date,
      id: id ?? this.id,
      price: price ?? this.price,
      title: title ?? this.title,
      persent: persent ?? this.persent,
    );
  }
}
