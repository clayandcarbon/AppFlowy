import 'package:app_flowy/startup/startup.dart';
import 'package:flowy_infra/theme.dart';
import 'package:flowy_infra_ui/flowy_infra_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';
import 'package:app_flowy/startup/launch.dart';

class AppWidgetTask extends LaunchTask {
  @override
  LaunchTaskType get type => LaunchTaskType.appLauncher;

  @override
  Future<void> initialize(LaunchContext context) {
    final widget = context.getIt<EntryPoint>().create();
    final app = ApplicationWidget(child: widget);
    runApp(app);

    return Future(() => {});
  }
}

class ApplicationWidget extends StatelessWidget {
  final Widget child;
  const ApplicationWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setWindowMinSize(const Size(500, 500));

    final theme = AppTheme.fromType(ThemeType.light);
    return Provider.value(
        value: theme,
        child: MaterialApp(
          builder: overlayManagerBuilder(),
          debugShowCheckedModeBanner: false,
          theme: theme.themeData,
          navigatorKey: AppGlobals.rootNavKey,
          home: child,
        ));
  }
}

class AppGlobals {
  static GlobalKey<NavigatorState> rootNavKey = GlobalKey();
  static NavigatorState get nav => rootNavKey.currentState!;
}
