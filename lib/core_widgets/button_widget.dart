import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_board/translations/locale_keys.g.dart';
import 'package:job_board/utils/extensions/context_extension.dart';
import 'package:job_board/utils/extensions/string_extension.dart';
import '../base/constants/app_constants.dart';

class ButtonWidget extends StatefulWidget {
  final Function? onPressed;
  final Color? backgroundColor;
  final String? title;
  final TextStyle? textStyle;
  final Color? borderColor;
  final bool useTimer;
  const ButtonWidget({
    Key? key,
    this.onPressed,
    this.backgroundColor,
    this.title,
    this.textStyle,
    this.borderColor,
    this.useTimer: true,
  }) : super(key: key);

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.useTimer && widget.onPressed != null)
          widget.onPressed!();
        else {
          Fluttertoast.showToast(
            backgroundColor: Colors.red,
            msg: LocaleKeys.pleasePressFiveSecondsMessage.locale,
            timeInSecForIosWeb: 2,
          );
        }
      },
      onTapDown: (_) {
        if (widget.useTimer)
          timer = Timer(Duration(seconds: 5), () {
            if (widget.onPressed != null) widget.onPressed!();
          });
      },
      onTapUp: (_) {
        if (widget.useTimer) timer?.cancel();
      },
      child: Material(
        clipBehavior: Clip.antiAlias,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(8.0)),
          side: widget.borderColor != null ? BorderSide(color: widget.borderColor!, width: 1) : BorderSide.none,
        ),
        child: Container(
          decoration: BoxDecoration(color: widget.backgroundColor),
          padding: EdgeInsets.all(AppSpacing.spacingSmall.h),
          child: Text(widget.title ?? "-", style: widget.textStyle ?? context.textTheme.button?.copyWith(color: AppColors.black)),
        ),
      ),
    );
  }
}
