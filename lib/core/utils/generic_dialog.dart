import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/theme/app_icons.dart';

typedef DialogOptionBuilder<T> = Map<String, T?> Function();

Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String title,
  required Color dialogColor,
  IconData? icon,
  required DialogOptionBuilder optionsBuilder,
  required String selectedOption,
}) {
  final options = optionsBuilder();

  return showDialog<T>(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 40.h),
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          child: SizedBox(
            height: 0.29.sh,
            width: double.maxFinite,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 80.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                      // child: AppIcons.checkIcon,
                      ),
                  SizedBox(height: 25.h),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.black,
                        ),
                  ),
                  SizedBox(height: 25.h),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ...(options.keys).map((optionTitle) {
                          final value = options[optionTitle];
                          return Container(
                            height: 0.06.sh,
                            width: 0.45.sw,
                            child: TextButton(
                              style: ButtonStyle(
                                textStyle:
                                    MaterialStateProperty.resolveWith((states) {
                                  return Theme.of(context).textTheme.labelLarge;
                                }),
                                overlayColor: MaterialStateProperty.all<Color>(
                                  (optionTitle == selectedOption)
                                      ? dialogColor
                                      : Colors.grey.withOpacity(0.1),
                                ),
                                foregroundColor:
                                    MaterialStateProperty.resolveWith(
                                        (states) =>
                                            (optionTitle == selectedOption)
                                                ? Colors.white
                                                : Colors.grey.withOpacity(0.5)),
                                backgroundColor:
                                    MaterialStateColor.resolveWith((states) {
                                  return (optionTitle == selectedOption)
                                      ? dialogColor
                                      : Colors.grey.withOpacity(0.1);
                                }),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0))),
                              ),
                              onPressed: () {
                                if (value != null) {
                                  Navigator.of(context).pop(value);
                                } else {
                                  Navigator.of(context).pop();
                                }
                              },
                              child: Text(optionTitle),
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                  SizedBox(height: 15.h)
                ],
              ),
            ),
          ),
        );
      });
}
