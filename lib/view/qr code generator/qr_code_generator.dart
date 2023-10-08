import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_generator/consts/colors.dart';
import 'package:qr_generator/consts/sizedbox_extension.dart';
import 'package:qr_generator/custom_button.dart';

class QRGeneratorView extends StatefulWidget {
  final String image;
  const QRGeneratorView({super.key, required this.image});

  @override
  State<StatefulWidget> createState() => _QRGeneratorViewState();
}

class _QRGeneratorViewState extends State<QRGeneratorView> {
  String data = "www.darkrew.com";
  TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.sp),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios)),
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
                50.h.sbh,
                Center(
                  child: SizedBox(
                    height: 200.h,
                    width: 200.w,
                    child: QrImageView(
                      data: data,
                      version: QrVersions.auto,
                    ),
                  ),
                ),
                20.h.sbh,
                TextFormField(
                  controller: textEditingController,
                  cursorColor: AppColors.blackColor.withOpacity(.05),
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus!.unfocus();
                  },
                  decoration: InputDecoration(
                    hintText: "Enter text or data",
                    hintStyle: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.blackColor.withOpacity(.3)),
                    constraints:
                        BoxConstraints.tight(const Size(double.infinity, 50)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.blackColor.withOpacity(.5)),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: AppColors.blackColor),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                150.h.sbh,
                CustomButton(
                  text: "Generate",
                  onTap: () {
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
                                  "QR Generated",
                                  style: TextStyle(
                                      color: AppColors.whiteColor,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            content: Container(
                                height: 250.h,
                                // width: 100.w,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border:
                                        Border.all(color: AppColors.greyColor),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: AppColors.blackColor,
                                          blurRadius: 5,
                                          spreadRadius: .1,
                                          blurStyle: BlurStyle.outer)
                                    ],
                                    color: AppColors.bgColor),
                                child: QrImageView(
                                  data: textEditingController.text,
                                  version: QrVersions.auto,
                                )),
                          );
                        });
                    // setState(() {
                    //   data = textEditingController.text;
                    // });
                  },
                ),
                20.h.sbh,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
