import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'order_controller.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Kafe POS',
      theme: ThemeData(
        colorSchemeSeed: Colors.teal,
        useMaterial3: true,
      ),
      home: const MainWindow(),
    );
  }
}

class MainWindow extends StatelessWidget {
  const MainWindow({super.key});

  final List<Map<String, dynamic>> menu = const [
    {'name': '☕ Kofe', 'price': 15000.0},
    {'name': '🍵 Choy', 'price': 10000.0},
    {'name': '🍔 Burger', 'price': 25000.0},
    {'name': '🍕 Pitsa', 'price': 40000.0},
    {'name': '🥤 Cola', 'price': 8000.0},
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrderController>();

    return Scaffold(
      appBar: AppBar(title: const Text('🍽 Kafe POS')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: menu.map((item) {
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: InkWell(
                    onTap: () => controller.addProduct(item['name'], item['price']),
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: 140,
                      height: 100,
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(item['name'], style: const TextStyle(fontSize: 18)),
                          const SizedBox(height: 8),
                          Text('${item['price'].toStringAsFixed(0)} so\'m',
                              style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const Spacer(),
            Obx(() => Text(
              'Jami: ${controller.total.value.toStringAsFixed(0)} so\'m',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}