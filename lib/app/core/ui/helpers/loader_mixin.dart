import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

mixin Loader<T extends StatefulWidget> on State<T> {
  var _isOpen = false;

  var _isEasyLoadingCustomized = false;

  void _customizeEasyLoading() {
    if (_isEasyLoadingCustomized) return;
    _isEasyLoadingCustomized = true;
    EasyLoading.instance
      ..loadingStyle = Theme.of(context).brightness == Brightness.dark
          ? EasyLoadingStyle.light
          : EasyLoadingStyle.dark
      ..maskType = EasyLoadingMaskType.black
      ..toastPosition = EasyLoadingToastPosition.center
      ..animationStyle = EasyLoadingAnimationStyle.opacity
      ..indicatorType = EasyLoadingIndicatorType.circle;
  }

  void showLoader() {
    if (_isOpen) return;
    _isOpen = true;
    _customizeEasyLoading();
    EasyLoading.show(dismissOnTap: false);
  }

  void hideLoader() {
    if (_isOpen) {
      _isOpen = false;
      EasyLoading.dismiss();
    }
  }
}
