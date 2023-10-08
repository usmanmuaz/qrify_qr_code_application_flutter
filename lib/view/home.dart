import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_generator/consts/colors.dart';
import 'package:qr_generator/consts/sizedbox_extension.dart';
import 'package:qr_generator/view/qr%20code%20generator/qr_code_generator.dart';
import 'package:qr_generator/view/qr%20code%20scanner/qr_code_scanner.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

Future<void> _requestCameraPermission() async {
  final status = await Permission.camera.request();
  if (status.isGranted) {
    // Permission granted, you can now use the camera
  } else {
    // Permission denied, show a message or handle it gracefully
    if (status.isPermanentlyDenied) {
      // The user has denied permission and selected "Don't ask again"
      // You can open the app settings to let the user enable the permission manually
      openAppSettings();
    }
  }
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            75.h.sbh,
            Image.asset(
              "images/qr_icon.png",
              height: 100.h,
              width: 100.w,
            ),
            10.h.sbh,
            Text(
              "QRify",
              style: TextStyle(
                  fontSize: 18.sp,
                  color: AppColors.greyColor.shade600,
                  fontWeight: FontWeight.bold),
            ),
            100.h.sbh,
            Row(
              children: [
                QRBox(
                    onTap: () {
                      _requestCameraPermission();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const QRCodeScanner(
                                    image: 'images/scanner.svg',
                                  )));
                    },
                    text: " QR Scanner",
                    svgImageFIle: "images/scanner.svg"),
                const Spacer(),
                QRBox(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const QRGeneratorView(
                                    image: 'images/generator.svg',
                                  )));
                    },
                    text: "QR Generator",
                    svgImageFIle: "images/generator.svg"),
              ],
            ),
            const Spacer(),
            _poweredByDarkrew()
          ],
        ),
      ),
    );
  }
}

// QR BOX

class QRBox extends StatelessWidget {
  final String text;
  final String svgImageFIle;
  final Function()? onTap;

  const QRBox(
      {super.key, required this.text, required this.svgImageFIle, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 150.h,
            width: 150.w,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.greyColor),
                boxShadow: const [
                  BoxShadow(
                      color: AppColors.blackColor,
                      blurRadius: 5,
                      spreadRadius: .1,
                      blurStyle: BlurStyle.outer)
                ],
                color: AppColors.bgColor),
            child: SvgPicture.asset(
              svgImageFIle,
              height: 100.h,
              width: 100.w,
            ),
          ),
        ),
        10.h.sbh,
        Text(
          text,
          style: TextStyle(
              fontSize: 18.sp,
              color: AppColors.greyColor.shade600,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

// powered by darkrew

Widget _poweredByDarkrew() {
  return Column(
    children: [
      Text(
        "Powered by",
        style: TextStyle(
            fontSize: 9.sp,
            color: AppColors.greyColor.shade500,
            fontWeight: FontWeight.w500),
      ),
      Image.asset(
        "images/dk.png",
        height: 25.h,
        width: 25.w,
      )
    ],
  );
}
