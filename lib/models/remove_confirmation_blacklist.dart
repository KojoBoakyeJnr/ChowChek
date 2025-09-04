import 'package:chowchek/providers/blacklisted_meals_provider.dart';
import 'package:chowchek/providers/saved_meals_provider.dart';
import 'package:chowchek/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RemoveConfirmationBlacklist {
  int index;
  RemoveConfirmationBlacklist({required this.index});

  show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.only(
            left: 30,
            right: 30,
            top: 300,
            bottom: 300,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Are you sure about this?",
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryGreen,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: 150,
                        height: 50,
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "no not really🤔",
                            style: TextStyle(
                              color: AppColors.primaryWhite,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: 150,
                        height: 50,
                        child: MaterialButton(
                          onPressed: () {
                            Provider.of<BlacklistedMealsProvider>(
                              context,
                              listen: false,
                            ).removeMealFromBlacklisted(index);
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "yes i am 👍🏾",
                            style: TextStyle(
                              color: AppColors.primaryWhite,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
