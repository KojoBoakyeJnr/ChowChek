import 'package:chowchek/providers/user_details_provider.dart';
import 'package:chowchek/utils/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class NutrientTile extends StatefulWidget {
  late double defaultValue;
  late String unit;
  late Color activeColor;
  late String name;
  late String imagePath;
  late double min;
  late double max;
  late int divisions;

  NutrientTile({
    super.key,
    required this.defaultValue,
    required this.activeColor,
    required this.divisions,
    required this.imagePath,
    required this.max,
    required this.min,
    required this.name,
    required this.unit,
  });

  @override
  State<NutrientTile> createState() => _NutrientTileState();
}

class _NutrientTileState extends State<NutrientTile> {
  @override
  void initState() {
    super.initState();
  }

  void _storeValue() async {
    Provider.of<UserDetailsProvider>(
          context,
          listen: false,
        ).nutrientLoggedLimits[widget.name] =
        widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserDetailsProvider>(
      builder:
          (context, model, child) => Padding(
            padding: const EdgeInsets.all(8.0),

            child: Container(
              width: 350,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.primaryWhite,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 20,
                      child: Image.asset(widget.imagePath),
                    ),
                  ),
                  Text(" ${widget.name} : "),
                  Text(
                    "${widget.defaultValue}${widget.unit}",
                    style: TextStyle(color: widget.activeColor),
                  ),
                  SizedBox(
                    width: 150,
                    child: Slider(
                      activeColor: widget.activeColor,
                      inactiveColor: AppColors.textFieldGray,
                      label: "${widget.defaultValue}",
                      divisions: widget.divisions,
                      min: widget.min,
                      max: widget.max,
                      value: widget.defaultValue,
                      onChanged: (newRating) {
                        setState(() {
                          widget.defaultValue = newRating;
                        });
                        _storeValue();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
