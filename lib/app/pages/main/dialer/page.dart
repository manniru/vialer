import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../resources/theme.dart';
import '../../../widgets/transparent_status_bar.dart';
import 'widgets/key_input.dart';
import 'widgets/keypad.dart';

import '../../../../domain/repositories/call.dart';

import 'controller.dart';

class DialerPage extends View {
  final CallRepository _callRepository;

  DialerPage(this._callRepository);

  @override
  State<StatefulWidget> createState() => _DialerPageState(_callRepository);
}

class _DialerPageState extends ViewState<DialerPage, DialerController> {
  _DialerPageState(CallRepository callRepository)
      : super(DialerController(callRepository));

  @override
  Widget buildPage() {
    return Scaffold(
      key: globalKey,
      body: TransparentStatusBar(
        brightness: Brightness.dark,
        child: Column(
          children: <Widget>[
            Material(
              elevation: context.isIOS ? 0 : 8,
              child: SafeArea(
                child: SizedBox(
                  height: 96,
                  child: Center(
                    child: KeyInput(
                      controller: controller.keypadController,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Keypad(
                    controller: controller.keypadController,
                    onCallButtonPressed: controller.call,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
