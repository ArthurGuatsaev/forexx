import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:forex_290/bank/domain/models/bank_model.dart';
import 'package:forex_290/bank/domain/repo/bank_repository.dart';
import 'package:forex_290/nav_manager.dart';

part 'bank_event.dart';
part 'bank_state.dart';

class BankBloc extends Bloc<BankEvent, BankState> {
  final BankRepository bankRepo;
  BankBloc({required this.bankRepo}) : super(const BankState()) {
    on<CreateBankEvent>(createBank);
    on<GetBankEvent>(getBank);
    on<FirstGetBankEvent>(firstGetBank);
    on<ReseteBankEvent>(reseteBank);
    on<ChangeIndexBankEvent>(changeIndex);
    on<DeleteAccountEvent>(deleteAccount);
    on<DeleteDepositeEvent>(deleteDiposit);
    on<DeleteInvestEvent>(deleteInvest);
    on<DeleteCreditEvent>(deleteCredit);
    on<SaveAccountEvent>(saveAccount);
    on<SaveDepositeEvent>(saveDipodit);
    on<SaveCreditEvent>(saveCredit);
    on<SaveInvestEvent>(saveInvest);
    on<SaveHistAccountEvent>(saveHistAccount);
    on<SaveHistCreditEvent>(saveHistCredit);
    on<TransferAccountEvent>(transferAccount);
    on<TopUpDepositEvent>(topUpDeposit);
  }

  createBank(CreateBankEvent event, Emitter<BankState> emit) async {
    await bankRepo.saveBank(
        bank: event.bank.copyWith(
      accounts: [],
      deposits: [],
      credits: [],
      invests: [],
    ));
    add(GetBankEvent());
  }

  getBank(GetBankEvent event, Emitter<BankState> emit) async {
    final bank = await bankRepo.getBank();
    emit(state.copyWith(bank: bank));
  }

  changeIndex(ChangeIndexBankEvent event, Emitter<BankState> emit) async {
    emit(state.copyWith(index: event.index));
  }

  firstGetBank(FirstGetBankEvent event, Emitter<BankState> emit) async {
    final bank = bankRepo.bank;
    if (bank == null) {
      return add(GetBankEvent());
    }
    emit(state.copyWith(bank: bank));
  }

  reseteBank(ReseteBankEvent event, Emitter<BankState> emit) async {
    await bankRepo.reseteHistory();
    MyNavigatorManager.instance.untilPop();
  }

  deleteDiposit(DeleteDepositeEvent event, Emitter<BankState> emit) async {
    final depo = state.bank!.deposits!
        .where((element) =>
            element.name != event.depo.name &&
            element.price != event.depo.price)
        .toList();
    await bankRepo.update(state.bank!.copyWith(deposits: depo));
    add(GetBankEvent());
  }

  deleteAccount(DeleteAccountEvent event, Emitter<BankState> emit) async {
    final acc = [
      ...state.bank!.accounts!
          .where((element) => element.id != event.acc.id)
          .toList()
    ];
    await bankRepo.update(state.bank!.copyWith(accounts: acc));
    add(GetBankEvent());
  }

  deleteInvest(DeleteInvestEvent event, Emitter<BankState> emit) async {
    final inv = [
      ...state.bank!.invests!
          .where((element) => element.id != event.inv.id)
          .toList()
    ];
    await bankRepo.update(state.bank!.copyWith(invests: inv));
    add(GetBankEvent());
  }

  deleteCredit(DeleteCreditEvent event, Emitter<BankState> emit) async {
    final cred = state.bank!.credits!
        .where((element) => element.id != event.cred.id)
        .toList();
    await bankRepo.update(state.bank!.copyWith(credits: cred));
    add(GetBankEvent());
  }

  saveInvest(SaveInvestEvent event, Emitter<BankState> emit) async {
    final invest = [...state.bank!.invests!, event.invest];
    await bankRepo.update(state.bank!.copyWith(invests: invest));
    add(GetBankEvent());
  }

  saveCredit(SaveCreditEvent event, Emitter<BankState> emit) async {
    final cred = [...state.bank!.credits!, event.cred];
    await bankRepo.update(state.bank!.copyWith(credits: cred));
    add(GetBankEvent());
  }

  saveDipodit(SaveDepositeEvent event, Emitter<BankState> emit) async {
    final depo = [...state.bank!.deposits!, event.depo];
    await bankRepo.update(state.bank!.copyWith(deposits: depo));
    add(GetBankEvent());
  }

  topUpDeposit(TopUpDepositEvent event, Emitter<BankState> emit) async {
    final depo = [...state.bank!.deposits!];
    final res = depo
        .map((e) => e.id == event.depo.id
            ? e.copyWith(price: e.price! + event.price)
            : e)
        .toList();
    await bankRepo.update(state.bank!.copyWith(deposits: res));
    add(GetBankEvent());
  }

  saveAccount(SaveAccountEvent event, Emitter<BankState> emit) async {
    final acc = [...state.bank!.accounts!, event.acc];
    await bankRepo.update(state.bank!.copyWith(accounts: acc));
    add(GetBankEvent());
  }

  transferAccount(TransferAccountEvent event, Emitter<BankState> emit) async {
    final acc = event.acc;
    final trAcc = state.bank!.accounts!
        .where((element) => element.name == event.trAcc)
        .first;
    final acounts = [
      ...state.bank!.accounts!.map((element) {
        if (element.id == acc.id) {
          return acc.copyWith(price: acc.price! - event.price);
        }
        if (element.id == trAcc.id) {
          return trAcc.copyWith(price: trAcc.price! + event.price);
        }
        return element;
      }).toList()
    ];
    await bankRepo.update(state.bank!.copyWith(accounts: acounts));
    add(SaveHistAccountEvent(
        hist: BankHistory(
            date: DateTime.now(),
            price: event.price.toDouble(),
            title: 'Transfer between accounts')));
  }

  saveHistAccount(SaveHistAccountEvent event, Emitter<BankState> emit) async {
    final hist = [...state.bank!.accounts![state.index].hist!, event.hist];
    final price = state.bank!.accounts![state.index].price! + hist.last.price!;
    final account = state.bank!.accounts![state.index]
        .copyWith(hist: hist, price: price.toInt());
    final ac = [...state.bank!.accounts!];
    final acc = ac.map((e) => e.id == account.id ? account : e).toList();
    await bankRepo.update(state.bank!.copyWith(accounts: acc));
    add(GetBankEvent());
  }

  saveHistCredit(SaveHistCreditEvent event, Emitter<BankState> emit) async {
    final hist = [...state.bank!.credits![state.index].hist!, event.hist];

    final credit = state.bank!.credits![state.index].copyWith(hist: hist);
    final cre = [...state.bank!.credits!];
    final cred = cre.map((e) => e.id == credit.id ? credit : e).toList();
    await bankRepo.update(state.bank!.copyWith(credits: cred));
    add(GetBankEvent());
  }
}
