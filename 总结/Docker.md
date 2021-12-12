# Docker

## CentOS 安装 Docker

**卸载：**

```shell
yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine
```

**添加源：**

```shell
# 使用 yum 工具添加源
yum install -y yum-utils
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

# 或者直接下载
curl -o /etc/yum.repos.d/docker-ce.repo https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

# 查看版本
yum list docker-ce --showduplicates
```

**安装：**

```shell
# 安装最新版本
yum -y install docker-ce docker-ce-cli containerd.io

# 安装指定版本
yum -y install --setopt=obsoletes=0 docker-ce-18.06.3.ce-3.el7

# 开机启动并立即启动
systemctl enable docker --now
```

**镜像加速：** [阿里云 - 镜像加速](https://cr.console.aliyun.com/cn-hangzhou/instances/mirrors)

```shell
mkdir -p /etc/docker
tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://xxx.mirror.aliyuncs.com"]
}
EOF
systemctl daemon-reload
systemctl restart docker
```

**参考：**

- [官方文档 - Install Docker Engine on CentOS](https://docs.docker.com/engine/install/centos/)

