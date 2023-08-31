import 'package:eshop/core/common/widgets.dart';
import 'package:flutter/material.dart';

import '../../../../core/values/colors.dart';

class EmailForOtpScreen extends StatefulWidget {
  const EmailForOtpScreen({super.key});

  @override
  State<EmailForOtpScreen> createState() => _EmailForOtpScreenState();
}

class _EmailForOtpScreenState extends State<EmailForOtpScreen>
    with CommonWidgets {
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(height: 20),
                buildLogo(),
                verticalSpace(height: 40),
                buildHeader(),
                verticalSpace(height: 50),
                buildEmailTextField(),
                verticalSpace(height: 50),
                expandedButton(
                  size: size,
                  fun: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildEmailTextField() {
    return TextFormField(
      controller: emailController,
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        label: Text("Email"),
        hintText: "john@gmail.com",
      ),
    );
  }

  Column buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Enter Your Email!",
          style: TextStyle(
            color: AppColors.colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        verticalSpace(height: 10),
        Text(
          "Hey there!",
          style: TextStyle(
            color: AppColors.colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  Row buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: AppColors.colors.darkBlue,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Center(
                child: Text(
                  "E",
                  style: TextStyle(
                    color: AppColors.colors.orange,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            horizontalSpace(width: 10),
            Text(
              "Shop",
              style: TextStyle(
                color: AppColors.colors.darkBlue,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
