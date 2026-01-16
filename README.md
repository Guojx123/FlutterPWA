# Flutter Template 项目说明

## 项目概述

这是一个完整的 Flutter 模板项目，集成了企业级开发所需的核心功能与最佳实践。

---

## 核心特性

### 1. 基础架构

- ✅ GetX 状态管理框架
- ✅ 命名路由系统
- ✅ 启动引导页（Splash）
- ✅ 登录模块
- ✅ 主页底部导航（Main/Home/Discover/Profile）
- ✅ 路由中间件（AuthGuard）
- ✅ 全局服务（Storage、Auth、Theme）
- ✅ 国际化支持

### 2. 网络层

- ✅ BaseProvider 完善拦截器
- ✅ Token 自动注入
- ✅ 401 自动拦截登出
- ✅ 统一错误处理
- ✅ 请求/响应日志

### 3. 数据层

- ✅ ApiResponse 统一响应模型
- ✅ Models 层（User、Pagination、Base）
- ✅ Repository 缓存策略
- ✅ 网络异常处理工具类

### 4. UI 组件

- ✅ PageContainer
- ✅ CustomAppBar
- ✅ AppButton
- ✅ AppTextField
- ✅ AppBadge
- ✅ EmptyWidget（空状态）
- ✅ ErrorWidget（错误页）
- ✅ LoadingWidget（加载中）
- ✅ RefreshListView（下拉刷新/上拉加载）
- ✅ AppImage（图片缓存）

### 5. 工具类

- ✅ Logger（分级日志）
- ✅ AppToast（Toast/Loading/Dialog）
- ✅ ScreenUtil（屏幕适配）
- ✅ NetworkExceptionHandler（网络异常处理）

### 6. 测试

- ✅ 单元测试框架
- ✅ 组件测试
- ✅ 集成测试

### 7. 工程化

- ✅ Assets 自动化配置
- ✅ 代码混淆（Android ProGuard）
- ✅ PWA 支持（Flutter Web）

---

## 技术栈

```yaml
核心框架:
  - Flutter SDK 3.35.4
  - Dart 3.9.2
  - GetX 4.6.6

UI 增强:
  - flutter_smart_dialog 4.9.0
  - pull_to_refresh 2.0.0
  - cached_network_image 3.3.0

工具:
  - get_storage 2.1.1
  - logger 2.0.0
  - json_annotation 4.8.0

开发工具:
  - build_runner 2.4.0
  - json_serializable 6.7.0
  - flutter_gen_runner 5.4.0
  - mockito 5.4.0
```

---

## 项目结构

```
lib/
├── app/
│   ├── data/
│   │   ├── models/          # 数据模型
│   │   ├── providers/       # API 客户端
│   │   ├── repositories/    # 数据仓库
│   │   └── services/        # 全局服务
│   ├── modules/             # 业务模块
│   │   ├── splash/
│   │   ├── login/
│   │   ├── main/
│   │   ├── home/
│   │   ├── discover/
│   │   └── profile/
│   └── routes/              # 路由配置
├── common/
│   ├── config/              # 配置
│   ├── i18n/                # 国际化
│   ├── middleware/          # 中间件
│   ├── styles/              # 样式
│   ├── utils/               # 工具类
│   └── widgets/             # 通用组件
└── main.dart                # 入口

test/
├── unit/                    # 单元测试
├── widget/                  # 组件测试
└── integration/             # 集成测试

scripts/
├── setup_pwa.sh             # PWA 配置脚本
└── build_pwa.sh             # PWA 打包脚本

docx/
├── Flutter_Web_PWA完整方案.md
└── PWA使用指南.md
```

---

## 快速开始

### 1. 环境准备

```bash
# 检查 Flutter 环境
flutter doctor

# 安装依赖
flutter pub get
```

---

### 2. 运行项目

```bash
# iOS
flutter run -d ios

# Android
flutter run -d android

# Web
flutter run -d chrome
```

---

### 3. 构建发布

```bash
# Android APK
flutter build apk --release

# iOS IPA
flutter build ios --release

# Web PWA
./scripts/build_pwa.sh
```

---

## PWA 部署（Flutter Web）

本项目已配置 PWA 支持，可直接部署为 Web 应用。

### 配置 PWA

```bash
# 使用默认配置
./scripts/setup_pwa.sh

# 自定义配置
./scripts/setup_pwa.sh "应用名称" "#主题色" "#背景色"
```

### 构建打包

```bash
./scripts/build_pwa.sh
```

### 部署

详见 `docx/PWA使用指南.md`

---

## 开发规范

### 代码风格

遵循 [Effective Dart](https://dart.dev/guides/language/effective-dart) 规范。

### 命名规范

- 文件名：`snake_case`
- 类名：`PascalCase`
- 变量/方法：`camelCase`
- 常量：`kConstantName`

### Git 提交规范

```
feat: 新功能
fix: 修复 Bug
docs: 文档更新
style: 代码格式调整
refactor: 重构
test: 测试相关
chore: 构建/工具链
```

---

## 常见问题

### Q1：如何修改应用名称？

1. Android: `android/app/src/main/AndroidManifest.xml`
2. iOS: `ios/Runner/Info.plist`
3. Web PWA: `web/manifest.json`

---

### Q2：如何更换 App 图标？

```bash
# 使用 flutter_launcher_icons
flutter pub add dev:flutter_launcher_icons
flutter pub run flutter_launcher_icons
```

---

### Q3：如何配置后端 API 地址？

编辑 `lib/common/config/config.dart`：

```dart
class Config {
  static const String baseUrl = 'https://your-api.com';
}
```

---

### Q4：如何运行测试？

```bash
# 单元测试
flutter test test/unit/

# 组件测试
flutter test test/widget/

# 集成测试
flutter test integration_test/
```

---

## 贡献指南

1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 提交 Pull Request

---

## 许可证

MIT License

---

## 联系方式

- 项目地址：[GitHub](https://github.com/your-repo/template)
- 问题反馈：[Issues](https://github.com/your-repo/template/issues)
- 文档站点：[Docs](https://your-docs-site.com)

---

**最后更新**：2026-01-16  
**版本**：v2.0.0  
**维护状态**：活跃维护中
