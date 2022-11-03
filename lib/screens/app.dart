import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:job_board/base/constants/app_theme.dart';
import 'package:job_board/screens/job_board/job_board_screen.dart';
import 'package:job_board/translations/locale_keys.g.dart';
import 'package:job_board/utils/extensions/string_extension.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = 'en';
    return Listener(
      behavior: HitTestBehavior.translucent,
      child: ScreenUtilInit(
        builder: (_, __) => MaterialApp(
          theme: AppTheme().theme,
          title: LocaleKeys.appName.locale,
          locale: context.locale,
          localizationsDelegates: context.localizationDelegates,
          debugShowCheckedModeBanner: false,
          supportedLocales: context.supportedLocales,
          localeResolutionCallback: (locale, supportedLocales) => context.fallbackLocale,
          home: const JobBoardScreen(),
        ),
      ),
    );
  }
}
