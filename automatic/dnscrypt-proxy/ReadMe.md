﻿# <img src="https://cdn.jsdelivr.net/gh/chtof/chocolatey-packages/automatic/dnscrypt-proxy/dnscrypt-proxy.png" width="48" height="48"/> [DNSCrypt Proxy](https://chocolatey.org/packages/dnscrypt-proxy)

## Features
- DNS traffic encryption and authentication. Supports DNS-over-HTTPS (DoH) using TLS 1.3, and DNSCrypt.
- DNS query monitoring, with separate log files for regular and suspicious queries
- Filtering: block ads, malware, and other unwanted content. Compatible with all DNS services
- Time-based filtering, with a flexible weekly schedule
- Transparent redirection of specific domains to specific resolvers
- DNS caching, to reduce latency and improve privacy
- Local IPv6 blocking to reduce latency on IPv4-only networks
- Load balancing: pick a set of resolvers, dnscrypt-proxy will automatically measure and keep track of their speed, and balance the traffic across the fastest available ones.
- Cloaking: like a HOSTS file on steroids, that can return preconfigured addresses for specific names, or resolve and return the IP address of other names. This can be used for local development as well as to enforce safe search results on Google, Yahoo and Bing.
- Automatic background updates of resolvers lists
- Can force outgoing connections to use TCP
- Supports SOCKS proxies
- Compatible with DNSSEC