# VERSION 0.0.1
# 使用zh121100/redis镜像
FROM zh121100/redis
# 签名
MAINTAINER qhzhang "zh121100@163.com"

# 安装zookeeper
ADD ./zookeeper-3.4.8.tar.gz /usr/local/
ADD ./zoo.cfg /usr/local/zookeeper-3.4.8/conf
RUN mv /usr/local/zookeeper-3.4.8 /usr/local/zookeeper && \
    mkdir -p /app/zookeeper/data && \
    mkdir -p /app/zookeeper/log

# Expose ports.
EXPOSE 2181

# SSH终端服务器作为后台运行
ENTRYPOINT  echo "export JAVA_HOME=/usr/local/jdk" >> /etc/profile && \
            echo "export PATH=$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH" >> /etc/profile && \
            echo "export CLASSPATH=$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:CLASSPATH" >> /etc/profile && \
            source /etc/profile && \
            /usr/sbin/sshd -D
