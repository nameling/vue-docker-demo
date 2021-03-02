# 使用node 6.10.3作为node基础版本
FROM node:6.10.3-slim

# 安装nginx
RUN apt-get update \
    && apt-get install -y nginx

# 指定工作目录
WORKDIR /app

# 将当前目录下左右文件copy到工作目录下
COPY . /app/

# 声明运行时提供服务器端口
EXPOSE 80

# 1.安装依赖
# 2.运行npm run build
# 3.将dist目录下所有文件copy到nginx目录下
# 4.删除工作目录的文件，尤其是node_modules，减小镜像体积
# 由于镜像构建的每一步都会产生数据，为了减小镜像体积，尽可能将一些同类操作，集成到一个步骤，如下；

RUN npm install \
    && npm run build \
    && cp -r dist/* /var/www/html \
    && rm -rf /app

# 以前台方式启动nginx
CMD ["nginx", "-g", "daemon off;"]
