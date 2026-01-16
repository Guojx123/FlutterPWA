import 'dart:convert';
import 'package:get/get.dart';

import '../models/user_model.dart';
import '../providers/user_provider.dart';
import '../services/storage_service.dart';

/// 用户仓库 - 演示缓存策略
class UserRepository {
  final _storage = StorageService.to;
  static const _cacheKey = 'user_profile';

  /// 获取用户资料（缓存优先）
  Future<UserModel?> getProfile({bool forceRefresh = false}) async {
    // 优先读取缓存
    if (!forceRefresh) {
      final cached = _storage.get<String>(_cacheKey);
      if (cached != null && cached.isNotEmpty) {
        try {
          return UserModel.fromJson(jsonDecode(cached));
        } catch (e) {
          // 缓存数据损坏，清除
          await _storage.remove(_cacheKey);
        }
      }
    }

    // 从网络获取
    try {
      final provider = Get.find<UserProvider>();
      final response = await provider.getProfile();
      if (response.statusCode == 200 && response.body != null) {
        final user = UserModel.fromJson(response.body);
        // 更新缓存
        await _storage.set(_cacheKey, jsonEncode(user.toJson()));
        return user;
      }
    } catch (e) {
      // 网络请求失败，如果有缓存则返回缓存
      final cached = _storage.get<String>(_cacheKey);
      if (cached != null && cached.isNotEmpty) {
        try {
          return UserModel.fromJson(jsonDecode(cached));
        } catch (_) {}
      }
    }
    return null;
  }

  /// 清除用户缓存
  Future<void> clearCache() async {
    await _storage.remove(_cacheKey);
  }
}
