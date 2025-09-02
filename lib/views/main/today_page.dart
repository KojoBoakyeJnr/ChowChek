import 'package:chowchek/endpoints/end_points.dart';
import 'package:chowchek/utils/app_button.dart';
import 'package:chowchek/utils/app_colors.dart';
import 'package:chowchek/utils/app_text_form_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class TodayPage extends StatefulWidget {
  const TodayPage({super.key});

  @override
  State<TodayPage> createState() => _TodayPageState();
}

TextEditingController _query = TextEditingController();

final apiKey = dotenv.env['API_KEY'];

class _TodayPageState extends State<TodayPage> {
  void _getNutritionalData() async {
    var response = await fetchNutrientData();
    print(response.body);
  }

  Future<http.Response> fetchNutrientData() {
    return http.get(
      Uri.parse("${EndPoints.nutrientsURL}query=${_query.text}"),
      headers: {"X-Api-Key": apiKey ?? ""},
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 50, right: 50),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "What did you eat\ntoday?",

                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 30,
                          height: 1,
                        ),
                      ),
                    ),
                    AppTextFormFields(
                      hintText: "Beans with plantain and sausage",
                      controller: _query,
                      fill: AppColors.textFieldGray,
                      leading: Icon(Icons.question_mark),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: AppButton(
                        buttonName: "Chek!",
                        onclick: () {
                          _getNutritionalData();
                          _query.text = "";
                        },
                        backgroundColor: AppColors.deepGreen,
                        textColor: AppColors.primaryWhite,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
