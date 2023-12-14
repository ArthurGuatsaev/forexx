// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bank_bloc.dart';

class BankState {
  final BankModel? bank;
  final int index;
  const BankState({this.bank, this.index = 0});

  BankState copyWith({
    BankModel? bank,
    int? index,
  }) {
    return BankState(
      bank: bank ?? this.bank,
      index: index ?? this.index,
    );
  }
}
