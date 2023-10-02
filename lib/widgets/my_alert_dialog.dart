import 'package:flutter/material.dart';

void myAlertDialog(BuildContext context, {Widget? title, Widget? content, List<Widget>? action}) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(title: title, content: content, actions: action),
  );
}
