# CICD

## docker ubuntu

卸载 docker

<https://docs.docker.com/engine/install/ubuntu/#uninstall-docker-engine>

```sh
sudo apt-get purge docker-ce docker-ce-cli containerd.io docker-compose-plugin
```

卸载 docker compose
<https://docs.docker.com/compose/install/uninstall/>

```sh
sudo rm /usr/local/bin/docker-compose
```

安装 Docker
<https://docs.docker.com/engine/install/ubuntu/>

```sh
 sudo apt-get update
 sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
```

```sh
sudo mkdir -p /etc/apt/keyrings
 curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
```

```sh
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

```sh
 apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
```

## gitea

### 域名配置

1. 配置 [server] 节点下的 SSH_DOMAIN 和 DOMAIN
1. 配置 nginx ：参考<https://docs.gitea.io/en-us/reverse-proxies/#nginx>

### 邮件服务器配置

1. 配置邮件服务器的端口：修改 app.ini 的 mailer 节点下的 HOST 添加端口
1. 配置 启用 SSL： app.ini 的 mailer 节点下添加 IS_TLS_ENABLED = true

## drone

1. .drone.yml: 一个项目对应一个 .drone.yml 配置文件
1. pipeline: 一个配置文件中可以定义多个 pipeline
1. steps： 一个 pipeline 对应一个 setups
1. step: 一个 steps 包含多个 setup,使用 setup 定义 test、build、publish 等操作

## nexus3

1. 需要创建一个添加了docker相关的权限新角色并关联给登录用户
2. 需要设置Security的Realms使Docker Bearer Token Realm为激活状态

## gitea + drone + drone runner + registry 作为 git 服务器，自动测试、构建和打包镜像并发布到私有仓库

## gitea ssh 密钥

1. 执行：sh-keygen -t ed25519 -C "youname@domain.com" 生成：%USERNAME%/.ssh/id_ed25519.pub
1. 配置：<http://10.10.14.176:3000/user/settings/keys> 添加id_ed25519.pub内容作为key

## docker compose 显式配置网络后才能访问到宿主机 ip

```
networks:
    default:
        name: mynetwork
        driver: bridge
        ipam:
            config:
                - subnet: 172.172.0.0/24
```

## 修改docker配置使用镜像和私有http仓库

修改 /etc/docker/daemon.json 文件的 registry-mirrors 和 insecure-registries属性

```
{
  "registry-mirrors": [
    "https://registry.docker-cn.com",
    "http://hub-mirror.c.163.com",
    "https://docker.mirrors.ustc.edu.cn"
  ],
  "insecure-registries": ["10.10.14.176:5000"]
}
```

systemctl daemon-reload
systemctl restart docker
docker info

## 其他

1. <https://docs.drone.io/pipeline/docker/examples/>
1. drone 环境变量：<https://github.com/drone/drone/blob/master/operator/runner/env.go>
1. 邮件通知：<http://plugins.drone.io/drillster/drone-email/>
