import 'package:get/get.dart';

class CounterService extends GetxService {
  static final CounterService _instance = CounterService._internal();
  factory CounterService() => _instance;
  CounterService._internal();

  final RxInt count = 0.obs;

  void increment() => count.value++;

  int get value => count.value;

  void setValue(int val) => count.value = val;
}
