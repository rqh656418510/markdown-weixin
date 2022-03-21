FROM node:14-stretch

MAINTAINER clay<clay@gmail.com>

# 创建用户
RUN groupadd tengine && useradd -g tengine tengine

# 更换软件源
RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak && \
    echo "deb http://mirrors.aliyun.com/debian/ stretch main non-free contrib" > /etc/apt/sources.list && \
    echo "deb http://mirrors.aliyun.com/debian-security stretch/updates main" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.aliyun.com/debian/ stretch-updates main non-free contrib" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.aliyun.com/debian/ stretch-backports main non-free contrib" >> /etc/apt/sources.list

# 安装依赖
RUN apt-get -y update && apt-get -y upgrade && \
    apt-get -y install vim tree htop apt-utils net-tools telnet wget curl && \
    apt-get -y install autoconf git build-essential libpcre3 libpcre3-dev zlib1g zlib1g.dev openssl libssl-dev && \
    apt-get -y autoclean && apt-get -y autoremove

# 定义Tengine的版本号
ENV VERSION 2.2.3

# 下载并解压文件
RUN mkdir -p /usr/local/src/
ADD http://tengine.taobao.org/download/tengine-$VERSION.tar.gz /usr/local/src
RUN tar -xvf /usr/local/src/tengine-$VERSION.tar.gz -C /usr/local/src/

# 创建安装目录
ENV TENGINE_HOME /usr/local/tengine
RUN mkdir -p $TENGINE_HOME

# 进入解压目录
WORKDIR /usr/local/src/tengine-$VERSION

# 编译安装
RUN ./configure \
        --user=tengine \
        --group=tengine \
        --prefix=$TENGINE_HOME \
        --with-http_ssl_module \
        --with-http_realip_module \
        --with-http_concat_module  \
        --with-http_gzip_static_module \
        --with-http_stub_status_module \
        --with-http_upstream_consistent_hash_module \
    && make \
    && make install

# 设置环境变量
ENV PATH $PATH:$TENGINE_HOME/sbin

# 定义APP目录
ENV APP_HOME $TENGINE_HOME/html

# 编译APP项目
RUN mkdir -p /tmp/markdown-weixin \
    && git clone https://github.com/rqh656418510/markdown-weixin /tmp/markdown-weixin \
    && cd /tmp/markdown-weixin \
    && npm config set registry https://registry.npm.taobao.org \
    && npm install \
    && npm run build

# 拷贝APP项目编译后的文件
RUN mkdir -p $APP_HOME \
    && rm -rf $APP_HOME/* \
    && cp -R -rf /tmp/markdown-weixin/docs/* $APP_HOME

# 清理文件
RUN rm -rf /usr/local/src && rm -rf /tmp/markdown-weixin

# 设置默认工作目录
WORKDIR $APP_HOME

# 暴露端口
EXPOSE 80
EXPOSE 443

CMD $TENGINE_HOME/sbin/nginx -g 'daemon off;' -c $TENGINE_HOME/conf/nginx.conf
