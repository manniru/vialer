import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../resources/theme.dart';
import '../../widgets/nested_navigator.dart';
import '../cubit.dart';

/// Wraps the content of the Settings Page with the necessary scaffolding and
/// navigation.
class SettingsPageContainer extends StatelessWidget {
  const SettingsPageContainer({
    required this.scaffoldMessengerKey,
    required this.navigatorKey,
    required this.child,
    super.key,
  });

  final Widget child;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: NestedNavigator(
        navigatorKey: navigatorKey,
        routes: {
          'root': (context, _) {
            return BlocBuilder<SettingsCubit, SettingsState>(
              // We're only building here to show the progress indicator.
              buildWhen: (previous, current) =>
                  previous.shouldAllowRemoteSettings !=
                  current.shouldAllowRemoteSettings,
              builder: (context, state) {
                return Scaffold(
                  resizeToAvoidBottomInset: false,
                  bottomSheet: state.isApplyingChanges
                      ? LinearProgressIndicator(
                          color: context.brand.theme.colors.primary,
                          backgroundColor:
                              context.brand.theme.colors.primaryLight,
                        )
                      : null,
                  body: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [child],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}