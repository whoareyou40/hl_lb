# Hyperliquid Leaderboard（静态站点）

本项目是**纯静态 HTML** 页面（无需后端服务），可直接部署到免费静态托管平台（推荐 Vercel）。

## 目录结构

- `leaderboard.html`：排行榜页面（读取参赛者列表 + 请求 Hyperliquid API）
- `index.html`：个人统计页面（支持 `?addr=0x...` 参数）
- `admin.html`：参赛者管理（数据存浏览器 `localStorage`）
- `participants.js`：**内置参赛者名单**（首次运行会被写入本地存储，之后可在后台增删改）

## 本地预览

任意方式起一个静态服务器即可，例如：

```bash
cd "/Users/dolmchen/量化/leaderboard"
python3 -m http.server 8000
```

然后访问：

- `http://localhost:8000/leaderboard.html`
- `http://localhost:8000/admin.html`
- `http://localhost:8000/index.html`

## 部署：GitHub → Vercel（免费）

### 1) 推送代码到 GitHub

1. 在 GitHub 新建仓库（建议 Public）：例如 `leaderboard`
2. 在本地项目目录初始化并推送：

```bash
cd "/Users/dolmchen/量化/leaderboard"

git init
git add .
git commit -m "Initial commit"

git branch -M main
git remote add origin https://github.com/<你的用户名>/<仓库名>.git
git push -u origin main
```

> 如果你使用 SSH，把 `origin` 换成 `git@github.com:<你的用户名>/<仓库名>.git`。

### 2) 在 Vercel 导入并部署

1. 打开并登录 Vercel：`https://vercel.com`
2. 进入控制台，点击 **Add New… → Project**
3. 选择 **Import Git Repository**，选中你的 GitHub 仓库并 **Import**
4. 配置构建（本项目是纯静态站点，通常保持默认即可）：
   - **Framework Preset**：`Other`（或保持默认）
   - **Root Directory**：`.`（仓库根目录）
   - **Build Command**：留空
   - **Output Directory**：留空或 `.`（静态资源在仓库根目录）
5. 点击 **Deploy**，等待完成后会得到一个 `*.vercel.app` 的访问地址

### 3) 验证

部署成功后访问以下路径应正常：

- `/leaderboard.html`
- `/admin.html`
- `/index.html`

## 更新发布（推荐流程）

Vercel 会在你 **push 到 GitHub** 后自动重新部署。

### 日常更新步骤

1. 本地修改代码（如 `*.html`、`participants.js` 等）
2. 提交并推送：

```bash
git add .
git commit -m "Update: <简要说明>"
git push
```

3. 打开 Vercel 项目的 **Deployments**，可以看到新的部署记录；部署完成后线上自动生效

### 常见注意事项

- **参赛者数据存储位置**：`admin.html` 的参赛者列表保存在当前浏览器的 `localStorage` 中。
  - 首次打开会用 `participants.js` 的内置名单初始化
  - 之后你在 `admin.html` 的增删改只影响你当前这台设备/这个浏览器（清缓存/换设备会丢）
- **想让所有人都看到同一份参赛者名单**：
  - 直接改 `participants.js` 后提交并 push（线上默认名单就会更新）
  - 已经在某些浏览器里保存过旧名单的用户：把 `participants.js` 里的 `HL_LOCAL_DATA_VERSION` **+1** 并部署；用户下次打开页面会自动清掉旧的 `hl_participants` / `hl_lb_cache` 并重新用内置名单初始化

