import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forex_290/bank/domain/bloc/bank_bloc.dart';
import 'package:forex_290/const/color.dart';
import 'package:forex_290/const/extention.dart';
import 'package:forex_290/news/domain/bloc/news_bloc.dart';
import 'package:forex_290/valute/domain/bloc/valute_bloc.dart';
import 'package:forex_290/widgets/pop/modal_news.dart';
import 'package:forex_290/widgets/pop/modal_valute_chart.dart';
import 'package:forex_290/widgets/pop/modal_valute_edit.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    context.read<BankBloc>().add(GetBankEvent());
    context.read<NewsBloc>().add(GetNewsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 144,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: bgSecondColor),
            child: Padding(
              padding: const EdgeInsets.only(top: 90, left: 12, right: 12),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/main.png',
                          color: primary,
                        ),
                        const SizedBox(width: 10),
                        BlocBuilder<BankBloc, BankState>(
                          buildWhen: (previous, current) =>
                              previous.bank != current.bank,
                          builder: (context, state) {
                            return Text(
                              state.bank?.name!.toFirstLetter ?? 'Bank',
                              style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            );
                          },
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
          const SizedBox(height: 15),
          Column(
            children: [
              Container(
                height: 90,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: bgSecondColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bank balance',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(0.7)),
                    ),
                    SizedBox(
                      height: 10,
                      width: MediaQuery.of(context).size.width,
                    ),
                    BlocBuilder<BankBloc, BankState>(
                      buildWhen: (previous, current) =>
                          current.bank?.balance != previous.bank?.balance,
                      builder: (context, state) {
                        return Text(
                          '\$${state.bank?.balance ?? 0}',
                          style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const Expanded(
                  child: Text(
                'News',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              )),
              GestureDetector(
                onTap: () => showModalSheetNews(context),
                child: const Text(
                  'See all',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primary),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 109,
            child: BlocBuilder<NewsBloc, NewsState>(
              builder: (context, state) {
                return ListView.builder(
                  itemExtent: 300,
                  scrollDirection: Axis.horizontal,
                  itemCount: state.news.length,
                  itemBuilder: (context, index) => Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: bgSecondColor),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.news[index].dateString,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.white.withOpacity(0.7)),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            state.news[index].title,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ]),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const Expanded(
                  child: Text(
                'Exchange rates',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              )),
              GestureDetector(
                onTap: () => showModalSheetValuteEdit(context),
                child: const Text(
                  'Edit',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primary),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 90,
            child: BlocBuilder<ValuteBloc, ValuteState>(
              buildWhen: (previous, current) =>
                  previous.valutePair.length != current.valutePair.length,
              builder: (context, state) {
                return ListView.builder(
                    itemExtent: 153,
                    itemCount: state.valutePair.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            color: bgSecondColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => showModalSheet(context, index),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                          'assets/images/valute/${state.valutePair[index].pairValute.toSymbol}.png'),
                                      const SizedBox(width: 3),
                                      Text(
                                        state.valutePair[index].pairValute,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '\$${state.valutePair[index].price}',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '${state.valutePair[index].changePrice > 0 ? '+' : ''}${state.valutePair[index].changePrice}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: state.valutePair[index]
                                                    .changePrice >
                                                0
                                            ? Colors.green
                                            : Colors.red),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
