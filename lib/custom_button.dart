import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_generator/consts/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function()? onTap;
  const CustomButton({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50.h,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
            boxShadow: const [
              BoxShadow(
                  color: AppColors.blackColor,
                  blurRadius: 5,
                  spreadRadius: .1,
                  blurStyle: BlurStyle.outer)
            ],
            color: AppColors.blackColor),
        child: Center(
            child: Text(
          text,
          style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500),
        )),
      ),
    );
  }
}
