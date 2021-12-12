# Kubernetes

## Minikube 的使用

**安装 Minikube：**

```shell
curl -Lo minikube https://kubernetes.oss-cn-hangzhou.aliyuncs.com/minikube/releases/v1.18.1/minikube-linux-amd64
chmod +x minikube
mv minikube /usr/local/bin/
```

**第一种方式 - docker 驱动：**

> **问题：**
>
> - X Exiting due to DRV_AS_ROOT: The "docker" driver should not be used with root privileges：
>
>   ```shell
>   # 不能以 root 运行，使用非 root，比如 minikube
>   adduser minikube
>   usermod -aG docker minikube
>   su minikube
>   ```


```shell
minikube start --image-mirror-country='cn' # 默认使用 docker 驱动
```

**第二种方式 - 无驱动：**

```shell
minikube start --driver=none --image-mirror-country='cn'
```

> **问题：**
>
> - X Exiting due to GUEST_MISSING_CONNTRACK: Sorry, Kubernetes 1.20.2 requires conntrack to be installed in root's path：
>
>   ```shell
>   yum -y install conntrack
>   ```

**查看 pods：**

```shell
# 如果没有安装 kubectl
minikube kubectl -- get pods -A
```

**Dashboard：**

```shell
# 启动 Dashboard，显示 url，而不是打开浏览器
minikube dashboard --url

# 映射到宿主机
minikube kubectl -- proxy --address='0.0.0.0' --accept-hosts='^.*$'

# 访问：
http://192.168.100.100:8001/api/v1/namespaces/kubernetes-dashboard/services/http:kubernetes-dashboard:/proxy/
```

**安装 kubelet：**

```shell
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF
yum install -y kubectl
```

安装之后 `minikube kubectl --` 就可以直接替换为 `kubectl` 命令了。

**参考：**

- [阿里云 - Minikube - Kubernetes本地实验环境](https://developer.aliyun.com/article/221687)
- [阿里云 - Kubernetes 镜像](https://developer.aliyun.com/mirror/kubernetes?spm=a2c6h.13651102.0.0.3e221b11aF2hkh)
- [Docker 官网 - Manage Docker as a non-root user](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user)

