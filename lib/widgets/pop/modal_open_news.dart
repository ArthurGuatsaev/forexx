import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:forex_290/news/domain/model/news.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future showModalSheetNewsItem(BuildContext context, News news) async {
  return showCupertinoModalBottomSheet(
    context: context,
    builder: (context) => SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Material(
        color: Colors.transparent,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
                child: Image.network(news.image,
                    height: MediaQuery.of(context).size.height / 3.5,
                    fit: BoxFit.fitHeight)),
            SliverToBoxAdapter(
                child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    child: Text(
                      news.title,
                      style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            )),
            SliverToBoxAdapter(
                child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    child: Text(
                      news.subtitle + news.description,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(0.7)),
                    ),
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    ),
  );
}
