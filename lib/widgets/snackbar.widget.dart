import 'package:flutter/material.dart';
import 'package:orbi_challenge/utils/app.sizing.dart';
import 'package:orbi_challenge/utils/colors.dart';

class StatusSnackbarWidget {
  static showSnackBar(
    BuildContext context, {
    StatusSnackbar type = StatusSnackbar.info,
    String message = "",
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: blackSnack,
      content: Wrap(
        spacing: Responsive.wp(2.5),
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          type == StatusSnackbar.info
              ? const Icon(
                  Icons.info,
                  color: blueAlert,
                )
              : type == StatusSnackbar.ok
                  ? const Icon(
                      Icons.check_circle,
                      color: lightGreen,
                    )
                  : const Icon(
                      Icons.cancel,
                      color: commonRed,
                    ),
          Text(message, style: TextStyle(fontSize: Responsive.dp(1.8), color: white)),
        ],
      ),
      elevation: 10,
      margin: EdgeInsets.all(Responsive.dp(1)),
      behavior: SnackBarBehavior.floating,
    ));
  }
}

enum StatusSnackbar { ok, error, info }
