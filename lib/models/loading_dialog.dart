import 'package:chowchek/utils/app_colors.dart';
import 'package:flutter/material.dart';

class LoadingDialog {
  void show(BuildContext context) {
    showDialog(
      useRootNavigator: true,
      context: context,
      barrierDismissible: false, // prevents closing by tapping outside
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.primaryWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 32,
                  height: 32,
                  child: CircularProgressIndicator(
                    color: AppColors.deepGreen,
                    strokeWidth: 3,
                  ),
                ),

                Text(
                  "hold on...",
                  style: TextStyle(
                    color: AppColors.primaryGreen,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void pop(BuildContext context) {
    Navigator.of(context, rootNavigator: true).maybePop();
  }
}
