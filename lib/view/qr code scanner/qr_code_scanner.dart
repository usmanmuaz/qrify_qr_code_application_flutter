import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_generator/consts/colors.dart';
import 'package:qr_generator/consts/sizedbox_extension.dart';

class QRCodeScanner extends StatefulWidget {
  final String image;
  const QRCodeScanner({super.key, required this.image});

  @override
  State<StatefulWidget> createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? _controller;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios)),
            50.h.sbh,
            Center(
              child: Container(
                height: 100.h,
                width: 100.w,
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
                  widget.image,
                  height: 75.h,
                  width: 75.w,
                ),
              ),
            ),
            100.h.sbh,
            Center(
              child: SizedBox(
                height: 250.h,
                width: 250.w,
                child: QRView(
                  key: _qrKey,
                  overlay: QrScannerOverlayShape(
                      borderColor: AppColors.greyColor,
                      cutOutHeight: 200.h,
                      cutOutWidth: 200.w),
                  onQRViewCreated: _onQRViewCreated,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    _controller = controller;
    controller.scannedDataStream.listen((scanData) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                backgroundColor: AppColors.blackColor,
                elevation: 0,
                contentPadding: EdgeInsets.all(20.sp),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close,
                          color: AppColors.whiteColor,
                        )),
                    20.w.sbw,
                    Text(
                      "QR Scanned",
                      style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                content: Text(
                  scanData.code.toString(),
                  style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400),
                ));
          });
      print(
          " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${scanData.code} ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    });
  }
}
