import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_board/utils/extensions/context_extension.dart';
import 'package:job_board/utils/extensions/string_extension.dart';

import '../../../base/constants/app_constants.dart';
import '../../../base/states/base_state.dart';
import '../../../core_widgets/button_widget.dart';
import '../../../translations/locale_keys.g.dart';
import '../viewmodels/job_board_viewmodel.dart';

class TryAgainWidget extends StatelessWidget {
  const TryAgainWidget({
    Key? key,
    required this.errorState,
  }) : super(key: key);

  final BaseErrorState errorState;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${errorState.errorMessage ?? LocaleKeys.sthWentWrong.locale}", style: context.textTheme.bodyText1),
            SizedBox(width: AppSpacing.spacingSmall.w),
            ButtonWidget(
              title: LocaleKeys.tryAgain.locale,
              onPressed: () async {
                await context.read<JobBoardViewModel>().init();
              },
              backgroundColor: AppColors.black,
              useTimer: false,
              textStyle: context.textTheme.button?.copyWith(color: AppColors.white),
            ),
          ],
        ),
      ],
    );
  }
}
