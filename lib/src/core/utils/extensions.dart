import 'package:flutter/material.dart';

extension EasyNavigation on BuildContext {
  void goTo(Widget page) {
    Navigator.push(this, MaterialPageRoute(builder: (_) => page));
  }
}
