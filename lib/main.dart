import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/cubit/cart_cubit.dart';
import 'package:shopping_app/cubit/favorite_cubit.dart';
import 'package:shopping_app/cubit/product_cubit.dart';
import 'package:shopping_app/cubit/theme_cubit.dart';
import 'package:shopping_app/repositories/product_repository.dart';
import 'package:shopping_app/screens/main_screen.dart';
import 'package:shopping_app/services/product_api_service.dart';

void main() {
  final apiService = ProductApiService(Dio());

  final repository = ProductRepository(apiService);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductCubit(repository)),
        BlocProvider(create: (_) => FavoriteCubit()),
        BlocProvider(create: (context) => CartCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Shopping App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor:  Colors.deepPurple,
              brightness: Brightness.light,
          ),
          useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor:Colors.deepPurple,
              brightness: Brightness.dark
               ),
              useMaterial3: true,
          ),
          themeMode: state,
          home: const MainScreen(),
        );
      },
    );
  }
}
