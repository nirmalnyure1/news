import 'package:flutter/material.dart';
import 'package:task/common/widget/common_button.dart';

class NewsCardWidget extends StatelessWidget {
  final String title;
  final String date;
  final String numberOfQuestion;
  final Function() onReadPressed;
  const NewsCardWidget(
      {super.key,
      required this.title,
      required this.date,
      required this.numberOfQuestion,
      required this.onReadPressed});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey.shade300,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: textTheme.titleSmall,
            ),
            const SizedBox(height: 3),
            Text(
              date,
              style: textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Text("$numberOfQuestion Questions"),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonButton(title: "read", onPressed: onReadPressed),
              ],
            )
          ],
        ),
      ),
    );
  }
}
