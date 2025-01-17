import 'package:flutter/material.dart';
import 'package:patch_assesment/core/theme/app_theme.dart';
import 'package:patch_assesment/features/home/view/home.dart';
import 'package:patch_assesment/features/home/view_model/products_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) {
        return ProductsViewModel();
      },
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Pacth Assesment',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData,
      home: const Home(),
    );
  }
}
