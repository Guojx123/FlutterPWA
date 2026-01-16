import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends GetxController {
  final refreshController = RefreshController(initialRefresh: false);
  final items = <String>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }

  /// 加载数据
  Future<void> _loadData() async {
    isLoading.value = true;
    // 模拟网络请求
    await Future.delayed(const Duration(seconds: 1));
    items.value = List.generate(20, (index) => '首页项目 ${index + 1}');
    isLoading.value = false;
  }

  /// 下拉刷新
  Future<void> onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    items.value = List.generate(20, (index) => '刷新项目 ${index + 1}');
    refreshController.refreshCompleted();
  }

  /// 上拉加载
  Future<void> onLoading() async {
    await Future.delayed(const Duration(seconds: 1));
    if (items.length >= 40) {
      refreshController.loadNoData();
    } else {
      final newItems = List.generate(
        10,
        (index) => '新增项目 ${items.length + index + 1}',
      );
      items.addAll(newItems);
      refreshController.loadComplete();
    }
  }
}
