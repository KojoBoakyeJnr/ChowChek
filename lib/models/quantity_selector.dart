import 'package:chowchek/utils/app_colors.dart';
import 'package:flutter/material.dart';

class QuantitySelector extends StatefulWidget {
  const QuantitySelector({super.key});

  @override
  State<QuantitySelector> createState() => QuantitySelectorState();
}

class QuantitySelectorState extends State<QuantitySelector> {
  int quantity = 3;

  VoidCallback? increaseQuantity() {
    setState(() {
      (quantity > 19) ? quantity : quantity++;
    });
    return null;
  }

  VoidCallback? decreaseQuantity() {
    setState(() {
      (quantity == 1) ? quantity : quantity--;
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MaterialButton(
            onPressed: () => decreaseQuantity(),
            child: Icon(Icons.remove, color: AppColors.primaryAsh),
          ),

          Container(
            decoration: BoxDecoration(
              color: AppColors.deepGreen,
              borderRadius: BorderRadius.circular(10),
            ),
            width: 70,
            height: 70,
            child: Center(
              child: Text(
                "$quantity",
                style: TextStyle(
                  color: AppColors.primaryWhite,
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          MaterialButton(
            onPressed: () => increaseQuantity(),
            child: Icon(Icons.add, color: AppColors.primaryAsh),
          ),
        ],
      ),
    );
  }
}
