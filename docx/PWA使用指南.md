# Flutter Web PWA 使用指南

## 快速开始

### 1. 配置 PWA（首次使用）

```bash
# 使用默认配置
./scripts/setup_pwa.sh

# 自定义配置
./scripts/setup_pwa.sh "我的应用" "#FF5722" "#ffffff"
```

**参数说明**：

- 第 1 个参数：应用名称（默认：My Flutter App）
- 第 2 个参数：主题色（默认：#2196F3）
- 第 3 个参数：背景色（默认：#ffffff）

---

### 2. 构建并打包

```bash
# 使用默认文件名（包含时间戳）
./scripts/build_pwa.sh

# 自定义文件名
./scripts/build_pwa.sh my_app_v1.0
```

**输出**：

- ZIP 文件：`dist/flutter_pwa_YYYYMMDD_HHMMSS.zip`
- 校验和：`dist/flutter_pwa_YYYYMMDD_HHMMSS.zip.sha256`

---

### 3. 部署

#### 方式 1：Vercel（最简单）

```bash
# 解压
unzip dist/flutter_pwa_*.zip -d deploy

# 部署
cd deploy
npm i -g vercel
vercel --prod
```

#### 方式 2：Netlify（拖拽式）

1. 解压 ZIP 文件
2. 打开 [app.netlify.com/drop](https://app.netlify.com/drop)
3. 拖拽文件夹到浏览器
4. 自动部署完成

#### 方式 3：自有服务器

**Nginx**：

```bash
# 解压到服务器
scp dist/flutter_pwa_*.zip user@server:/tmp/
ssh user@server
cd /tmp
unzip flutter_pwa_*.zip -d /var/www/html

# 配置 Nginx（参考 nginx.conf.example）
sudo vim /etc/nginx/sites-available/default
sudo systemctl restart nginx
```

**Apache**：

```bash
# 解压到网站根目录
unzip dist/flutter_pwa_*.zip -d /var/www/html

# .htaccess 已自动生成，确保启用模块
sudo a2enmod rewrite deflate
sudo systemctl restart apache2
```

---

## 文件说明

### 核心文件

```
web/
├── index.html          # 已配置禁止缩放
├── manifest.json       # PWA 配置（已优化）
├── icons/              # 应用图标
│   ├── Icon-192.png
│   ├── Icon-512.png
│   ├── Icon-maskable-192.png
│   └── Icon-maskable-512.png
├── .htaccess           # Apache 配置（自动生成）
└── nginx.conf.example  # Nginx 配置示例
```

### 脚本文件

```
scripts/
├── setup_pwa.sh   # PWA 配置工具
└── build_pwa.sh   # 打包工具
```

---

## 验证清单

部署后，请检查以下项：

- [ ] 使用 HTTPS 访问（必须）
- [ ] manifest.json 可正常访问
- [ ] Service Worker 已注册
- [ ] 图标显示正常
- [ ] Android Chrome 可安装
- [ ] iOS Safari 可添加到主屏幕

**测试工具**：

- [Lighthouse](https://developers.google.com/web/tools/lighthouse)
- [PWA Builder](https://www.pwabuilder.com/)

---

## 常见问题

### Q1：执行脚本提示权限错误

```bash
chmod +x scripts/*.sh
```

---

### Q2：Android 无法安装

**检查**：

1. 是否使用 HTTPS
2. manifest.json 是否正确
3. Service Worker 是否加载
4. 图标文件是否存在

---

### Q3：iOS 添加后无法全屏

**原因**：iOS Safari 对 PWA 支持有限

**解决**：确保 `index.html` 中包含：

```html
<meta name="apple-mobile-web-app-capable" content="yes" />
```

---

### Q4：Service Worker 未更新

**方法 1**：强制刷新

- Chrome: `Ctrl/Cmd + Shift + R`
- Safari: `Cmd + Option + E`

**方法 2**：清除缓存

- Chrome DevTools → Application → Clear Storage

---

### Q5：图标未显示

**检查项**：

1. 图标尺寸是否准确（192×192, 512×512）
2. 图标格式是否为 PNG
3. manifest.json 中路径是否正确

---

## 技术支持

- 官方文档：[docs.flutter.dev/platform-integration/web](https://docs.flutter.dev/platform-integration/web)
- PWA 指南：[web.dev/progressive-web-apps](https://web.dev/progressive-web-apps/)
- 问题反馈：提交 Issue 到项目仓库

---

**最后更新**：2026-01-16  
**版本**：v1.0
