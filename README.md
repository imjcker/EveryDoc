# EveryDoc
scripts for development,deploy,tools...  

1. 安装frps服务  
    ```shell script
    curl "https://github.com/imjcker/EveryDoc/frp_installation_on_centos_7.sh" -o "frp_install.sh"
    
   # docker run -d --name frpc --restart always -v /etc/frp/frpc.ini:/frp/frpc.ini imjcker/frpc:v0.34.3
    ```
2. docker安装（centos7）
    ```shell script
    curl "https://github.com/imjcker/EveryDoc/docker_installation_on_centos_7.sh" -o "docker_install.sh"
    
    ```
3. bbr加速
    ```shell script
    curl "https://github.com/imjcker/EveryDoc/bbr.sh" -o "bbr.sh"
    
    ```
4. pip安装
    ```shell script
    curl "https://github.com/imjcker/EveryDoc/get-pip.py" -o "get-pip.py"
    
    ```   
