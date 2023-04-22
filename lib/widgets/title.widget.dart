import 'package:flutter/material.dart';
import 'package:orbi_challenge/utils/app.sizing.dart';

class TitleList extends StatelessWidget {
  final String label;

  const TitleList(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: Responsive.dp(3),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
