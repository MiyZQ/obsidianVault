## 检测DNS泄漏网站

- [browserleaks.com](https://browserleaks.com/dns)
- [ipleak.net](https://ipleak.net)
- [dnscheck.tools](https://www.dnscheck.tools/) （测试 DNS 解析结果是否由 DNSSEC 校验）
- [cloudflare.com](https://www.cloudflare.com/zh-cn/ssl/encrypted-sni/) （cloudflare esni 测试是补充测试，有四个勾最好）

## 概念

- *DNS*：域名解析，把域名转成IP（`baidu.com` -> `110.242.68.66`）TCP/IP 通信必须有IP才能建立连接
- *DNS泄漏*：本应由代理（跳板/代理服务器）完成的 DNS 查询，从本机网路发出或曾发出，暴露了访问意图
- *FakeIP*：给本机返回占位的假IP（常见`198.18.x.x`）本机用假IP建连，真正的解析由代理端完成，避免本机泄漏

## 发生DNS泄漏原因

- 本机在建立 TCP 连接前会发 DNS ，使用代理时若流程或路由不当，就会在本地触发解析
- 某些路由规则需要*把域名解析成IP*来做IP匹配（fallback情形）这类情况最容易导致本地DNS请求

## 泄漏后果

- 本地运营商/网管能看到你访问了哪个站点
- 目标网站可能根据DNS判断地理位置，进而拒绝服务

---

## Clash示例的两次DNS场景

- 第一次（建连）：浏览器发起 -> 触发 FakeIP -> 得到假IP -> 建立连接（正常）
- 第二次（路由）：在路由判断时若需要IP来匹配规则，会发DNS得真实IP；若该解析在本地发生就会泄漏

> [!NOTE]
> 第二次中*需要把域名解析后再匹配IP*是最危险的情况

## 防止DNS泄漏的实操

- 优先使用 Tun+FakeIP 模式，让本地只拿假IP，真实解析在代理端进行
- 路由优先使用*域名匹配*，对会触发本地解析的场景，启用 no-resolve（跳过本地解析，继续按域名匹配）
- 可选：开启全局模式能简单粗暴避免大部分泄漏，但牺牲灵活性和体验，不是首选
- 对被劫持或敏感域名，强制走节点或为其指定独立 nameserver-policy （单独DNS服务器）

## Q&A

- *全局能否万无一失？* 一般可，但极少数协议（如 QUIC/基于 UDP）也可能泄漏，需额外处理（如浏览器关闭 QUIC）
- *要不要用 mosdns？* 单纯为防泄漏通常没必要，因其规则与代理分流重复，只有需要DNS缓存、IP择优等功能时再考虑
- *本地APP随机ping外网地址会泄漏吗？* ping返回的是 FakeIP，不会直接暴露真实目标，但视具体路由/规则实现

## DNS劫持

- 被判为 Direct（直连）的域名在本地解析时可能被篡改/劫持
- 处理方法：把这类域名强制走代理节点，或为其指定专用DNS（nameserver-policy）

> [!Summary]
> 1. 使用 Tun+FakeIP
> 2. 路由尽量使用域名匹配，启用 no-resolve
> 3. 对少数被劫持或敏感域名设专用DNS或强制代理