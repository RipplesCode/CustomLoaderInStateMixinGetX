
import 'package:custom_shimmer_loader_state_mixin_flutter_getx/app/modules/home/views/rounded_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyFailureNoInternetView extends StatelessWidget {
  EmptyFailureNoInternetView(
      {required this.image,
      required this.title,
      required this.description,
      required this.buttonText,
      required this.onPressed});

  final String title, description, buttonText, image;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Lottie.asset(
                image,
                height: 250,
                width: 250,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                title,
               style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                description,
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                height: 8,
              ),
              RoundedElevatedButton(
                width: 200,
                onPressed: onPressed,
                childText: buttonText,
              )
            ],
          ),
        ),
      ),
    );
  }
}
