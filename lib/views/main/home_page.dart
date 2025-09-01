import 'dart:convert';

import 'package:chowchek/providers/user_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  @override
  void initState() {
    super.initState();
    Provider.of<UserDetailsProvider>(context, listen: false).loadAllFromPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserDetailsProvider>(
      builder:
          (context, model, child) => Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(model.userName),
                  Text(model.isLoggedIn.toString()),
                  Text(model.averageMealsPerDay.toString()),
                  Text(jsonEncode(model.nutrientLoggedLimits)),
                ],
              ),
            ),
          ),
    );
  }
}
