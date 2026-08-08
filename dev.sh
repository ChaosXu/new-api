#!/usr/bin/env bash
# dev.sh — 本地构建与调试 new-api（SQLite 零依赖，go run + 日志调试）
#
# 用法：
#   ./dev.sh backend    # 仅启动后端（前台 go run，Gin debug + DEBUG 日志）
#   ./dev.sh frontend   # 仅启动前端（Rsbuild HMR，:5173，API 代理到 :3000）
#   ./dev.sh all        # 同时启动前后端（推荐日常开发）
#   ./dev.sh status     # 检查端口占用与依赖
#
# 环境变量（可在 .env 或 shell 中覆盖）：
#   PORT                后端端口（默认 3000）
#   SQLITE_PATH         SQLite 数据库文件路径（默认 ./data/one-api.db）
#   GIN_MODE            Gin 运行模式（默认 debug，便于调试）
#   DEBUG               new-api 调试模式（默认 true）
#   FRONTEND_PORT       前端 dev server 端口（默认 5173）
#
# 不启动 Docker / Postgres / Redis；不安装 Delve。
# 需要完整前端产物请用 `make build-web`。

set -euo pipefail

# ---------- 路径与默认值 ----------
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$REPO_ROOT"

BACKEND_PID=""

# 默认值（shell 中已 export 的同名变量优先级更高，不会被覆盖）
: "${PORT:=3000}"
: "${SQLITE_PATH:=$REPO_ROOT/data/one-api.db}"
: "${GIN_MODE:=debug}"
: "${DEBUG:=true}"
: "${FRONTEND_PORT:=5173}"

export PORT SQLITE_PATH GIN_MODE DEBUG FRONTEND_PORT

# ---------- 工具函数 ----------
log()  { printf '\033[1;32m[dev]\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m[dev]\033[0m %s\n' "$*" >&2; }
err()  { printf '\033[1;31m[dev]\033[0m %s\n' "$*" >&2; }

# 检测某个端口是否被监听；未被占用返回 1
port_in_use() {
  local port="$1"
  lsof -nP -iTCP:"$port" -sTCP:LISTEN >/dev/null 2>&1
}

# 确保 web/dist/index.html 存在（//go:embed 编译需要）。
# 若已有真实构建产物则保持不动；否则写入最小占位。
ensure_web_dist_placeholder() {
  local target="$REPO_ROOT/web/dist/index.html"
  if [[ -f "$target" ]]; then
    return 0
  fi
  log "web/dist/index.html 不存在，创建最小占位以满足 //go:embed 编译"
  mkdir -p "$REPO_ROOT/web/dist"
  cat >"$target" <<'HTML'
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>new-api (placeholder)</title>
  </head>
  <body>
    <p>Backend dev placeholder. Run the frontend with: ./dev.sh frontend</p>
  </body>
</html>
HTML
}

# 确保 SQLite 数据库目录存在
ensure_sqlite_dir() {
  local db_dir
  db_dir="$(dirname "$SQLITE_PATH")"
  mkdir -p "$db_dir"
}

# 检查依赖工具是否存在
check_deps() {
  local missing=()
  command -v go  >/dev/null 2>&1 || missing+=(go)
  command -v bun >/dev/null 2>&1 || missing+=(bun)
  command -v lsof >/dev/null 2>&1 || missing+=(lsof)
  if (( ${#missing[@]} > 0 )); then
    err "缺少依赖工具: ${missing[*]}（请先安装）"
    exit 1
  fi
}

# 启动后端（前台）
start_backend() {
  check_deps
  if port_in_use "$PORT"; then
    err "端口 $PORT 已被占用，请释放或更换 PORT 环境变量"
    lsof -nP -iTCP:"$PORT" -sTCP:LISTEN >&2 || true
    exit 1
  fi
  ensure_web_dist_placeholder
  ensure_sqlite_dir

  log "启动后端 (go run main.go)"
  log "  PORT=$PORT  GIN_MODE=$GIN_MODE  DEBUG=$DEBUG"
  log "  SQLITE_PATH=$SQLITE_PATH"
  log "  健康检查: curl http://localhost:$PORT/api/status"
  log "  Ctrl+C 退出"
  echo "---------------------------------------------------------------"

  # 前台运行；main.go 会自动 godotenv.Load(".env")，
  # 这里已 export 的同名变量优先级更高，确保调试模式生效。
  exec go run main.go
}

# 启动前端（前台）
start_frontend() {
  check_deps
  if port_in_use "$FRONTEND_PORT"; then
    err "端口 $FRONTEND_PORT 已被占用，请释放或更换 FRONTEND_PORT 环境变量"
    lsof -nP -iTCP:"$FRONTEND_PORT" -sTCP:LISTEN >&2 || true
    exit 1
  fi

  log "安装前端依赖 (bun install)"
  (cd "$REPO_ROOT/web" && bun install)

  log "启动前端 dev server (Rsbuild HMR)"
  log "  http://localhost:$FRONTEND_PORT"
  log "  API 代理到 http://localhost:$PORT （由 VITE_REACT_APP_SERVER_URL 控制）"
  log "  Ctrl+C 退出"
  echo "---------------------------------------------------------------"

  # rsbuild.config.ts 默认 VITE_REACT_APP_SERVER_URL=http://localhost:3000
  # 这里显式 export，确保与后端 PORT 对齐
  export VITE_REACT_APP_SERVER_URL="http://localhost:$PORT"

  cd "$REPO_ROOT/web"
  exec bun run dev --host 0.0.0.0 --port "$FRONTEND_PORT"
}

# 同时启动前后端
start_all() {
  check_deps

  if port_in_use "$PORT"; then
    err "端口 $PORT 已被占用"; lsof -nP -iTCP:"$PORT" -sTCP:LISTEN >&2 || true; exit 1
  fi
  if port_in_use "$FRONTEND_PORT"; then
    err "端口 $FRONTEND_PORT 已被占用"; lsof -nP -iTCP:"$FRONTEND_PORT" -sTCP:LISTEN >&2 || true; exit 1
  fi

  ensure_web_dist_placeholder
  ensure_sqlite_dir

  # 后端：后台运行，日志带前缀
  log "后台启动后端 → http://localhost:$PORT (GIN_MODE=$GIN_MODE, DEBUG=$DEBUG, SQLITE=$SQLITE_PATH)"
  # 启动一个带前缀的日志管道，便于在混合输出中区分
  ( exec go run main.go 2>&1 | sed -u 's/^/[api] /' ) &
  BACKEND_PID="$!"

  # 清理：退出时 kill 后端进程组
  cleanup() {
    echo ""
    log "收到退出信号，清理子进程..."
    if [[ -n "$BACKEND_PID" ]]; then
      # kill 整个进程组（go run 会派生编译子进程）
      kill -- "-$BACKEND_PID" 2>/dev/null || kill "$BACKEND_PID" 2>/dev/null || true
    fi
    wait 2>/dev/null || true
    log "已退出"
  }
  trap cleanup EXIT INT TERM

  # 等待后端就绪（最多 30 秒）
  log "等待后端就绪..."
  local i
  for ((i = 0; i < 60; i++)); do
    if curl -sf "http://localhost:$PORT/api/status" >/dev/null 2>&1; then
      log "后端就绪 ✓"
      break
    fi
    # 检查后端进程是否已退出
    if ! kill -0 "$BACKEND_PID" 2>/dev/null; then
      err "后端进程意外退出，请检查上方 [api] 日志"
      exit 1
    fi
    sleep 0.5
  done

  # 前端：前台运行（HMR），退出时由 trap 清理后端
  log "前台启动前端 → http://localhost:$FRONTEND_PORT"
  echo "---------------------------------------------------------------"
  export VITE_REACT_APP_SERVER_URL="http://localhost:$PORT"
  (cd "$REPO_ROOT/web" && bun install)
  cd "$REPO_ROOT/web"
  exec bun run dev --host 0.0.0.0 --port "$FRONTEND_PORT"
}

# 状态检查
show_status() {
  log "依赖检查："
  command -v go  >/dev/null 2>&1 && echo "  go    $(go version)" || echo "  go    缺失"
  command -v bun >/dev/null 2>&1 && echo "  bun   $(bun --version)" || echo "  bun   缺失"
  command -v lsof >/dev/null 2>&1 && echo "  lsof  已安装" || echo "  lsof  缺失"

  echo ""
  log "端口占用："
  for p in "$PORT" "$FRONTEND_PORT"; do
    if port_in_use "$p"; then
      echo "  :$p  占用"
      lsof -nP -iTCP:"$p" -sTCP:LISTEN 2>/dev/null | sed 's/^/    /' || true
    else
      echo "  :$p  空闲"
    fi
  done

  echo ""
  log "文件状态："
  [[ -f "$REPO_ROOT/web/dist/index.html" ]] && echo "  web/dist/index.html  存在" || echo "  web/dist/index.html  缺失（首次启动后端会自动创建占位）"
  [[ -f "$REPO_ROOT/.env" ]] && echo "  .env  存在（main.go 会自动加载）" || echo "  .env  不存在（使用脚本默认值）"
}

# ---------- 入口 ----------
usage() {
  cat <<EOF
用法: ./dev.sh <command>

命令:
  backend    仅启动后端（go run + 日志调试，SQLite）
  frontend   仅启动前端（Rsbuild HMR，API 代理到 :$PORT）
  all        同时启动前后端（推荐）
  status     检查依赖、端口占用、文件状态
  help       显示本帮助

环境变量（可覆盖）:
  PORT=$PORT  GIN_MODE=$GIN_MODE  DEBUG=$DEBUG
  SQLITE_PATH=$SQLITE_PATH
  FRONTEND_PORT=$FRONTEND_PORT
EOF
}

case "${1:-help}" in
  backend)  start_backend ;;
  frontend) start_frontend ;;
  all)      start_all ;;
  status)   show_status ;;
  help|-h|--help) usage ;;
  *) err "未知命令: $1"; usage; exit 1 ;;
esac
