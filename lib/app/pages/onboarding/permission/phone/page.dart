import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/entities/permission.dart';
import '../../../../resources/localizations.dart';
import '../../../../resources/theme.dart';
import '../../../main/widgets/caller.dart';
import '../abstract/page.dart';

class PhonePermissionPage extends StatelessWidget {
  const PhonePermissionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PermissionPage(
      permission: Permission.phone,
      icon: const Icon(VialerSans.phone),
      title: Text(context.msg.onboarding.permission.phone.title),
      description: Text(context.msg.onboarding.permission.phone.description),
      onPermissionGranted: context.watch<CallerCubit>().notifyCanCall,
    );
  }
}