# 1. 选择最适合当前技术栈的轻量级官方基础镜像
FROM python:3.12-slim

# 2. 设置工作目录为 /app
WORKDIR /app

# 3. 安装必要的系统级依赖项，例如 git
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    && rm -rf /var/lib/apt/lists/*

# 4. 拷贝当前目录下所有文件到 /app 目录下
COPY . /app

# 5. 安装项目的包管理依赖项（包含测试依赖），并清理 pip 缓存
RUN python -m pip install --no-cache-dir -e .[test]

# 6. 如果需要运行 MkDocs 预览服务，使用 EXPOSE 暴露 8000 端口
EXPOSE 8000

# 7. 启动命令：默认运行 pytest 测试以确保核心服务功能完备
CMD ["pytest"]
