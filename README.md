# docker-toolbox

个人常用工具箱镜像，由 GitHub Actions 每周自动构建并推送到 GHCR（linux/amd64 + linux/arm64），基础镜像与软件包随构建自动更新。

## 镜像

| Tag | 说明 |
|---|---|
| `ghcr.io/AlliotTech/docker-toolbox:full` | Ubuntu 24.04：AWS CLI v2、mysql/redis/postgres 客户端、常用调试与网络工具 |
| `ghcr.io/AlliotTech/docker-toolbox:net` | Alpine：网络排查工具箱——nmap、tcpdump、tshark、mtr、socat、grpcurl、kcat、masscan 等 |

每次构建同时生成带日期的 tag（`full-YYYYMMDD` / `net-YYYYMMDD`），可用于固定版本回滚。

## 使用

```bash
docker run --rm -it ghcr.io/AlliotTech/docker-toolbox:net

# k8s 里临时起一个
kubectl run --rm toolbox -it --image ghcr.io/AlliotTech/docker-toolbox:net bash
```

## 构建策略

- 触发：每周一 UTC 03:17 定时构建、push 到 `main`、手动 `workflow_dispatch`
- 平台：linux/amd64 + linux/arm64
- 缓存：GitHub Actions cache（`type=gha`）
- 基础镜像浮动：`ubuntu:24.04`（随补丁版本更新）、`alpine:latest`（随版本升级，可能跨大版本）

## 本地构建

```bash
just build-full   # 构建完整版
just build-net    # 构建网络版
```
