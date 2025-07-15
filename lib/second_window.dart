import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'order_controller.dart';

class SecondWindowApp extends StatelessWidget {
  final int windowId;
  SecondWindowApp({super.key, required this.windowId});

  final OrderController controller = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    // Mijoz oynasi uchun handler
    DesktopMultiWindow.setMethodHandler((call, fromWindowId) async {
      if (call.method == 'update_order') {
        final args = call.arguments;
        final List<String> prods = List<String>.from(args['products']);
        final double sum = args['total'];
        controller.setOrder(prods, sum);
      }
      return null;
    });

    return GetMaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      home: Scaffold(
        backgroundColor: Colors.black,
        body: IgnorePointer( // mijoz oynasi interaktiv emas
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('🧾 Buyurtmangiz:',
                    style: TextStyle(fontSize: 24, color: Colors.white)),
                const SizedBox(height: 10),
                ...controller.products.map((e) => Text(
                  '• $e',
                  style: const TextStyle(fontSize: 20, color: Colors.white70),
                )),
                const Spacer(),
                Center(
                  child: Text(
                    'JAMI: ${controller.total.value.toStringAsFixed(0)} so\'m',
                    style: const TextStyle(
                        fontSize: 32,
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
