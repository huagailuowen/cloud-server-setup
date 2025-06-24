# Install : 
https://sing-box.sagernet.org/

# Config :

+ server : add to '/etc/sing-box/config.json' :


+ client : add to clash
```json
# 基础设置
port: 7897
socks-port: 7891
mixed-port: 7892
allow-lan: true
mode: global
log-level: info
external-controller: 127.0.0.1:9090

# 代理配置 - 连接到 Cloudflare 代理的 Xray 服务器
proxies:
  - name: 'AZ-US-fan'
    type: 'ss'
    server: '4.227.43.235'
    port: 48033
    cipher: '2022-blake3-aes-128-gcm'
    password: 'ctm1J9WiE1Sdc0nl7v7Pdg=='
    udp: true
  - name: 'AZ-US-luowen'
    type: 'ss'
    server: '57.154.177.170'
    port: 62608
    cipher: '2022-blake3-aes-128-gcm'
    password: '0ZyWm9T22bnxMAd2KUTLPA=='
    udp: true

# 代理组配置
proxy-groups:
  - name: "🚀 节点选择"
    type: select
    proxies:
      - AZ-US-fan
      - AZ-US-luowen
      - DIRECT

  - name: "🌍 国外网站"
    type: select
    proxies:
      - "🚀 节点选择"
      - DIRECT

  - name: "📲 电报信息"
    type: select
    proxies:
      - "🚀 节点选择"

  - name: "🎬 国外媒体"
    type: select
    proxies:
      - "🚀 节点选择"

  - name: "🎯 全球直连"
    type: select
    proxies:
      - DIRECT

  - name: "🛑 广告拦截"
    type: select
    proxies:
      - REJECT
      - DIRECT

# 规则配置
rules:
  - DOMAIN-SUFFIX,google.com,🌍 国外网站
  - DOMAIN-SUFFIX,github.com,🌍 国外网站
  - DOMAIN-SUFFIX,youtube.com,🎬 国外媒体
  - DOMAIN-SUFFIX,netflix.com,🎬 国外媒体
  - DOMAIN-SUFFIX,telegram.org,📲 电报信息
  - DOMAIN-KEYWORD,telegram,📲 电报信息
  - DOMAIN-KEYWORD,google,🌍 国外网站
  - DOMAIN-KEYWORD,youtube,🎬 国外媒体
  - DOMAIN-SUFFIX,cn,🎯 全球直连
  - GEOIP,CN,🎯 全球直连
  - MATCH,🚀 节点选择
```