# 运行阶段
FROM alpine:3.20

ARG TARGETARCH

WORKDIR /root/

RUN apk --no-cache add ca-certificates tzdata

# 复制之前在 Github Actions 中已经编译好的对应架构的可执行文件
COPY TGFileBot-linux-${TARGETARCH} ./TGBot

# 确保可执行权限
RUN chmod +x ./TGBot

# 确保配置文件和目录存在
RUN mkdir -p files

ENV TZ=Asia/Shanghai
ENV LOG=""

# 使用 sh -c 启动以支持环境变量展开和参数追加
# ${LOG_PATH:+-log $LOG_PATH} 会在 LOG_PATH 变量非空时自动展开为 -log 参数
ENTRYPOINT ["/bin/sh", "-c", "./TGBot -files ./files ${LOG:+-log $LOG} \"$@\"", "--"]

