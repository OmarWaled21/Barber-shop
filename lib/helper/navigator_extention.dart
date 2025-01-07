import 'package:flutter/material.dart';

extension NavigatorExtention on BuildContext {
  void push(Widget page) {
    Navigator.push(this, MaterialPageRoute(builder: (context) => page));
  }

  void pop() {
    Navigator.pop(this);
  }
}
