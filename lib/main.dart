import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:job_board/screens/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runZonedGuarded<Future<void>>(
    () async {
      runApp(EasyLocalization(
        supportedLocales: const [Locale('en')],
        fallbackLocale: const Locale('en'),
        path: 'assets/translations',
        child: const App(),
      ));
    },
    (_, __) {},
    zoneSpecification: ZoneSpecification(print: (Zone self, ZoneDelegate parent, Zone zone, String message) {
      if (kDebugMode) {
        parent.print(zone, '${"Job Abroad App"} ${DateTime.now()}: $message');
      }
    }),
  );
}
