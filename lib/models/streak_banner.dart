import 'package:chowchek/utils/app_colors.dart';
import 'package:flutter/material.dart';

class StreakBanner extends StatelessWidget {
  const StreakBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 120, 0, 147),
          borderRadius: BorderRadius.circular(10),
        ),
        width: 350,
        height: 40,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "8 days",
                style: TextStyle(
                  color: AppColors.primaryWhite,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Text(
              "keep your clean streak going",
              style: TextStyle(fontSize: 12, color: AppColors.primaryWhite),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("❤️‍🔥", style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
