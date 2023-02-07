import 'package:flutter/material.dart';
import 'package:task/feature/news/model/news_model.dart';
import 'package:task/feature/news/ui/widget/news_card_widget.dart';

class NewsGridWithHeader extends StatelessWidget {
  final String title;
  final List<NewsModel> newsList;
  const NewsGridWithHeader(
      {super.key, required this.title, required this.newsList});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: textTheme.headline6!.copyWith(fontSize: 16),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_forward_ios),
              iconSize: 15,
            )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        GridView(
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.all(0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: 3,
              childAspectRatio: 1 / 1.1),
          children: List.generate(
              newsList.length,
              (index) => NewsCardWidget(
                  title: newsList[index].title,
                  date:
                      "${newsList[index].publishedAt.day} ${newsList[index].publishedMonth}",
                  numberOfQuestion: "${newsList[index].numberOfQuestions}",
                  onReadPressed: () {})),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
