import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_generator/consts/colors.dart';
import 'package:qr_generator/consts/sizedbox_extension.dart';
import 'package:qr_generator/custom_button.dart';
import 'package:qr_generator/model/onboarding_item.dart';
import 'package:qr_generator/view/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

final pageController = PageController();
int _selectedIndex = 0;
int _index = 0;

class _OnboardingViewState extends State<OnboardingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    _selectedIndex = value;
                    _index = value;
                  });
                },
                controller: pageController,
                itemCount: onboardingData.length,
                itemBuilder: (context, index) {
                  _index = index;
                  final item = onboardingData[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      150.h.sbh,
                      Container(
                        height: 200.h,
                        width: 200.w,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  color: AppColors.blackColor,
                                  blurRadius: 5,
                                  spreadRadius: .1,
                                  blurStyle: BlurStyle.outer)
                            ],
                            border: Border.all(
                                color: AppColors.blackColor.withOpacity(.7))),
                        child: Center(
                          child: SvgPicture.asset(
                            item.image,
                            height: 150.h,
                            width: 150.w,
                          ),
                        ),
                      ),
                      30.h.sbh,
                      Text(
                        item.title,
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.bold),
                      ),
                      15.h.sbh,
                      Text(
                        item.description,
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.black.withOpacity(.6)),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  onboardingData.length,
                  (index) => indicatorsDot(
                    index,
                    context,
                  ),
                ),
              ),
            ),
            25.h.sbh,
            CustomButton(
              text:
                  _index == onboardingData.length - 1 ? "Get Started" : "Next",
              onTap: _index == onboardingData.length - 1
                  ? () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setBool("userToken", true);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeView()));
                    }
                  : () {
                      pageController.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.linear);
                      setState(() {});
                    },
            ),
            50.h.sbh
          ],
        ),
      ),
    );
  }

// Indicator // Small Dots // Onboarding Active Dots
  Container indicatorsDot(int index, BuildContext context) {
    return Container(
      height: 10.h,
      width: _selectedIndex == index ? 25.w : 10.w,
      margin: EdgeInsets.only(right: 5.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: _selectedIndex == index
              ? LinearGradient(colors: [
                  AppColors.greyColor.withOpacity(.8),
                  AppColors.blackColor.withOpacity(.8)
                ])
              : const LinearGradient(
                  colors: [AppColors.greyColor, AppColors.greyColor])),
    );
  }
}
