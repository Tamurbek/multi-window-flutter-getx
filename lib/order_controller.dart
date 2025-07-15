import 'package:get/get.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';

class OrderController extends GetxController {
  final RxList<String> products = <String>[].obs;
  final RxDouble total = 0.0.obs;

  void addProduct(String name, double price) {
    products.add(name);
    total.value += price;
    _notifySecondWindow();
  }

  void setOrder(List<String> newProducts, double newTotal) {
    products.value = newProducts;
    total.value = newTotal;
  }

  void _notifySecondWindow() async {
    final ids = await DesktopMultiWindow.getAllSubWindowIds();
    for (var id in ids) {
      await DesktopMultiWindow.invokeMethod(id, 'update_order', {
        'products': products,
        'total': total.value,
      });
    }
  }
}