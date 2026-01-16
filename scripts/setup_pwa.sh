#!/bin/bash

# Flutter Web PWA 配置脚本
# 功能：自动配置 PWA 必要文件
# 使用：./scripts/setup_pwa.sh [app_name] [theme_color] [bg_color]

set -e

# 默认参数
APP_NAME="${1:-My Flutter App}"
SHORT_NAME="${APP_NAME:0:12}"
THEME_COLOR="${2:-#2196F3}"
BG_COLOR="${3:-#ffffff}"

echo "======================================"
echo "Flutter Web PWA 配置工具"
echo "======================================"
echo "应用名称: $APP_NAME"
echo "主题色: $THEME_COLOR"
echo "背景色: $BG_COLOR"
echo "======================================"

# 1. 更新 manifest.json
echo "✓ 配置 manifest.json..."
cat > web/manifest.json <<EOF
{
    "name": "$APP_NAME",
    "short_name": "$SHORT_NAME",
    "start_url": "/",
    "display": "standalone",
    "background_color": "$BG_COLOR",
    "theme_color": "$THEME_COLOR",
    "description": "A Flutter PWA Application",
    "orientation": "portrait",
    "prefer_related_applications": false,
    "icons": [
        {
            "src": "icons/Icon-192.png",
            "sizes": "192x192",
            "type": "image/png",
            "purpose": "any"
        },
        {
            "src": "icons/Icon-512.png",
            "sizes": "512x512",
            "type": "image/png",
            "purpose": "any"
        },
        {
            "src": "icons/Icon-maskable-192.png",
            "sizes": "192x192",
            "type": "image/png",
            "purpose": "maskable"
        },
        {
            "src": "icons/Icon-maskable-512.png",
            "sizes": "512x512",
            "type": "image/png",
            "purpose": "maskable"
        }
    ]
}
EOF

# 2. 更新 index.html
echo "✓ 配置 index.html（禁止缩放）..."
sed -i '' '/<meta name="description"/a\
  \
  <!-- PWA 关键配置：禁止缩放 -->\
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
' web/index.html 2>/dev/null || true

# 3. 检查图标文件
echo "✓ 检查图标文件..."
ICONS_DIR="web/icons"
if [ ! -d "$ICONS_DIR" ]; then
    echo "❌ 错误: $ICONS_DIR 目录不存在"
    exit 1
fi

REQUIRED_ICONS=("Icon-192.png" "Icon-512.png" "Icon-maskable-192.png" "Icon-maskable-512.png")
for icon in "${REQUIRED_ICONS[@]}"; do
    if [ ! -f "$ICONS_DIR/$icon" ]; then
        echo "⚠️  警告: 缺少图标 $icon"
    else
        echo "  ✓ $icon"
    fi
done

# 4. 生成 .htaccess（Apache 服务器用）
echo "✓ 生成 .htaccess..."
cat > web/.htaccess <<EOF
# 启用 HTTPS
RewriteEngine On
RewriteCond %{HTTPS} off
RewriteRule ^(.*)$ https://%{HTTP_HOST}%{REQUEST_URI} [L,R=301]

# Service Worker 缓存控制
<FilesMatch "flutter_service_worker.js">
  Header set Cache-Control "no-cache, no-store, must-revalidate"
  Header set Pragma "no-cache"
  Header set Expires 0
</FilesMatch>

# 启用压缩
<IfModule mod_deflate.c>
  AddOutputFilterByType DEFLATE text/html text/css text/javascript application/javascript application/json
</IfModule>

# 设置 Manifest MIME 类型
AddType application/manifest+json .webmanifest
AddType application/manifest+json .json
EOF

# 5. 生成 nginx 配置示例
echo "✓ 生成 nginx.conf 示例..."
cat > web/nginx.conf.example <<EOF
server {
    listen 80;
    server_name your-domain.com;
    
    # 强制 HTTPS
    return 301 https://\$host\$request_uri;
}

server {
    listen 443 ssl http2;
    server_name your-domain.com;
    
    # SSL 证书配置（替换为实际路径）
    ssl_certificate /path/to/cert.pem;
    ssl_certificate_key /path/to/key.pem;
    
    root /var/www/html;
    index index.html;
    
    # Service Worker 不缓存
    location ~ /flutter_service_worker\.js$ {
        add_header Cache-Control "no-cache, no-store, must-revalidate";
        add_header Pragma "no-cache";
        add_header Expires 0;
    }
    
    # 静态资源缓存
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg|woff|woff2|ttf)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }
    
    # 单页应用路由
    location / {
        try_files \$uri \$uri/ /index.html;
    }
    
    # Gzip 压缩
    gzip on;
    gzip_types text/plain text/css application/json application/javascript text/xml application/xml;
}
EOF

echo ""
echo "======================================"
echo "✅ PWA 配置完成！"
echo "======================================"
echo ""
echo "下一步："
echo "1. 确保图标文件完整（192x192, 512x512）"
echo "2. 运行：flutter build web --web-renderer canvaskit"
echo "3. 部署到 HTTPS 服务器"
echo "4. 使用手机浏览器访问并安装"
echo ""
echo "部署参考："
echo "- Apache: 使用生成的 .htaccess"
echo "- Nginx: 参考 nginx.conf.example"
echo "- Vercel/Netlify: 直接部署 build/web 目录"
echo ""
