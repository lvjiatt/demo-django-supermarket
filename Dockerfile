# 1. 基础镜像（使用Python 3.7，项目要求的版本）
FROM python:3.7-slim

# 2. 设置环境变量
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1

# 3. 安装系统依赖（MySQL客户端开发库）
RUN apt-get update && apt-get install -y \
    default-libmysqlclient-dev \
    gcc \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# 4. 设置工作目录
WORKDIR /app

# 5. 复制依赖文件并安装Python依赖
COPY requirements /app/requirements
RUN pip install --upgrade pip && \
    pip install -r requirements

# 6. 复制项目文件到容器
COPY . /app/

# 7. 暴露端口
EXPOSE 8001

# 8. 启动命令（可选）默认启动开发服务器
CMD ["python", "manage.py", "runserver", "0.0.0.0:8001"]
