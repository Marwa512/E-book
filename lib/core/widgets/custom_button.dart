import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.onTap,
      required this.textColor,
      required this.text,
      required this.buttonColor,
      this.isLoading = false,
      this.isDisable = false
      });

  final VoidCallback onTap;
  final String text;
  final Color textColor;
  final Color buttonColor;
  final bool isLoading;
 final bool isDisable;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      height: 50,
      
      
      decoration: BoxDecoration(

        color: isDisable ? Colors.grey : buttonColor,
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      child: TextButton(
        onPressed:  onTap,
        child: isLoading
            ? const SpinKitThreeInOut(
                size: 25,
                color: Colors.white,
              )
            : Text(
                text,
                style: TextStyle(color: textColor, fontSize: 20),
              ),
              
      ),
    );
  }
}
