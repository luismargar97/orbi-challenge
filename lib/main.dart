import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:orbi_challenge/models/pokemon_detail/pokemon.detail.model.dart';
import 'package:orbi_challenge/routes/index.dart';
import 'package:orbi_challenge/utils/app.sizing.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await initHiveFlutter();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Orbi Challenge',
      routes: appRoutes,
      builder: (context, child) {
        final mediaQueryData = MediaQuery.of(context);

        Responsive(context);

        return MediaQuery(
          data: mediaQueryData.copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
    );
  }
}

Future<void> initHiveFlutter() async {
  await Hive.initFlutter();

  Hive.registerAdapter(PokemonAdapter());
  Hive.registerAdapter(AbilityElementAdapter());
  Hive.registerAdapter(StatClassAdapter());
  Hive.registerAdapter(StatAdapter());
  Hive.registerAdapter(SpecieAdapter());
  Hive.registerAdapter(ColorAdapter());
}
