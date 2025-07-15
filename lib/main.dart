import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:screen_retriever/screen_retriever.dart';

import 'main_window.dart';
import 'second_window.dart';
import 'order_controller.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(OrderController());

  if (args.isNotEmpty) {
    // 👁️‍🗨️ SECOND WINDOW (Mijoz ekrani)
    final windowId = int.tryParse(args[0]) ?? 0;
    runApp(SecondWindowApp(windowId: windowId));
  } else {
    // 🖥️ MAIN WINDOW (Kassa ekrani)
    runApp(const MainApp());

    try {
      // 📺 Ekranlar ro'yxatini olish
      final displays = await screenRetriever.getAllDisplays();

      // 🧭 Chapdagi ekran (dx < 0) ni tanlash, bo'lmasa birinchisi
      final leftDisplay = displays.firstWhere(
            (screen) => screen.visiblePosition?.dx != null && screen.visiblePosition!.dx < 0,
        orElse: () => displays.first,
      );

      final dx = leftDisplay.visiblePosition?.dx ?? 0.0;
      final dy = leftDisplay.visiblePosition?.dy ?? 0.0;

      debugPrint('left monitor: $leftDisplay');

      // 🪟 Ikkinchi oynani yaratish
      final secondWindow = await DesktopMultiWindow.createWindow(jsonEncode({}));
      await secondWindow.setTitle('Mijoz Ekrani');

      // 🧭 Joylashtirish (chap ekranda)
      await secondWindow.setFrame(Rect.fromLTWH(
        dx.toDouble(),
        dy.toDouble(),
        500,
        600,
      ));

      await Future.delayed(const Duration(milliseconds: 300));
      await secondWindow.show();
    } catch (e) {
      debugPrint("❌ Second window ochishda xatolik: $e");
    }
  }
}