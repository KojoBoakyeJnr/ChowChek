import 'package:flutter/material.dart';

class ResultsEmptyState extends StatelessWidget {
  const ResultsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: 350,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.red[50],
          borderRadius: BorderRadiusDirectional.circular(10),
        ),
        child: Center(
          child: Text(
            textAlign: TextAlign.center,
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.red),
            "😢We couldn’t find that meal. Please check the spelling or try searching by ingredients.",
          ),
        ),
      ),
    );
  }
}
