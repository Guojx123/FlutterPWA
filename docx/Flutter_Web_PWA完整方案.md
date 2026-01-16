# Flutter Web PWA 完整方案

> **一句话定义**  
> 用 **Flutter 写 Web 应用**，通过 **PWA 能力**，让它 **像 App 一样安装到手机桌面**，  
> **不用写 iOS / Android，不用上架应用商店**。

---

## 一、这个方案适合谁？

✅ 你只会 Flutter  
✅ 想快速把想法做成「可安装 App」  
✅ 做的是工具 / MVP / Demo / 小产品  
❌ 不追求重度原生能力（蓝牙、后台服务等）

---

## 二、最终效果是什么？

安装后，用户看到的是：

- 📱 桌面 **App 图标**
- 🚀 点击后 **全屏运行**
- 🔌 **支持离线（基础）**
- 🧠 使用体验 ≈ 原生 App（80%）

---

## 三、整体技术结构

```
Flutter UI
   ↓
Flutter Web
   ↓
PWA（Manifest + Service Worker）
   ↓
浏览器安装到桌面
```

---

## 四、技术 / 资源清单

### 必须具备

- Flutter SDK（你已经有）
- Flutter Web（官方支持）
- HTTPS 部署环境

### 不需要

- ❌ 原生 iOS / Android
- ❌ Web 框架（React / Vue）
- ❌ App Store / 应用市场

---

## 五、完整实操流程

### Step 1：用 Flutter 写「App 形态」UI

你照常写 Flutter，只注意 **3 个原则**：

1️⃣ 移动端优先（375 × 812 心里有数）  
2️⃣ 单列布局  
3️⃣ 底部 / 顶部导航明确

常见结构：

```dart
Scaffold(
  appBar: AppBar(...), // 可选
  body: Column / ListView,
  bottomNavigationBar: BottomNavigationBar(...),
)
```

---

### Step 2：构建 Flutter Web

```bash
flutter build web
```

Flutter 会自动生成：

- `build/web/index.html`
- `build/web/manifest.json`
- `build/web/flutter_service_worker.js`

👉 **你已经拥有一个 PWA 雏形了**

---

### Step 3：配置 PWA（最关键）

#### 1️⃣ 修改 `web/manifest.json`

```json
{
  "name": "My Flutter App",
  "short_name": "MyApp",
  "start_url": "/",
  "display": "standalone",
  "background_color": "#ffffff",
  "theme_color": "#2196F3",
  "orientation": "portrait",
  "icons": [
    {
      "src": "icons/Icon-192.png",
      "sizes": "192x192",
      "type": "image/png",
      "purpose": "maskable any"
    },
    {
      "src": "icons/Icon-512.png",
      "sizes": "512x512",
      "type": "image/png",
      "purpose": "maskable any"
    }
  ]
}
```

**关键字段说明：**

| 字段                | 作用          |
| ------------------- | ------------- |
| display: standalone | 全屏 App 模式 |
| start_url           | 启动入口路径  |
| theme_color         | 状态栏颜色    |
| background_color    | 启动页背景色  |
| orientation         | 屏幕方向锁定  |
| icons               | 应用图标列表  |

---

#### 2️⃣ 配置 App 图标

路径：`web/icons/`

至少需要：

- `Icon-192.png` (192×192)
- `Icon-512.png` (512×512)

**图标规范**：

- 格式：PNG
- 背景：不透明（避免黑边）
- 尺寸：准确匹配
- 命名：与 manifest.json 一致

---

#### 3️⃣ 修改 `web/index.html` - 禁止缩放

在 `<head>` 中添加/修改：

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"
    />

    <!-- PWA 必需 -->
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="apple-mobile-web-app-title" content="My Flutter App" />

    <!-- Favicon -->
    <link rel="icon" type="image/png" href="favicon.png" />
    <link rel="apple-touch-icon" href="icons/Icon-192.png" />

    <!-- Manifest -->
    <link rel="manifest" href="manifest.json" />

    <title>My Flutter App</title>
  </head>
  <body>
    <script src="flutter.js" defer></script>
  </body>
</html>
```

**关键配置说明**：

| 配置                         | 作用                 |
| ---------------------------- | -------------------- |
| user-scalable=no             | 禁止双指缩放         |
| maximum-scale=1.0            | 最大缩放比例 100%    |
| apple-mobile-web-app-capable | iOS 添加到主屏幕支持 |
| apple-mobile-web-app-title   | iOS 桌面图标名称     |

---

### Step 4：优化 Service Worker（可选但推荐）

Flutter 默认生成的 Service Worker 已包含基础离线能力。

如需自定义，编辑 `web/flutter_service_worker.js` 或创建自定义 SW。

**基础示例**（已由 Flutter 自动生成）：

```javascript
// 缓存核心资源
const CACHE_NAME = "flutter-app-cache";
const RESOURCES = {
  "/": "index.html",
  "main.dart.js": "xxx",
  // ... 其他资源
};

// 安装事件
self.addEventListener("install", (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

// 拦截请求
self.addEventListener("fetch", (event) => {
  event.respondWith(
    caches.match(event.request).then((response) => {
      return response || fetch(event.request);
    })
  );
});
```

---

### Step 5：部署（必须 HTTPS）

#### 推荐部署平台

| 平台         | 特点                | 适用场景   |
| ------------ | ------------------- | ---------- |
| Vercel       | 零配置，自动 HTTPS  | 个人项目   |
| Netlify      | 拖拽部署，免费 SSL  | 快速验证   |
| GitHub Pages | 免费，集成 CI/CD    | 开源项目   |
| Firebase     | Google 官方，CDN 快 | 国际化产品 |
| Cloudflare   | 全球 CDN，免费      | 高性能需求 |

#### 部署步骤（以 Vercel 为例）

```bash
# 1. 安装 Vercel CLI
npm i -g vercel

# 2. 构建 Flutter Web
flutter build web

# 3. 部署
cd build/web
vercel --prod
```

⚠️ **没有 HTTPS → 无法安装 PWA**

---

### Step 6：手机安装验证

#### Android（Chrome / Edge）

1. Chrome 打开网址
2. 地址栏出现「安装」图标
3. 点击「安装」
4. 桌面自动添加图标

#### iOS（Safari）

1. Safari 打开网址
2. 点击「分享」按钮
3. 选择「添加到主屏幕」
4. 自定义名称（可选）
5. 完成安装

🎉 **到这里，PWA 安装完成**

---

## 六、体验增强（强烈推荐）

### 1️⃣ 禁止缩放（已在 Step 3 配置）

```html
<meta
  name="viewport"
  content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"
/>
```

---

### 2️⃣ Safe Area 适配（Flutter）

```dart
SafeArea(
  child: Scaffold(...),
)
```

---

### 3️⃣ 启动加载优化

**方法 1：Splash Screen**

```dart
class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', width: 120),
            SizedBox(height: 24),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
```

**方法 2：Skeleton UI**

使用 `shimmer` 包显示占位骨架。

---

### 4️⃣ 离线提示

```dart
// 检测网络状态
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) {
        if (snapshot.data == ConnectivityResult.none) {
          return Container(
            color: Colors.red,
            padding: EdgeInsets.all(8),
            child: Text('当前离线模式', textAlign: TextAlign.center),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
```

---

## 七、性能优化建议

### 1️⃣ 减小包体积

```bash
# 构建生产版本（默认自动优化）
flutter build web --release

# 禁用源码映射（减小体积）
flutter build web --release --no-source-maps
```

> **注意**：Flutter 3.x 版本已移除 `--web-renderer` 参数，渲染器自动选择。

---

### 2️⃣ 资源懒加载

```dart
// 延迟加载图片
CachedNetworkImage(
  imageUrl: url,
  placeholder: (context, url) => CircularProgressIndicator(),
);
```

---

### 3️⃣ 分包加载

```yaml
# pubspec.yaml
flutter:
  deferred-components:
    - name: feature_module
```

---

## 八、限制与权衡

| 能力       | PWA 支持度          | 原生 App   |
| ---------- | ------------------- | ---------- |
| 性能       | ⭐⭐⭐⭐ (80%)      | ⭐⭐⭐⭐⭐ |
| 离线支持   | ⭐⭐⭐⭐ (基础)     | ⭐⭐⭐⭐⭐ |
| 推送通知   | ⭐⭐⭐ (Android 好) | ⭐⭐⭐⭐⭐ |
| 系统 API   | ⭐⭐⭐ (有限)       | ⭐⭐⭐⭐⭐ |
| 包体大小   | ⭐⭐⭐ (偏大)       | ⭐⭐⭐⭐   |
| 安装便捷性 | ⭐⭐⭐⭐⭐ (极佳)   | ⭐⭐⭐     |
| 分发成本   | ⭐⭐⭐⭐⭐ (零成本) | ⭐⭐       |

👉 **对工具 / MVP / Demo 完全够用**

---

## 九、什么时候"该升级"？

当你遇到这些情况时，考虑升级到原生：

- ✅ 用户量突破 1 万
- ✅ 需要推送通知（iOS）
- ✅ 需要后台任务
- ✅ 需要系统级权限（蓝牙、NFC）
- ✅ 追求极致性能

**升级路径**：

```
Flutter Web PWA
     ↓
Flutter 原生 App
     ↓
Flutter + 原生混合开发
```

**不是现在。**

---

## 十、常见问题 FAQ

### Q1：PWA 能在所有手机上安装吗？

**A：** 几乎可以。Android 5+ 和 iOS 11.3+ 都支持，覆盖 95%+ 用户。

---

### Q2：安装后能离线使用吗？

**A：** 基础功能可以，但需要提前访问过。首次打开必须联网。

---

### Q3：PWA 包体有多大？

**A：** Flutter Web 默认约 2-3 MB（压缩后），比原生 App 大，但通过网络加载，用户无感知。

---

### Q4：能发推送通知吗？

**A：** Android 支持完整推送，iOS 需要用户主动添加到主屏幕后才支持（限制较多）。

---

### Q5：能上架应用市场吗？

**A：** 不能直接上架。但可以通过 TWA（Trusted Web Activities）包装后上传 Google Play。

---

### Q6：性能真的够用吗？

**A：** 对常见业务场景（表单、列表、图文）完全够用。重度游戏或视频编辑不推荐。

---

## 十一、一句话总结

> **Flutter Web + PWA = Flutter 开发者最快的"免上架 App"方案。**

---

## 十二、相关资源

### 官方文档

- [Flutter Web 官方文档](https://docs.flutter.dev/platform-integration/web)
- [PWA 官方指南](https://web.dev/progressive-web-apps/)
- [Manifest 规范](https://developer.mozilla.org/en-US/docs/Web/Manifest)

### 工具推荐

- [PWA Builder](https://www.pwabuilder.com/) - PWA 配置生成工具
- [Lighthouse](https://developers.google.com/web/tools/lighthouse) - PWA 质量检测
- [Web.dev](https://web.dev/measure/) - 性能测试

### 示例项目

- [Flutter Gallery Web](https://gallery.flutter.dev/) - 官方示例
- [Flutter PWA Template](https://github.com/flutter/samples/tree/main/web/web_app) - 模板项目

---

**文档版本**：v1.0  
**更新时间**：2026-01-16  
**维护人员**：请根据实际项目需求调整配置
