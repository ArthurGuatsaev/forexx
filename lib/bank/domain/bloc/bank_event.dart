// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bank_bloc.dart';

abstract class BankEvent extends Equatable {
  const BankEvent();

  @override
  List<Object> get props => [];
}

class CreateBankEvent extends BankEvent {
  final BankModel bank;
  const CreateBankEvent({
    required this.bank,
  });
}

class ChangeIndexBankEvent extends BankEvent {
  final int index;
  const ChangeIndexBankEvent({
    required this.index,
  });
}

class GetBankEvent extends BankEvent {}

class FirstGetBankEvent extends BankEvent {}

class ReseteBankEvent extends BankEvent {}

class DeleteDepositeEvent extends BankEvent {
  final BankDiposit depo;
  const DeleteDepositeEvent({
    required this.depo,
  });
}

class DeleteAccountEvent extends BankEvent {
  final BankAccount acc;
  const DeleteAccountEvent({
    required this.acc,
  });
}

class DeleteInvestEvent extends BankEvent {
  final BankInvest inv;
  const DeleteInvestEvent({
    required this.inv,
  });
}

class SaveDepositeEvent extends BankEvent {
  final BankDiposit depo;
  const SaveDepositeEvent({
    required this.depo,
  });
}

class TopUpDepositEvent extends BankEvent {
  final BankDiposit depo;
  final int price;
  const TopUpDepositEvent({
    required this.depo,
    required this.price,
  });
}

class SaveAccountEvent extends BankEvent {
  final BankAccount acc;
  const SaveAccountEvent({
    required this.acc,
  });
}

class SaveHistCreditEvent extends BankEvent {
  final BankHistory hist;
  const SaveHistCreditEvent({
    required this.hist,
  });
}

class SaveHistAccountEvent extends BankEvent {
  final BankHistory hist;
  const SaveHistAccountEvent({
    required this.hist,
  });
}

class TransferAccountEvent extends BankEvent {
  final BankAccount acc;
  final String trAcc;
  final int price;
  const TransferAccountEvent({
    required this.acc,
    required this.trAcc,
    required this.price,
  });
}

class DeleteCreditEvent extends BankEvent {
  final BankCredit cred;
  const DeleteCreditEvent({
    required this.cred,
  });
}

class SaveCreditEvent extends BankEvent {
  final BankCredit cred;
  const SaveCreditEvent({
    required this.cred,
  });
}

class SaveInvestEvent extends BankEvent {
  final BankInvest invest;
  const SaveInvestEvent({
    required this.invest,
  });
}
