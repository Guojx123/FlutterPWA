#!/bin/bash

# Flutter Web PWA 打包脚本
# 功能：构建并打包成 ZIP 文件，方便部署
# 使用：./scripts/build_pwa.sh [output_name]

set -e

# 输出文件名
OUTPUT_NAME="${1:-flutter_pwa_$(date +%Y%m%d_%H%M%S)}"
BUILD_DIR="build/web"
OUTPUT_DIR="dist"
ZIP_FILE="$OUTPUT_DIR/$OUTPUT_NAME.zip"

echo "======================================"
echo "Flutter Web PWA 打包工具"
echo "======================================"
echo "输出文件: $ZIP_FILE"
echo "======================================"

# 1. 检查 Flutter 环境
echo "✓ 检查 Flutter 环境..."
if ! command -v flutter &> /dev/null; then
    echo "❌ 错误: 未安装 Flutter"
    exit 1
fi
echo "  Flutter 版本: $(flutter --version | head -n 1)"

# 2. 清理旧构建
echo "✓ 清理旧构建..."
if [ -d "$BUILD_DIR" ]; then
    rm -rf "$BUILD_DIR"
fi
if [ ! -d "$OUTPUT_DIR" ]; then
    mkdir -p "$OUTPUT_DIR"
fi

# 3. 构建 Flutter Web
echo "✓ 构建 Flutter Web（生产模式）..."
flutter build web \
    --release \
    --no-source-maps

# 4. 优化构建产物
echo "✓ 优化构建产物..."

# 检查文件大小
echo "  构建产物大小:"
du -sh "$BUILD_DIR"

# 检查关键文件
REQUIRED_FILES=(
    "index.html"
    "manifest.json"
    "flutter.js"
    "flutter_service_worker.js"
    "icons/Icon-192.png"
    "icons/Icon-512.png"
)

for file in "${REQUIRED_FILES[@]}"; do
    if [ ! -f "$BUILD_DIR/$file" ]; then
        echo "⚠️  警告: 缺少文件 $file"
    fi
done

# 5. 创建部署说明文件
echo "✓ 生成部署说明..."
cat > "$BUILD_DIR/DEPLOY.md" <<'EOF'
# Flutter Web PWA 部署指南

## 快速部署

### 方式 1：Vercel（推荐）
```bash
npm i -g vercel
vercel --prod
```

### 方式 2：Netlify
1. 拖拽此文件夹到 [netlify.com/drop](https://app.netlify.com/drop)
2. 自动部署完成

### 方式 3：Firebase Hosting
```bash
npm i -g firebase-tools
firebase login
firebase init hosting
firebase deploy
```

### 方式 4：Nginx
1. 将文件复制到 `/var/www/html`
2. 参考 `nginx.conf.example` 配置
3. 重启 Nginx: `sudo systemctl restart nginx`

### 方式 5：Apache
1. 将文件复制到网站根目录
2. `.htaccess` 已自动生成
3. 确保启用 `mod_rewrite` 和 `mod_deflate`

## 重要提示

⚠️ **必须使用 HTTPS，否则无法安装 PWA**

检查清单：
- [ ] 已配置 HTTPS 证书
- [ ] manifest.json 正确配置
- [ ] 图标文件完整（192x192, 512x512）
- [ ] Service Worker 正常加载

## 测试 PWA

### Android
1. 使用 Chrome 打开网址
2. 点击地址栏「安装」图标
3. 桌面出现 App 图标

### iOS
1. 使用 Safari 打开网址
2. 点击「分享」→「添加到主屏幕」
3. 完成安装

## 性能优化建议

1. 启用 CDN 加速
2. 配置 Gzip/Brotli 压缩
3. 设置静态资源缓存
4. 使用 HTTP/2

## 常见问题

### Service Worker 未更新
```bash
# 清除浏览器缓存
# Chrome: DevTools → Application → Clear Storage
```

### 图标未显示
- 检查图标路径是否正确
- 确保图标尺寸准确
- 验证 MIME 类型

---

**构建时间**: $(date)
**Flutter 版本**: $(flutter --version | head -n 1)
EOF

# 6. 打包 ZIP
echo "✓ 打包 ZIP 文件..."
cd "$BUILD_DIR"
zip -r "../../$ZIP_FILE" . -x "*.DS_Store" "*.map"
cd ../..

# 7. 生成校验和
echo "✓ 生成 SHA256 校验和..."
if command -v shasum &> /dev/null; then
    shasum -a 256 "$ZIP_FILE" > "$ZIP_FILE.sha256"
    echo "  SHA256: $(cat $ZIP_FILE.sha256 | cut -d' ' -f1)"
fi

# 8. 显示结果
FILE_SIZE=$(du -h "$ZIP_FILE" | cut -f1)
echo ""
echo "======================================"
echo "✅ 打包完成！"
echo "======================================"
echo ""
echo "输出文件: $ZIP_FILE"
echo "文件大小: $FILE_SIZE"
echo ""
echo "下一步："
echo "1. 解压 ZIP 文件"
echo "2. 上传到 HTTPS 服务器"
echo "3. 使用手机浏览器访问"
echo "4. 安装 PWA 应用"
echo ""
echo "快速部署命令："
echo "  unzip $ZIP_FILE -d deploy"
echo "  cd deploy && vercel --prod"
echo ""
