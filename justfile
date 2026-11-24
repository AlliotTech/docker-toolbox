platform := "linux/amd64"

# 构建完整版（ubuntu 24.04 + aws cli + 各类客户端/调试工具）
build-full:
  docker buildx build --platform {{platform}} --load -f Dockerfile -t ghcr.io/AlliotTech/docker-toolbox:full .

# 构建网络工具版（alpine）
build-net:
  docker buildx build --platform {{platform}} --load -f Dockerfile.net -t ghcr.io/AlliotTech/docker-toolbox:net .

# 在 k8s 中临时启动网络工具箱
run-net:
  kubectl run --rm toolbox -it --image ghcr.io/AlliotTech/docker-toolbox:net bash -n default
