import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'main_window.dart';
import 'second_window.dart';
import 'order_controller.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(OrderController());

  if (args.isNotEmpty) {
    final windowId = int.tryParse(args[0]) ?? 0;
    runApp(SecondWindowApp(windowId: windowId));
  } else {
    runApp(const MainApp());

    // Auto-open customer screen if not already opened
    final secondWindow = await DesktopMultiWindow.createWindow(jsonEncode({
      'type': 'mijoz',
    }));
    await secondWindow.setTitle('Mijoz Ekrani');
    await secondWindow.setFrame(const Rect.fromLTWH(1920, 100, 500, 600));
    await secondWindow.show();
  }
}