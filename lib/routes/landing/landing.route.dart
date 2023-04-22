import 'package:flutter/material.dart';
import 'package:orbi_challenge/routes/landing/landing.vm.dart';
import 'package:orbi_challenge/utils/app.sizing.dart';
import 'package:orbi_challenge/utils/colors.dart';
import 'package:pmvvm/pmvvm.dart';

class LandingRoute extends StatelessWidget {
  const LandingRoute({Key? key}) : super(key: key);

  static const route = '/';

  @override
  Widget build(BuildContext context) {
    return MVVM<LandingVM>(
      viewModel: LandingVM(),
      view: () => const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      height: Responsive.height,
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 1000),
        tween: Tween(begin: 0, end: 1),
        builder: (context, value, _) {
          return Opacity(
            opacity: value,
            child: Center(
              child: Image.asset(
                'assets/icons/icon.png',
                width: Responsive.wp(50),
              ),
            ),
          );
        },
      ),
    );
  }
}
