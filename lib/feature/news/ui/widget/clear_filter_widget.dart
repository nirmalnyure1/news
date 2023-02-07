import 'package:flutter/material.dart';

class ClearFilderWidget extends StatelessWidget {
  final Function() onPressed;
  const ClearFilderWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              "clear filter",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            Icon(
              Icons.cancel,
              color: Colors.black54,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
