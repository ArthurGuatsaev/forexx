import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forex_290/const/color.dart';
import 'package:forex_290/nav_manager.dart';
import 'package:forex_290/news/domain/bloc/news_bloc.dart';
import 'package:forex_290/widgets/pop/modal_open_news.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future showModalSheetNews(BuildContext context) async {
  return showCupertinoModalBottomSheet(
    context: context,
    builder: (context) => SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Material(
        color: Colors.transparent,
        child: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 12, right: 12, bottom: 12),
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () => MyNavigatorManager.instance.simulatorPop(),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.navigate_before,
                              color: primary,
                              size: 30,
                            ),
                            Text(
                              'Back',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: primary),
                            ),
                          ],
                        ),
                      ),
                      const Center(
                        child: Text(
                          'News',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )),
            const SizedBox(height: 10),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  BlocBuilder<NewsBloc, NewsState>(
                    builder: (context, state) {
                      return SliverList.builder(
                        itemCount: state.news.length,
                        itemBuilder: (context, index) {
                          final news = state.news[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Material(
                              borderRadius: BorderRadius.circular(12),
                              color: bgSecondColor,
                              child: InkWell(
                                onTap: () {
                                  showModalSheetNewsItem(context, news);
                                },
                                child: SizedBox(
                                  height: 109,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          news.image.isNotEmpty
                                              ? ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  12),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  12)),
                                                  child: Image.network(
                                                    news.image,
                                                    height: 109,
                                                    width: 120,
                                                    fit: BoxFit.fitHeight,
                                                  ))
                                              : const SizedBox.shrink(),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 4,
                                                  bottom: 4,
                                                  left: 10,
                                                  right: 4),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    news.dateString,
                                                    style: TextStyle(
                                                        color: Colors.white
                                                            .withOpacity(0.7),
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  Text(
                                                    news.title,
                                                    maxLines: 2,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
