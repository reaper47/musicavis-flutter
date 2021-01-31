import 'package:flutter/material.dart';

List<FocusNode> makeNodes(int length) =>
    List<FocusNode>.filled(length, null, growable: true);
