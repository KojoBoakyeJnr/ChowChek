import 'package:chowchek/providers/nutrient_check_provider.dart';
import 'package:chowchek/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NutrientRow extends StatefulWidget {
  final String imagePath;
  final String label;
  final String amount;
  final String percentage;
  final Color pillColor;

  const NutrientRow({
    super.key,
    required this.imagePath,
    required this.label,
    required this.amount,
    required this.percentage,
    required this.pillColor,
  });

  @override
  State<NutrientRow> createState() => _NutrientRowState();
}

class _NutrientRowState extends State<NutrientRow> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NutrientCheckProvider>(
      builder:
          (context, model, child) => Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.primaryWhite,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset(widget.imagePath),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: Text(
                    widget.label,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          widget.amount,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: widget.pillColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    widget.percentage,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
