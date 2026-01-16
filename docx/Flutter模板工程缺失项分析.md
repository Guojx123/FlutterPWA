# Flutter 模板工程缺失项分析与改进建议

## 一、当前已实现功能盘点

### 1.1 基础架构

- ✅ GetX 状态管理框架集成
- ✅ 命名路由系统（Routes/Pages）
- ✅ 启动引导页（Splash）
- ✅ 登录模块（Login）
- ✅ 主页底部导航（Main/Home/Discover/Profile）
- ✅ 路由中间件（AuthGuard）
- ✅ 全局服务（StorageService、AuthService、ThemeService）
- ✅ 国际化基础框架（AppTranslations）
- ✅ 基础网络层（BaseProvider）
- ✅ **网络拦截器完善**（Token 自动注入、401 拦截、错误处理）
- ✅ **ApiResponse 统一响应模型**
- ✅ **Logger 日志系统**

### 1.2 通用组件

- ✅ PageContainer
- ✅ CustomAppBar
- ✅ AppButton
- ✅ AppTextField
- ✅ AppBadge
- ✅ **EmptyWidget**（空状态）
- ✅ **ErrorWidget**（错误页）
- ✅ **LoadingWidget**（加载中）

### 1.3 数据层

- ✅ **Models 层基础模型**（UserModel、ApiResponse、PaginationModel、BaseModel）
- ✅ **Repository 缓存策略**（UserRepository 示例）
- ✅ **网络异常处理工具类**（NetworkExceptionHandler）

### 1.4 UI 反馈系统

- ✅ **Toast/Loading/Dialog 系统**（基于 flutter_smart_dialog）

---

## 二、已完成开发项

### ✅ P0 高优先级（已完成）

1. **网络层拦截器完善** `lib/app/data/providers/base_provider.dart`

   - Token 自动注入
   - 401 拦截与自动登出跳转
   - HTTP 状态码统一处理
   - 业务错误码拦截
   - 请求/响应日志输出
   - 统一错误处理方法 `handleRequest()`

2. **Toast/Loading/Dialog 系统** `lib/common/utils/app_toast.dart`

   - 集成 `flutter_smart_dialog: ^4.9.0`
   - `show()` / `success()` / `error()` 提示
   - `showLoading()` / `dismissLoading()` 加载蒙层
   - `confirm()` 确认对话框
   - `showCustomDialog()` 自定义对话框

3. **ApiResponse 统一响应模型** `lib/app/data/models/api_response.dart`
   - 泛型支持
   - `success` / `isUnauthorized` 快捷判断
   - `fromJson()` / `toJson()` 序列化支持

### ✅ P1 次优先级（已完成）

4. **Logger 日志系统** `lib/common/utils/logger.dart`

   - 集成 `logger: ^2.0.0`
   - `d()` / `i()` / `w()` / `e()` / `f()` 分级日志
   - 彩色输出、堆栈追踪

5. **Models 层基础模型**

   - `lib/app/data/models/base_model.dart` - 基础接口
   - `lib/app/data/models/user_model.dart` - 用户模型示例
   - `lib/app/data/models/pagination_model.dart` - 分页模型
   - `lib/app/data/models/api_response.dart` - 响应包装

6. **Repository 缓存策略** `lib/app/data/repositories/user_repository.dart`

   - 缓存优先策略
   - 网络失败降级缓存
   - 示例：`getProfile()` 实现

7. **空状态/错误页组件**
   - `lib/common/widgets/empty_widget.dart` - 空列表占位
   - `lib/common/widgets/error_widget.dart` - 错误状态
   - `lib/common/widgets/loading_widget.dart` - 加载中

### ✅ 工具类补充

8. **网络异常处理** `lib/common/utils/network_exception_handler.dart`

   - `handleException()` - 异常类型转换
   - `handleStatusCode()` - HTTP 状态码友好提示

9. **StorageService 增强** `lib/app/data/services/storage_service.dart`

   - 新增通用方法：`get<T>()` / `set()` / `remove()` / `clear()` / `hasKey()`

10. **依赖更新** `pubspec.yaml`
    - 新增 `flutter_smart_dialog: ^4.9.0`
    - 新增 `logger: ^2.0.0`

---

## 三、剩余待开发项（中低优先级）

---

## 三、剩余待开发项（中低优先级）

### 3.1 下拉刷新 & 上拉加载（P2）

**缺失位置**：

- `HomeView`、`DiscoverView` 等列表页无刷新组件
- 无分页加载状态管理

**建议方案**：
集成 `pull_to_refresh: ^2.0.0` 或使用 GetX 内置 `Obx` + `RefreshController`。

---

### 3.2 图片缓存与优化（P2）

**建议依赖**：

```yaml
dependencies:
  cached_network_image: ^3.3.0 # 网络图片缓存
```

**封装示例**：

```dart
// lib/common/widgets/app_image.dart
class AppImage extends StatelessWidget {
  final String url;
  final double? width, height;
  final BoxFit fit;

  const AppImage(this.url, {this.width, this.height, this.fit = BoxFit.cover, super.key});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      placeholder: (_, __) => Container(color: Colors.grey[200]),
      errorWidget: (_, __, ___) => const Icon(Icons.broken_image),
    );
  }
}
```

---

### 3.3 资源文件自动化（P2）

**建议方案**：

```yaml
dev_dependencies:
  flutter_gen: ^5.4.0 # 自动生成 Assets 常量类
```

配置后自动生成：

```dart
// generated/assets.gen.dart
class Assets {
  static const String imagesLogo = 'assets/images/logo.png';
}
```

---

### 3.4 代码生成（JSON 序列化）（P2）

**建议依赖**：

```yaml
dependencies:
  json_annotation: ^4.8.0

dev_dependencies:
  build_runner: ^2.4.0
  json_serializable: ^6.7.0
```

**使用方式**：

```dart
import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final int id;
  final String name;

  UserModel({required this.id, required this.name});

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
```

---

### 3.5 屏幕适配（P3）

**可选方案**：

```yaml
dependencies:
  flutter_screenutil: ^5.9.0 # 基于设计稿尺寸适配
```

或继续使用 GetX 的 `Get.width`/`Get.height` + `LayoutBuilder` 方案。

---

### 3.6 埋点与统计（P3）

**建议实现**：

```
lib/common/utils/
└── analytics_service.dart  # 集成 Firebase Analytics 或自定义埋点
```

---

### 3.7 单元测试框架（P3）

**当前问题**：

- 无任何测试文件
- 缺少 `test/` 目录结构

**建议补充**：

```
test/
├── unit/
│   ├── services/
│   │   └── auth_service_test.dart
│   └── utils/
│       └── validator_test.dart
├── widget/
│   └── app_button_test.dart
└── integration/
    └── login_flow_test.dart
```

---

### 3.8 混淆与加固（P3）

**Android**：

```gradle
// android/app/build.gradle
buildTypes {
    release {
        minifyEnabled true
        shrinkResources true
        proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
    }
}
```

---

### 3.9 敏感信息加密（P3）

**建议方案**：

- Token 存储使用 `flutter_secure_storage`（iOS Keychain / Android Keystore）
- 或对 `GetStorage` 存储内容 AES 加密

---

### 3.10 网络安全（P3）

**缺失项**：

- 无证书绑定（Certificate Pinning）
- 无 API 签名校验

**建议依赖**：

```yaml
dependencies:
  dio: ^5.0.0 # 更强大的网络库，支持证书校验
```

---

## 四、优先级总结

**缺失内容**：

```
lib/app/data/models/
├── user_model.dart          # 用户实体
├── api_response.dart        # API 通用响应包装
├── pagination_model.dart    # 分页数据模型
└── base_model.dart          # 基础模型（序列化接口）
```

**影响**：

- 无法规范化处理后端数据
- JSON 序列化需手动处理，容易出错
- 分页列表无统一模型

**建议方案**：

```dart
// 示例：api_response.dart
class ApiResponse<T> {
  final int code;
  final String message;
  final T? data;

  ApiResponse({required this.code, required this.message, this.data});

  factory ApiResponse.fromJson(Map<String, dynamic> json, T Function(Object? json)? fromJsonT) {
    return ApiResponse<T>(
      code: json['code'] as int,
      message: json['message'] as String,
      data: fromJsonT != null && json['data'] != null ? fromJsonT(json['data']) : null,
    );
  }

  bool get success => code == 200;
}
```

---

### 2.2 完整网络层实现

#### 缺失项 1：HTTP 客户端实例化不完整

**当前问题**：

- `BaseProvider` 仅定义了基础结构，未处理拦截器逻辑
- 无 Token 自动注入
- 无 401 拦截与自动登出
- 无统一错误处理

**建议补充**：

```dart
// lib/app/data/providers/base_provider.dart
class BaseProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = Config.baseUrl;
    httpClient.timeout = const Duration(seconds: 30);

    // 请求拦截器：自动注入 Token
    httpClient.addRequestModifier<void>((request) {
      final token = StorageService.to.token;
      if (token != null && token.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      request.headers['Content-Type'] = 'application/json';
      return request;
    });

    // 响应拦截器：统一处理业务错误码
    httpClient.addResponseModifier((request, response) {
      if (response.statusCode == 401) {
        AuthService.to.logout();
        Get.offAllNamed(Routes.login);
      }
      return response;
    });

    super.onInit();
  }
}
```

#### 缺失项 2：网络异常处理工具类

**需要实现**：

```
lib/common/utils/
└── network_exception_handler.dart  # 统一处理 SocketException, TimeoutException 等
```

---

### 2.3 全局 UI 反馈组件

#### 缺失项：Toast/Loading/Dialog 系统

**当前问题**：

- `AppToast` 仅存在定义，未实际实现
- 无全局 Loading 蒙层
- 无标准化确认对话框

**建议方案**：
集成 `flutter_smart_dialog: ^4.9.0` 或自行封装 Overlay 实现：

```dart
// lib/common/utils/app_toast.dart
class AppToast {
  static void success(String msg) => SmartDialog.showToast(msg, displayType: SmartToastType.success);
  static void error(String msg) => SmartDialog.showToast(msg, displayType: SmartToastType.fail);

  static void showLoading([String? msg]) => SmartDialog.showLoading(msg: msg ?? 'Loading...');
  static void dismissLoading() => SmartDialog.dismiss(status: SmartStatus.loading);

  static Future<bool?> confirm({
    required String title,
    required String content,
    String? cancelText,
    String? confirmText,
  }) async {
    return await Get.dialog<bool>(
      AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(onPressed: () => Get.back(result: false), child: Text(cancelText ?? '取消')),
          TextButton(onPressed: () => Get.back(result: true), child: Text(confirmText ?? '确认')),
        ],
      ),
    );
  }
}
```

---

### 2.4 日志与调试工具

#### 缺失项：统一日志系统

**需要实现**：

```
lib/common/utils/
└── logger.dart  # 集成 logger 包或自定义 Debug/Release 分级日志
```

**建议依赖**：

```yaml
dependencies:
  logger: ^2.0.0 # 彩色日志输出
```

**实现示例**：

```dart
class AppLogger {
  static final _logger = Logger(
    printer: PrettyPrinter(methodCount: 0, errorMethodCount: 5),
  );

  static void d(dynamic message) => _logger.d(message);
  static void i(dynamic message) => _logger.i(message);
  static void w(dynamic message) => _logger.w(message);
  static void e(dynamic message, [Object? error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}
```

---

### 2.5 缓存策略与仓库层（Repository）

#### 当前问题：

- `BaseRepository` 仅空壳，无实际缓存逻辑
- 无网络优先/缓存优先策略切换
- 无离线数据持久化方案

**建议方案**：

```dart
// lib/app/data/repositories/user_repository.dart
class UserRepository {
  final _provider = Get.find<UserProvider>();
  final _storage = StorageService.to;

  // 缓存优先策略
  Future<UserModel?> getProfile({bool forceRefresh = false}) async {
    if (!forceRefresh) {
      final cached = _storage.get<String>('user_profile');
      if (cached != null) return UserModel.fromJson(jsonDecode(cached));
    }

    final response = await _provider.getProfile();
    if (response.statusCode == 200) {
      _storage.set('user_profile', jsonEncode(response.body));
      return UserModel.fromJson(response.body);
    }
    return null;
  }
}
```

---

## 三、UI/UX 增强项（中优先级）

### 3.1 下拉刷新 & 上拉加载

**缺失位置**：

- `HomeView`、`DiscoverView` 等列表页无刷新组件
- 无分页加载状态管理

**建议方案**：
集成 `pull_to_refresh: ^2.0.0` 或使用 GetX 内置 `Obx` + `RefreshController`。

---

### 3.2 空状态 & 错误页

**缺失项**：

```
lib/common/widgets/
├── empty_widget.dart       # 空列表占位图
├── error_widget.dart       # 网络错误/加载失败
└── loading_widget.dart     # 骨架屏或加载中动画
```

---

### 3.3 图片缓存与优化

**建议依赖**：

```yaml
dependencies:
  cached_network_image: ^3.3.0 # 网络图片缓存
```

**封装示例**：

```dart
// lib/common/widgets/app_image.dart
class AppImage extends StatelessWidget {
  final String url;
  final double? width, height;
  final BoxFit fit;

  const AppImage(this.url, {this.width, this.height, this.fit = BoxFit.cover, super.key});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      placeholder: (_, __) => Container(color: Colors.grey[200]),
      errorWidget: (_, __, ___) => const Icon(Icons.broken_image),
    );
  }
}
```

---

## 四、工程化与效率工具（低优先级）

### 4.1 资源文件自动化

**建议方案**：

```yaml
dev_dependencies:
  flutter_gen: ^5.4.0 # 自动生成 Assets 常量类
```

配置后自动生成：

```dart
// generated/assets.gen.dart
class Assets {
  static const String imagesLogo = 'assets/images/logo.png';
}
```

---

### 4.2 代码生成（JSON 序列化）

**建议依赖**：

```yaml
dependencies:
  json_annotation: ^4.8.0

dev_dependencies:
  build_runner: ^2.4.0
  json_serializable: ^6.7.0
```

**使用方式**：

```dart
import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final int id;
  final String name;

  UserModel({required this.id, required this.name});

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
```

---

### 4.3 屏幕适配

**可选方案**：

```yaml
dependencies:
  flutter_screenutil: ^5.9.0 # 基于设计稿尺寸适配
```

或继续使用 GetX 的 `Get.width`/`Get.height` + `LayoutBuilder` 方案。

---

### 4.4 埋点与统计

**建议实现**：

```
lib/common/utils/
└── analytics_service.dart  # 集成 Firebase Analytics 或自定义埋点
```

---

### 4.5 单元测试框架

**当前问题**：

- 无任何测试文件
- 缺少 `test/` 目录结构

**建议补充**：

```
test/
├── unit/
│   ├── services/
│   │   └── auth_service_test.dart
│   └── utils/
│       └── validator_test.dart
├── widget/
│   └── app_button_test.dart
└── integration/
    └── login_flow_test.dart
```

---

## 五、性能与安全优化

### 5.1 混淆与加固

**Android**：

```gradle
// android/app/build.gradle
buildTypes {
    release {
        minifyEnabled true
        shrinkResources true
        proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
    }
}
```

---

### 5.2 敏感信息加密

**建议方案**：

- Token 存储使用 `flutter_secure_storage`（iOS Keychain / Android Keystore）
- 或对 `GetStorage` 存储内容 AES 加密

---

### 5.3 网络安全

**缺失项**：

- 无证书绑定（Certificate Pinning）
- 无 API 签名校验

**建议依赖**：

```yaml
dependencies:
  dio: ^5.0.0 # 更强大的网络库，支持证书校验
```

---

## 四、优先级总结

| 优先级 | 功能项                         | 状态      | 实现位置/说明                                          |
| ------ | ------------------------------ | --------- | ------------------------------------------------------ |
| **P0** | 网络层拦截器完善               | ✅ 已完成 | `lib/app/data/providers/base_provider.dart`            |
| **P0** | Toast/Loading/Dialog           | ✅ 已完成 | `lib/common/utils/app_toast.dart`                      |
| **P0** | ApiResponse 统一响应模型       | ✅ 已完成 | `lib/app/data/models/api_response.dart`                |
| **P1** | Models + JSON 序列化           | ✅ 已完成 | `lib/app/data/models/*.dart`                           |
| **P1** | Repository 缓存策略            | ✅ 已完成 | `lib/app/data/repositories/user_repository.dart`       |
| **P1** | 空状态/错误页组件              | ✅ 已完成 | `lib/common/widgets/{empty,error,loading}_widget.dart` |
| **P1** | Logger 日志系统                | ✅ 已完成 | `lib/common/utils/logger.dart`                         |
| **P2** | 下拉刷新/上拉加载              | 🔲 待开发 | 建议集成 `pull_to_refresh: ^2.0.0`                     |
| **P2** | 图片缓存（CachedNetworkImage） | 🔲 待开发 | 建议封装 `AppImage` 组件                               |
| **P2** | Assets 自动化（flutter_gen）   | 🔲 待开发 | 配置 `flutter_gen: ^5.4.0`                             |
| **P3** | 屏幕适配（flutter_screenutil） | 🔲 待开发 | 可选，或继续使用 GetX                                  |
| **P3** | 单元测试框架搭建               | 🔲 待开发 | 需创建 `test/` 目录                                    |
| **P3** | 代码混淆与安全加固             | 🔲 待开发 | Android proguard / iOS 加固                            |

---

## 五、快速落地建议

| 优先级 | 缺失项                         | 预估工作量 |
| ------ | ------------------------------ | ---------- |
| **P0** | 网络层拦截器完善               | 2h         |
| **P0** | Toast/Loading/Dialog           | 3h         |
| **P0** | ApiResponse 统一响应模型       | 1h         |
| **P1** | Models + JSON 序列化           | 4h         |
| **P1** | Repository 缓存策略            | 3h         |
| **P1** | 空状态/错误页组件              | 2h         |
| **P1** | Logger 日志系统                | 1h         |
| **P2** | 下拉刷新/上拉加载              | 2h         |
| **P2** | 图片缓存（CachedNetworkImage） | 1h         |
| **P2** | Assets 自动化（flutter_gen）   | 0.5h       |
| **P3** | 屏幕适配（flutter_screenutil） | 1h         |
| **P3** | 单元测试框架搭建               | 4h         |
| **P3** | 代码混淆与安全加固             | 2h         |

---

## 五、快速落地建议

### ✅ 第一阶段（基础可用）- 已完成

1. ✅ 完善网络层拦截器（Token、401 处理）
2. ✅ 实现全局 Toast/Loading
3. ✅ 增加 ApiResponse 模型
4. ✅ 补充 Logger 日志

### ✅ 第二阶段（生产可用）- 已完成

1. ✅ 完整的 Models 层 + JSON 序列化
2. ✅ Repository 缓存策略
3. ✅ 空状态/错误页
4. 🔲 下拉刷新/上拉加载（待补充）

### 🔲 第三阶段（工程化）- 进行中

1. 资源文件自动化
2. 单元测试覆盖
3. 性能监控与埋点
4. 安全加固（混淆/证书绑定）

---

## 六、附录：当前依赖清单

### 第一阶段（基础可用）：

1. 完善网络层拦截器（Token、401 处理）
2. 实现全局 Toast/Loading
3. 增加 ApiResponse 模型
4. 补充 Logger 日志

### 第二阶段（生产可用）：

1. 完整的 Models 层 + JSON 序列化
2. Repository 缓存策略
3. 空状态/错误页
4. 下拉刷新/上拉加载

### 第三阶段（工程化）：

1. 资源文件自动化
2. 单元测试覆盖
3. 性能监控与埋点
4. 安全加固（混淆/证书绑定）

---

## 六、附录：当前依赖清单

### 已集成依赖

```yaml
dependencies:
  flutter:
    sdk: flutter

  # 核心框架
  get: ^4.6.6
  get_storage: ^2.1.1

  # UI 增强
  flutter_smart_dialog: ^4.9.0 # Toast/Loading/Dialog
  cupertino_icons: ^1.0.8

  # 工具
  logger: ^2.0.0 # 日志系统

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
```

### 推荐补充依赖（按需）

```yaml
dependencies:
  # 网络（可选，替代 GetConnect）
  dio: ^5.4.0

  # UI 增强
  cached_network_image: ^3.3.0 # 图片缓存
  pull_to_refresh: ^2.0.0 # 下拉刷新

  # 工具
  flutter_screenutil: ^5.9.0 # 屏幕适配（可选）

  # 安全
  flutter_secure_storage: ^9.0.0 # 敏感数据加密存储

  # 序列化
  json_annotation: ^4.8.0

dev_dependencies:
  # 代码生成
  build_runner: ^2.4.0
  json_serializable: ^6.7.0
  flutter_gen: ^5.4.0 # 资源文件自动化

  # 测试
  mockito: ^5.4.0 # Mock 依赖
  integration_test:
    sdk: flutter
```

---

## 七、开发日志

### 2026-01-16 第一阶段完成

**已完成功能**：

1. ✅ 网络层 BaseProvider 完善（Token 注入、401 拦截、错误处理）
2. ✅ Toast/Loading/Dialog 系统（基于 flutter_smart_dialog）
3. ✅ ApiResponse 统一响应模型
4. ✅ Logger 日志系统（基于 logger 包）
5. ✅ Models 层基础模型（UserModel、PaginationModel、BaseModel）
6. ✅ Repository 缓存策略（UserRepository 示例）
7. ✅ 空状态/错误页/加载中组件
8. ✅ NetworkExceptionHandler 网络异常处理
9. ✅ StorageService 增强（新增通用方法）
10. ✅ main.dart 集成 SmartDialog 和 Logger

**新增文件清单**：

- `lib/app/data/models/api_response.dart`
- `lib/app/data/models/base_model.dart`
- `lib/app/data/models/user_model.dart`
- `lib/app/data/models/pagination_model.dart`
- `lib/app/data/providers/user_provider.dart`
- `lib/app/data/repositories/user_repository.dart`
- `lib/common/utils/logger.dart`
- `lib/common/utils/network_exception_handler.dart`
- `lib/common/widgets/empty_widget.dart`
- `lib/common/widgets/error_widget.dart`
- `lib/common/widgets/loading_widget.dart`

**修改文件清单**：

- `pubspec.yaml` - 新增依赖：`flutter_smart_dialog: ^4.9.0`、`logger: ^2.0.0`
- `lib/main.dart` - 集成 SmartDialog、替换 debugPrint 为 AppLogger
- `lib/common/utils/app_toast.dart` - 替换为 SmartDialog 实现
- `lib/app/data/providers/base_provider.dart` - 完善拦截器与错误处理
- `lib/app/data/services/storage_service.dart` - 新增通用存储方法

**测试状态**：

- 依赖安装：✅ 成功
- Linter 检查：✅ 无错误

**下一步计划**：

1. 运行项目验证启动流程
2. 根据实际业务需求补充下拉刷新/上拉加载组件
3. 考虑引入 `cached_network_image` 进行图片优化

---

**文档生成时间**：2026-01-16  
**适用模板版本**：v1.1.0  
**维护人员**：请根据实际业务需求调整优先级

```yaml
dependencies:
  flutter:
    sdk: flutter

  # 核心框架
  get: ^4.6.6
  get_storage: ^2.1.1

  # 网络
  dio: ^5.4.0 # 可选，替代 GetConnect

  # UI 增强
  flutter_smart_dialog: ^4.9.0 # Toast/Loading/Dialog
  cached_network_image: ^3.3.0 # 图片缓存
  pull_to_refresh: ^2.0.0 # 下拉刷新

  # 工具
  logger: ^2.0.0 # 日志
  flutter_screenutil: ^5.9.0 # 屏幕适配（可选）

  # 安全
  flutter_secure_storage: ^9.0.0 # 敏感数据加密存储

  # 序列化
  json_annotation: ^4.8.0

dev_dependencies:
  flutter_test:
    sdk: flutter

  # 代码生成
  build_runner: ^2.4.0
  json_serializable: ^6.7.0
  flutter_gen: ^5.4.0 # 资源文件自动化

  # 测试
  mockito: ^5.4.0 # Mock 依赖
  integration_test:
    sdk: flutter
```

---

**文档生成时间**：2026-01-16  
**适用模板版本**：v1.0.0  
**维护人员**：请根据实际业务需求调整优先级
