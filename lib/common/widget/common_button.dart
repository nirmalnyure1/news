import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String title;
  final Function() onPressed;
  const CommonButton({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        elevation: 0,
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: onPressed,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            )),
      ),
    );
  }
}
