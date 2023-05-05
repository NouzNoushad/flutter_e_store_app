import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_store/screens/splash_screen.dart';

import 'core/colors.dart';
import 'cubit/store_cubit.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoreCubit()
        ..fetchProductCategories()
        ..getCurrentLocation(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: primarySwatch,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
