# 静态站点：VPS 上构建后 `docker run -p 8080:80 <镜像名>` 访问 http://服务器IP:8080
FROM nginx:1.27-alpine
COPY *.html /usr/share/nginx/html/
EXPOSE 80
