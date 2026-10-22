## 检测WebRTC泄漏网站

IP质量检测/WebRTC泄漏检测：[ippure.com](https://ippure.com)
备用WebRTC泄漏检测：[ipleak.net](https://ipleak.net)

## 概念

Web Real-Time Communication 是*浏览器*提供的实时音视频与点对点数据通道技术

WebRTC 泄漏指使用浏览器或某些应用时，WebRTC 的连接流程（ICE候选交换）意外暴露了本地或真实公网IP地址，导致即使使用代理，目标网站或第三方还可看到真实IP地址或局域网地址

## 简要原理

1. 建立P2P连接时，浏览器通过 STUN/TURN server 获取 ICE candidiates （候选连接地址） ，包括：
	- `host` 本地局域网IP
	- `srflx` 通过 STUN 获得的公网映射IP
	- `relay` 通过 TURN 中继的地址
2. 如果浏览器本地或网页脚本暴露/发送了`host`或`srflx`类型的候选，第三方就可能获知本机真实IP （包括局域网IP与公网真实IP）
3. VPN/代理通常只影响浏览器的普通 HTTP(S) 流量，但 WebRTC 的 STUN 请求可能绕过这些路径，从而暴露真实地址

---

## Chrome扩展避免WebRTC泄漏

- WebRTC Network Limiter
- WebRTC Leak Prevent

> [!NOTE]
> Adguard Adblocker也可避免泄漏，在 settings -> Tracking protection -> Block WebRTC 中打开即可