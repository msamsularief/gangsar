import 'package:flutter/material.dart';

void formFocusNode(BuildContext context, FocusNode focusNode) =>
    FocusScope.of(context).requestFocus(focusNode);
