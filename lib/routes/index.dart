import 'package:flutter/material.dart';
import 'package:orbi_challenge/routes/detail/detail.route.dart';
import 'package:orbi_challenge/routes/home/home.route.dart';
import 'package:orbi_challenge/routes/landing/landing.route.dart';

final appRoutes = <String, WidgetBuilder>{
  LandingRoute.route: (context) => const LandingRoute(),
  HomeNavBarRoute.route: (context) => const HomeNavBarRoute(),
  DetailRoute.route: (context) => const DetailRoute(),
};
