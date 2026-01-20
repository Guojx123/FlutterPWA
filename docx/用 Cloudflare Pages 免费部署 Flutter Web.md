**只讲 Cloudflare Pages，而且一步一步来，按 Flutter Web / PWA 的真实流程走**。
你照着做，不需要 Web 基础，也不需要额外花钱。

---

# 用 Cloudflare Pages 免费部署 Flutter Web（支持 PWA 安装）

> **目标**
> 把你的 **Flutter Web** 部署到 Cloudflare Pages，
> 手机用 Chrome / Safari 打开后可以 **安装到桌面**。

---

## 一、你现在需要准备的东西（先对照）

请确认你有：

* ✅ Flutter SDK（你已经有）
* ✅ 一个 Flutter 项目（支持 Web）
* ✅ GitHub 账号（必须）
* ✅ 能科学访问 Cloudflare（页面加载需要）

如果这些都 OK，继续。

---

## 二、Step 1：确认 Flutter 项目支持 Web

在项目根目录执行一次：

```bash
flutter devices
```

如果能看到：

```text
Chrome
Web Server
```

说明 Web 已启用。

如果没有，执行：

```bash
flutter config --enable-web
```

---

## 三、Step 2：构建 Flutter Web（关键）

在项目根目录执行：

```bash
flutter build web
```

成功后你会得到：

```text
build/web/
```

里面包含：

* `index.html`
* `manifest.json`
* `flutter_service_worker.js`

👉 **这一步完成，你已经是一个 PWA 雏形了**

---

## 四、Step 3：检查 / 修改 PWA 配置（非常重要）

### 1️⃣ 编辑 `web/manifest.json`

推荐配置（你可以直接用）：

```json
{
  "name": "My Flutter App",
  "short_name": "MyApp",
  "start_url": ".",
  "display": "standalone",
  "background_color": "#000000",
  "theme_color": "#000000",
  "orientation": "portrait",
  "icons": [
    {
      "src": "icons/Icon-192.png",
      "sizes": "192x192",
      "type": "image/png"
    },
    {
      "src": "icons/Icon-512.png",
      "sizes": "512x512",
      "type": "image/png"
    }
  ]
}
```

📌 **重点字段**

* `display: standalone` → 全屏 App
* `start_url: "."` → Cloudflare Pages 必须这样写

---

### 2️⃣ 图标路径确认

确保存在：

```text
web/icons/Icon-192.png
web/icons/Icon-512.png
```

然后**重新构建一次**：

```bash
flutter build web
```

---

## 五、Step 4：把项目推到 GitHub

### 1️⃣ 初始化 Git（如果还没）

```bash
git init
git add .
git commit -m "init flutter web pwa"
```

### 2️⃣ 推送到 GitHub（公开仓库即可）

```bash
git remote add origin https://github.com/你的用户名/你的仓库名.git
git push -u origin main
```

---

## 六、Step 5：在 Cloudflare Pages 创建项目

### 1️⃣ 打开 Cloudflare Pages

👉 [https://pages.cloudflare.com/](https://pages.cloudflare.com/)

登录 Cloudflare（用邮箱即可）

---

### 2️⃣ 创建新项目

* 点击 **Create a project**
* 选择 **Connect to Git**
* 授权 GitHub
* 选择你的 Flutter 项目仓库

---

### 3️⃣ 构建配置（重点！）

在设置页面填写：

#### Framework preset

```
None
```

#### Build command

```
flutter build web
```

⚠️ **注意**
Cloudflare Pages 默认环境没有 Flutter，需要额外配置。

---

## 七、Step 6：给 Cloudflare Pages 安装 Flutter（关键步骤）

在 **Build settings → Environment variables** 添加：

### 1️⃣ 添加 Flutter SDK 下载

新增变量：

| Key             | Value          |
| --------------- | -------------- |
| FLUTTER_VERSION | 3.19.0（或你本地版本） |

---

### 2️⃣ 修改 Build command（完整命令）

把 Build command 改成：

```bash
git clone https://github.com/flutter/flutter.git -b $FLUTTER_VERSION &&
export PATH="$PATH:`pwd`/flutter/bin" &&
flutter doctor &&
flutter build web
```

---

### 3️⃣ Output directory（非常重要）

```
build/web
```

---

## 八、Step 7：部署并等待完成

点击 **Save and Deploy**

第一次构建：

* 时间：3–5 分钟
* 成功后会得到一个地址，例如：

```text
https://xxxx.pages.dev
```

---

## 九、Step 8：手机安装验证（见证时刻）

### Android

1. Chrome 打开 pages.dev 链接
2. 地址栏出现「安装 App」
3. 点击安装
4. 桌面出现图标

### iOS

1. Safari 打开
2. 分享 → 添加到主屏幕
3. 全屏启动

---

## 十、常见问题（你大概率会遇到）

### ❓ 没有「安装 App」按钮？

检查：

* HTTPS ✔️
* `manifest.json` 是否生效
* `display: standalone`
* 图标路径是否 404

---

### ❓ 页面刷新 404？

Cloudflare Pages 默认是静态站
你需要加 `_redirects` 文件：

```text
/* /index.html 200
```

放在 `web/` 目录，然后重新 build + push。

---

## 十一、持续部署（自动化更新）

> **核心概念**：一旦配置好，每次 `git push` 后 Cloudflare Pages 自动构建并部署新版本。

---

### 工作原理

```
本地修改代码
    ↓
git push 到 GitHub
    ↓
Cloudflare Pages 自动检测
    ↓
自动构建 Flutter Web
    ↓
自动部署到 pages.dev
    ↓
用户访问到最新版本
```

---

### 实操流程（完整演示）

#### 1️⃣ 修改代码

例如，修改 `lib/main.dart` 中的文本：

```dart
Text('Hello World v2.0'), // 从 v1.0 改成 v2.0
```

---

#### 2️⃣ 提交并推送

```bash
# 查看改动
git status

# 添加到暂存
git add .

# 提交
git commit -m "feat: 更新首页文案到 v2.0"

# 推送到 GitHub
git push
```

---

#### 3️⃣ Cloudflare Pages 自动构建

推送后：

1. 打开 Cloudflare Pages 控制台
2. 进入你的项目
3. 看到 **Deployments** 标签页
4. 会有一条新的构建记录，状态：**Building...**

---

#### 4️⃣ 等待构建完成

- 时间：3-5 分钟
- 状态变为：**Success**
- 自动部署到 `https://xxxx.pages.dev`

---

#### 5️⃣ 验证更新

```bash
# 在浏览器打开（强制刷新）
# Chrome: Ctrl/Cmd + Shift + R
# Safari: Cmd + Option + E
```

或者**清除 Service Worker 缓存**（PWA 需要）：

1. Chrome DevTools → Application
2. Service Workers → Unregister
3. 刷新页面

---

### 分支部署（进阶）

Cloudflare Pages 支持多分支部署：

| 分支         | 部署地址                              | 用途         |
| ------------ | ------------------------------------- | ------------ |
| main/master  | `https://xxxx.pages.dev`              | 生产环境     |
| develop      | `https://develop.xxxx.pages.dev`      | 测试环境     |
| feature/xxx  | `https://feature-xxx.xxxx.pages.dev`  | 功能预览     |

**自动规则**：

- 推送到 `main` → 自动部署生产环境
- 推送到其他分支 → 自动生成预览链接

---

### 配置生产分支（可选）

在 Cloudflare Pages 控制台：

1. 进入项目 Settings
2. Builds & deployments
3. Production branch：选择 `main`（或 `master`）
4. Preview branches：选择 `All branches`

---

### 回滚到上一版本

如果新版本有问题：

1. Cloudflare Pages → Deployments
2. 找到上一个成功的部署
3. 点击右侧 **⋯**
4. 选择 **Rollback to this deployment**

或者用 Git 回滚：

```bash
# 回退到上一个提交
git revert HEAD

# 推送
git push
```

---

### 部署通知（可选）

在 Cloudflare Pages 设置 Webhook：

1. Settings → Notifications
2. Add webhook
3. 选择事件：
   - Deployment started
   - Deployment succeeded
   - Deployment failed
4. 输入 Webhook URL（如 Slack / Discord）

---

### 常见问题

#### ❓ 推送后没有自动构建？

**检查**：

1. GitHub 仓库是否已授权 Cloudflare Pages
2. 推送的分支是否在 Cloudflare Pages 监听范围内
3. Cloudflare Pages 项目是否已暂停

---

#### ❓ 构建失败怎么办？

**解决步骤**：

1. Cloudflare Pages → 点击失败的部署
2. 查看 Build logs
3. 定位错误（通常是 Flutter 版本不匹配或依赖问题）
4. 修复后重新推送

---

#### ❓ 如何加快构建速度？

**优化方法**：

1. 使用固定 Flutter 版本（避免每次下载）
2. 启用 Cloudflare Pages 缓存（默认开启）
3. 减少不必要的依赖

---

## 十二、你现在已经做到什么程度？

✔️ Flutter Web  
✔️ 免费部署  
✔️ HTTPS  
✔️ 可安装 PWA  
✔️ 自动持续部署（CI/CD）  
✔️ 多分支预览  
✔️ 不用上架  
✔️ 零成本

**这已经超过 90% Flutter 开发者能做到的程度。**

---

